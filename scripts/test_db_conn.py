"""
ZENTROPY — Stage 0: Database Handshake
Valida: conexión, versión Postgres, pgvector, tablas existentes.
"""
import os
import sys
import psycopg2
from dotenv import load_dotenv

load_dotenv()

def test_connection():
    db_url = os.getenv("SUPABASE_DB_URL")
    if not db_url:
        print("❌ SUPABASE_DB_URL no encontrada en .env")
        sys.exit(1)

    print("🔌 Intentando conexión a Supabase...\n")
    try:
        conn = psycopg2.connect(db_url)
        cur = conn.cursor()

        # Test 1: Versión
        cur.execute("SELECT version();")
        version = cur.fetchone()[0]
        print(f"✅ Conexión exitosa")
        print(f"   └─ {version.split(',')[0]}\n")

        # Test 2: pgvector
        cur.execute("SELECT extname, extversion FROM pg_extension WHERE extname = 'vector';")
        vec = cur.fetchone()
        if vec:
            print(f"✅ pgvector v{vec[1]} instalado\n")
        else:
            print("⚠️  pgvector NO instalado — necesario para RAG semántico")
            print("   └─ Activar en: Supabase Dashboard > Extensions > vector\n")

        # Test 3: Tablas del schema NEXOS
        cur.execute("""
            SELECT table_name 
            FROM information_schema.tables 
            WHERE table_schema = 'public' 
            ORDER BY table_name;
        """)
        tables = [row[0] for row in cur.fetchall()]
        print(f"📊 Tablas encontradas en public ({len(tables)}):")
        for t in tables:
            print(f"   ✓ {t}")
        print()

        # Test 4: Verificar content_atoms (tabla core de Zentropy)
        cur.execute("SELECT COUNT(*) FROM content_atoms;")
        count = cur.fetchone()[0]
        print(f"🧠 content_atoms: {count} registros existentes\n")

        cur.close()
        conn.close()
        print("=" * 50)
        print("✅ HANDSHAKE COMPLETO — Listo para Etapa 1")
        print("=" * 50)
        return True

    except Exception as e:
        print(f"❌ Error de conexión: {e}")
        print("\nVerifica:")
        print("  1. El password en SUPABASE_DB_URL")
        print("  2. Que tu IP no esté bloqueada en Supabase")
        sys.exit(1)

if __name__ == "__main__":
    test_connection()
