"""
ZENTROPY — Stage 0: Handshake via Supabase Client v2.24
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
    url  = os.getenv("SUPABASE_URL")
    key  = os.getenv("SUPABASE_KEY")
    uid  = os.getenv("NEXOS_USER_ID")

    if not url or not key:
        rprint("[red]❌ SUPABASE_URL o SUPABASE_KEY no encontradas en .env[/red]")
        sys.exit(1)

    rprint("\n[bold cyan]🌀 ZENTROPY — Database Handshake v0.1[/bold cyan]\n")

    try:
        supabase: Client = create_client(url, key)
        rprint("[green]✅ Cliente Supabase 2.24 inicializado[/green]\n")

        # Test tablas core
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

        # Test usuario cluciani
        if uid:
            rprint(f"\n[bold]🔍 Verificando tenant: cluciani[/bold]")
            res = supabase.table("profiles").select("*").eq("id", uid).execute()
            if res.data:
                p = res.data[0]
                rprint(f"[green]✅ Tenant encontrado[/green]")
                rprint(f"   username  : [cyan]{p.get('username', 'N/A')}[/cyan]")
                rprint(f"   full_name : [cyan]{p.get('full_name', 'N/A')}[/cyan]")
                rprint(f"   id        : [dim]{p.get('id')}[/dim]")
            else:
                rprint("[yellow]⚠️  UUID no encontrado en profiles — verifica NEXOS_USER_ID[/yellow]")
        else:
            # Buscar por username como fallback
            rprint("\n[yellow]⚠️  NEXOS_USER_ID no definido — buscando por username...[/yellow]")
            res = supabase.table("profiles").select("*").eq("username", "cluciani").execute()
            if res.data:
                p = res.data[0]
                rprint(f"[green]✅ Tenant encontrado por username[/green]")
                rprint(f"   id : [bold cyan]{p.get('id')}[/bold cyan]")
                rprint(f"\n[yellow]👆 Copia ese UUID a NEXOS_USER_ID en tu .env[/yellow]")
            else:
                rprint("[red]❌ Usuario cluciani no encontrado en profiles[/red]")

        rprint("\n[bold green]" + "=" * 50 + "[/bold green]")
        rprint("[bold green]✅ HANDSHAKE COMPLETO — Listo para Etapa 1[/bold green]")
        rprint("[bold green]" + "=" * 50 + "[/bold green]\n")

    except Exception as e:
        rprint(f"[red]❌ Error: {e}[/red]")
        sys.exit(1)

if __name__ == "__main__":
    test_connection()
