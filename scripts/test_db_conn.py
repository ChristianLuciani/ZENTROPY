"""
ZENTROPY — Stage 0: Handshake
Scripts de dev usan SERVICE KEY (admin local).
La app usará SUPABASE_KEY (publishable) con auth real.
"""
import os, sys
from dotenv import load_dotenv
from supabase import create_client, Client
from rich.console import Console
from rich.table import Table
from rich import print as rprint

load_dotenv()
console = Console()

def test_connection():
    url         = os.getenv("SUPABASE_URL")
    service_key = os.getenv("SUPABASE_SERVICE_KEY")
    uid         = os.getenv("NEXOS_USER_ID")

    if not url or not service_key:
        rprint("[red]❌ SUPABASE_URL o SUPABASE_SERVICE_KEY no encontradas en .env[/red]")
        sys.exit(1)

    rprint("\n[bold cyan]🌀 ZENTROPY — Database Handshake v0.2[/bold cyan]")
    rprint("[dim]   Modo: admin/dev (service key) — scripts locales únicamente[/dim]\n")

    try:
        supabase: Client = create_client(url, service_key)
        rprint("[green]✅ Cliente Supabase inicializado[/green]\n")

        # Tablas core
        core_tables = ["profiles", "entities", "content_atoms", "missions", "adr_logs"]
        t = Table(title="📊 Tablas Core")
        t.add_column("Tabla", style="cyan")
        t.add_column("Estado", style="green")
        t.add_column("Registros", justify="right")

        for table in core_tables:
            try:
                res = supabase.table(table).select("*", count="exact").limit(1).execute()
                t.add_row(table, "✅ OK", str(res.count if res.count is not None else "?"))
            except Exception as e:
                t.add_row(table, "❌ Error", str(e)[:40])

        console.print(t)

        # Verificar cluciani
        rprint(f"\n[bold]🔍 Verificando tenant: cluciani[/bold]")

        # Por UUID si está definido
        if uid:
            res = supabase.table("profiles").select("*").eq("id", uid).execute()
        else:
            res = supabase.table("profiles").select("*").eq("username", "cluciani").execute()

        if res.data:
            p = res.data[0]
            rprint(f"[green]✅ Tenant encontrado[/green]")
            rprint(f"   username  : [cyan]{p.get('username')}[/cyan]")
            rprint(f"   full_name : [cyan]{p.get('full_name')}[/cyan]")
            rprint(f"   id        : [bold cyan]{p.get('id')}[/bold cyan]")
            if not uid:
                rprint(f"\n[bold yellow]👆 Agrega a tu .env:[/bold yellow]")
                rprint(f"[bold]NEXOS_USER_ID={p.get('id')}[/bold]")
        else:
            rprint("[red]❌ Perfil no encontrado — ejecuta: python scripts/seed_tenant.py[/red]")

        rprint("\n[bold green]" + "=" * 50 + "[/bold green]")
        rprint("[bold green]✅ HANDSHAKE COMPLETO — Listo para Etapa 1[/bold green]")
        rprint("[bold green]" + "=" * 50 + "[/bold green]\n")

    except Exception as e:
        rprint(f"[red]❌ Error: {e}[/red]")
        sys.exit(1)

if __name__ == "__main__":
    test_connection()
