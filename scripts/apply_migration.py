"""
ZENTROPY — Aplicar migración SQL via service key
Uso: python scripts/apply_migration.py database/migrations/001_zentropia_schema.sql
"""
import os, sys
from dotenv import load_dotenv
from supabase import create_client
from rich import print as rprint

load_dotenv()

def apply(sql_file: str):
    url = os.getenv("SUPABASE_URL")
    key = os.getenv("SUPABASE_SERVICE_KEY")

    if not os.path.exists(sql_file):
        rprint(f"[red]❌ Archivo no encontrado: {sql_file}[/red]")
        sys.exit(1)

    with open(sql_file) as f:
        sql = f.read()

    rprint(f"\n[bold cyan]📦 Aplicando migración: {sql_file}[/bold cyan]\n")

    try:
        supabase = create_client(url, key)
        # Ejecutar via RPC raw SQL
        supabase.rpc("exec_sql", {"query": sql}).execute()
        rprint("[green]✅ Migración aplicada[/green]")
    except Exception as e:
        rprint(f"[red]❌ Error: {e}[/red]")
        rprint("\n[yellow]💡 Alternativa: copia el SQL y ejecútalo en:[/yellow]")
        rprint("   Supabase Dashboard → SQL Editor")
        sys.exit(1)

if __name__ == "__main__":
    sql_file = sys.argv[1] if len(sys.argv) > 1 else "database/migrations/001_zentropia_schema.sql"
    apply(sql_file)
