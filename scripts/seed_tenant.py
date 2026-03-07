"""
ZENTROPY — Seed: Crea perfil del tenant principal (cluciani)
USA SERVICE KEY — Solo para operaciones admin locales. Nunca en producción.
Ejecutar UNA sola vez.
"""
import os, sys
from dotenv import load_dotenv
from supabase import create_client
from rich import print as rprint

load_dotenv()

def seed():
    url = os.getenv("SUPABASE_URL")
    # Service key bypasa RLS — solo para seed admin
    service_key = os.getenv("SUPABASE_SERVICE_KEY")

    if not service_key:
        rprint("[red]❌ SUPABASE_SERVICE_KEY no encontrada en .env[/red]")
        rprint("   └─ Supabase Dashboard → Settings → API → service_role")
        sys.exit(1)

    supabase = create_client(url, service_key)
    rprint("\n[bold cyan]🌱 Seed: Tenant principal (cluciani)[/bold cyan]\n")

    # Verificar si ya existe
    existing = supabase.table("profiles").select("*").eq("username", "cluciani").execute()
    if existing.data:
        p = existing.data[0]
        rprint(f"[yellow]⚠️  Perfil ya existe[/yellow]")
        rprint(f"   id: [bold cyan]{p['id']}[/bold cyan]")
        rprint(f"\n[yellow]👆 Agrega a .env → NEXOS_USER_ID={p['id']}[/yellow]")
        return

    # Crear
    res = supabase.table("profiles").insert({
        "username": "cluciani",
        "full_name": "Christian Luciani",
        "preferences": {
            "theme": "dark",
            "default_lang": "es",
            "nexos_role": "tenant_admin",
            "timezone": "America/Panama"
        },
        "is_active": True
    }).execute()

    if res.data:
        p = res.data[0]
        rprint(f"[green]✅ Tenant creado exitosamente[/green]")
        rprint(f"   username : [cyan]{p['username']}[/cyan]")
        rprint(f"   id       : [bold cyan]{p['id']}[/bold cyan]")
        rprint(f"\n[bold yellow]👆 IMPORTANTE: agrega a .env:[/bold yellow]")
        rprint(f"[bold]NEXOS_USER_ID={p['id']}[/bold]")
    else:
        rprint("[red]❌ Error al crear perfil[/red]")
        sys.exit(1)

if __name__ == "__main__":
    seed()
