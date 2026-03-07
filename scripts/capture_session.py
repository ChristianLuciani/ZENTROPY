"""
ZENTROPY — Captura una conversación IA y la persiste en zentropia.sessions + messages
Uso: python scripts/capture_session.py

El archivo de conversación debe ser un JSON con formato:
[
  {"role": "user", "content": "..."},
  {"role": "assistant", "content": "..."}
]
"""
import os, sys, json
from datetime import datetime
from dotenv import load_dotenv
from supabase import create_client
from rich import print as rprint
from rich.prompt import Prompt, Confirm
from rich.table import Table
from rich.console import Console

load_dotenv()
console = Console()

PROJECTS = ['nexos', 'zentropy', 'finexos', 'noos', 'clapps', 'ucve', 'kontablo', 'general']
PROVIDERS = ['claude', 'chatgpt', 'gemini', 'cursor', 'windsurf', 'other']

def count_tokens_approx(text: str) -> int:
    """Aproximación: 1 token ≈ 4 caracteres"""
    return len(text) // 4

def capture(json_file: str = None):
    url     = os.getenv("SUPABASE_URL")
    key     = os.getenv("SUPABASE_SERVICE_KEY")
    user_id = os.getenv("NEXOS_USER_ID")

    if not all([url, key, user_id]):
        rprint("[red]❌ Faltan variables en .env[/red]")
        sys.exit(1)

    supabase = create_client(url, key)

    rprint("\n[bold cyan]🌀 ZENTROPY — Captura de Sesión[/bold cyan]\n")

    # --- Metadata de la sesión ---
    title    = Prompt.ask("[cyan]Título de la sesión[/cyan]",
                          default=f"Sesión {datetime.now().strftime('%Y-%m-%d %H:%M')}")
    provider = Prompt.ask("[cyan]Proveedor IA[/cyan]",
                          choices=PROVIDERS, default="claude")
    model    = Prompt.ask("[cyan]Modelo[/cyan]",
                          default="claude-sonnet-4-6")
    tags_raw = Prompt.ask("[cyan]Tags de contexto (separados por coma)[/cyan]",
                          default="nexos,zentropy")
    tags     = [t.strip() for t in tags_raw.split(",") if t.strip()]
    project  = Prompt.ask("[cyan]Proyecto principal[/cyan]",
                          choices=PROJECTS, default="zentropy")

    # --- Cargar mensajes ---
    messages = []
    if json_file and os.path.exists(json_file):
        with open(json_file) as f:
            messages = json.load(f)
        rprint(f"\n[green]📂 Cargados {len(messages)} mensajes desde {json_file}[/green]")
    else:
        rprint("\n[yellow]💡 No se proporcionó archivo JSON.[/yellow]")
        rprint("   Puedes capturar mensajes manualmente o usar:")
        rprint("   [dim]python scripts/capture_session.py mi_conversacion.json[/dim]\n")

        add_manual = Confirm.ask("¿Agregar mensajes manualmente ahora?", default=False)
        if add_manual:
            rprint("[dim]Ingresa mensajes. Role: 'user' o 'assistant'. Vacío para terminar.[/dim]\n")
            while True:
                role = Prompt.ask("  role", choices=["user", "assistant", ""], default="")
                if not role:
                    break
                content = Prompt.ask("  content")
                messages.append({"role": role, "content": content})

    if not messages:
        rprint("[yellow]⚠️  Sin mensajes. Creando sesión vacía para uso futuro.[/yellow]")

    # --- Preview ---
    rprint(f"\n[bold]📋 Resumen a guardar:[/bold]")
    rprint(f"   Título   : [cyan]{title}[/cyan]")
    rprint(f"   Proveedor: [cyan]{provider} / {model}[/cyan]")
    rprint(f"   Tags     : [cyan]{tags}[/cyan]")
    rprint(f"   Proyecto : [cyan]{project}[/cyan]")
    rprint(f"   Mensajes : [cyan]{len(messages)}[/cyan]")

    if not Confirm.ask("\n¿Guardar en Supabase?", default=True):
        rprint("[yellow]Cancelado.[/yellow]")
        return

    # --- Crear sesión ---
    session_res = supabase.schema("zentropia").table("sessions").insert({
        "user_id":      user_id,
        "title":        title,
        "provider":     provider,
        "model":        model,
        "context_tags": tags,
        "status":       "active",
        "metadata":     {"project": project, "captured_at": datetime.now().isoformat()}
    }).execute()

    session_id = session_res.data[0]["id"]
    rprint(f"\n[green]✅ Sesión creada:[/green] [dim]{session_id}[/dim]")

    # --- Insertar mensajes ---
    if messages:
        msg_rows = []
        for m in messages:
            msg_rows.append({
                "session_id":  session_id,
                "user_id":     user_id,
                "role":        m.get("role", "user"),
                "content":     m.get("content", ""),
                "token_count": count_tokens_approx(m.get("content", "")),
                "metadata":    {}
            })

        # Insertar en batches de 50
        batch_size = 50
        total = 0
        for i in range(0, len(msg_rows), batch_size):
            batch = msg_rows[i:i+batch_size]
            supabase.schema("zentropia").table("messages").insert(batch).execute()
            total += len(batch)
            rprint(f"   💾 Insertados {total}/{len(msg_rows)} mensajes...")

        rprint(f"[green]✅ {len(msg_rows)} mensajes guardados[/green]")

    # --- Resumen final ---
    rprint(f"\n[bold green]{'=' * 50}[/bold green]")
    rprint(f"[bold green]✅ SESIÓN CAPTURADA EN ZENTROPIA[/bold green]")
    rprint(f"[bold green]{'=' * 50}[/bold green]")
    rprint(f"\n   session_id : [bold cyan]{session_id}[/bold cyan]")
    rprint(f"\n[dim]Próximo paso: extrae insights con[/dim]")
    rprint(f"[dim]python scripts/add_insight.py {session_id}[/dim]\n")

if __name__ == "__main__":
    json_file = sys.argv[1] if len(sys.argv) > 1 else None
    capture(json_file)
