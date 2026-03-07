"""
ZENTROPY — Ingestor Universal de Conversaciones IA
Formatos: Claude JSON (oficial), Claude ZIP (export masivo), ChatGPT JSON, Markdown

Uso:
  python scripts/ingest.py conversacion.json
  python scripts/ingest.py claude_export.zip
"""
import os, sys, json, zipfile, re
from pathlib import Path
from datetime import datetime
from dotenv import load_dotenv
from supabase import create_client
from rich import print as rprint
from rich.prompt import Prompt, Confirm
from rich.console import Console

load_dotenv()
console = Console()

# ─── Parsers ──────────────────────────────────────────────────

def extract_text_from_content(content) -> str:
    """Extrae texto de content[] que puede ser lista de bloques"""
    if isinstance(content, str):
        return content
    if isinstance(content, list):
        parts = []
        for block in content:
            if not isinstance(block, dict):
                continue
            # Bloque de texto directo
            if block.get("type") == "text":
                parts.append(block.get("text", ""))
            # Bloque con output (tool results, thinking, etc.)
            elif "text" in block:
                parts.append(block["text"])
            # Buscar en sub-listas
            elif isinstance(block.get("content"), list):
                parts.append(extract_text_from_content(block["content"]))
        return "\n".join(p for p in parts if p).strip()
    return ""


def parse_claude_json(data: dict) -> dict:
    """
    Parsea UNA conversación en formato Claude oficial:
    {uuid, name, model, chat_messages: [{sender, text, content, ...}]}
    """
    msgs = []
    for m in data.get("chat_messages", []):
        role = "user" if m.get("sender") == "human" else "assistant"

        # text puede estar vacío; content tiene los bloques reales
        content = m.get("text", "").strip()
        if not content:
            content = extract_text_from_content(m.get("content", []))

        # Incluir attachments como contexto si los hay
        attachments = m.get("attachments", [])
        if attachments:
            attach_text = "\n".join(
                f"[Attachment: {a.get('file_name','?')}]\n{a.get('extracted_content','')}"
                for a in attachments if isinstance(a, dict)
            )
            if attach_text.strip():
                content = f"{content}\n\n{attach_text}".strip()

        if content:
            msgs.append({
                "role":       role,
                "content":    content,
                "created_at": m.get("created_at", "")
            })

    return {
        "title":      data.get("name", "Sin título")[:200],
        "provider":   "claude",
        "model":      data.get("model", "unknown"),
        "messages":   msgs,
        "created_at": data.get("created_at", datetime.now().isoformat())
    }


def parse_file(file_path: str) -> list[dict]:
    """Detecta formato y retorna lista de sesiones"""
    path = Path(file_path)
    sessions = []

    # ── ZIP (export masivo de claude.ai) ──
    if path.suffix == ".zip":
        with zipfile.ZipFile(file_path) as z:
            json_files = [n for n in z.namelist() if n.endswith(".json")]
            rprint(f"[dim]ZIP contiene {len(json_files)} archivos JSON[/dim]")
            for jf in json_files:
                try:
                    data = json.loads(z.read(jf))
                    # Puede ser lista de conversaciones o una sola
                    convs = data if isinstance(data, list) else [data]
                    for conv in convs:
                        if "chat_messages" in conv:
                            s = parse_claude_json(conv)
                            if s["messages"]:
                                sessions.append(s)
                except Exception as e:
                    rprint(f"[yellow]⚠️  Saltando {jf}: {e}[/yellow]")
        return sessions

    # ── JSON ──
    if path.suffix == ".json":
        with open(file_path) as f:
            data = json.load(f)

        # Una sola conversación Claude (formato oficial)
        if isinstance(data, dict) and "chat_messages" in data:
            s = parse_claude_json(data)
            if s["messages"]:
                sessions.append(s)
            return sessions

        # Lista de conversaciones Claude
        if isinstance(data, list) and data and "chat_messages" in data[0]:
            for conv in data:
                s = parse_claude_json(conv)
                if s["messages"]:
                    sessions.append(s)
            return sessions

        # ChatGPT export
        if isinstance(data, list) and data and "mapping" in data[0]:
            for conv in data:
                msgs = []
                for node in conv.get("mapping", {}).values():
                    msg = node.get("message")
                    if not msg:
                        continue
                    role = msg.get("author", {}).get("role", "")
                    if role not in ("user", "assistant"):
                        continue
                    parts = msg.get("content", {}).get("parts", [])
                    content = "\n".join(str(p) for p in parts if p)
                    if content.strip():
                        msgs.append({"role": role, "content": content})
                if msgs:
                    sessions.append({
                        "title":    conv.get("title", "Sin título"),
                        "provider": "chatgpt",
                        "model":    "gpt",
                        "messages": msgs,
                        "created_at": datetime.fromtimestamp(
                            conv.get("create_time", datetime.now().timestamp())
                        ).isoformat()
                    })
            return sessions

    # ── Markdown ──
    if path.suffix == ".md":
        with open(file_path) as f:
            text = f.read()
        msgs = []
        pattern = re.compile(
            r'\*\*(?:Human|User|Tú|Yo)\*\*[:：]\s*(.*?)(?=\*\*(?:Assistant|Claude|AI)\*\*[:：]|\Z)',
            re.DOTALL | re.IGNORECASE
        )
        responses = re.compile(
            r'\*\*(?:Assistant|Claude|AI)\*\*[:：]\s*(.*?)(?=\*\*(?:Human|User|Tú|Yo)\*\*[:：]|\Z)',
            re.DOTALL | re.IGNORECASE
        )
        all_parts = [(m.start(), "user", m.group(1).strip()) for m in pattern.finditer(text)]
        all_parts += [(m.start(), "assistant", m.group(1).strip()) for m in responses.finditer(text)]
        all_parts.sort()
        msgs = [{"role": r, "content": c} for _, r, c in all_parts if c]
        if msgs:
            sessions.append({
                "title": path.stem.replace("_"," ").replace("-"," ").title(),
                "provider": "unknown", "model": "unknown", "messages": msgs
            })
        return sessions

    rprint(f"[red]❌ Formato no soportado: {path.suffix}[/red]")
    return []


# ─── Ingesta Supabase ──────────────────────────────────────────

def ingest(file_path: str):
    url     = os.getenv("SUPABASE_URL")
    key     = os.getenv("SUPABASE_SERVICE_KEY")
    user_id = os.getenv("NEXOS_USER_ID")

    if not all([url, key, user_id]):
        rprint("[red]❌ Faltan variables en .env (SUPABASE_URL, SUPABASE_SERVICE_KEY, NEXOS_USER_ID)[/red]")
        sys.exit(1)

    rprint(f"\n[bold cyan]🌀 ZENTROPY — Ingestor[/bold cyan]")
    rprint(f"[dim]Archivo: {file_path}[/dim]\n")

    sessions = parse_file(file_path)

    if not sessions:
        rprint("[red]❌ No se encontraron conversaciones válidas[/red]")
        sys.exit(1)

    total_msgs = sum(len(s["messages"]) for s in sessions)
    rprint(f"[green]✅ {len(sessions)} sesión(es) / {total_msgs} mensajes encontrados[/green]")

    # Preview
    for i, s in enumerate(sessions[:5]):
        rprint(f"  [cyan]{i+1}.[/cyan] {s['title'][:70]} ({len(s['messages'])} msgs, {s['provider']})")
    if len(sessions) > 5:
        rprint(f"  [dim]... y {len(sessions)-5} más[/dim]")

    # Tags y proyecto
    tags_raw = Prompt.ask("\n[cyan]Tags (separados por coma)[/cyan]", default="zentropy,nexos")
    tags     = [t.strip() for t in tags_raw.split(",") if t.strip()]
    project  = Prompt.ask("[cyan]Proyecto principal[/cyan]",
                          choices=['nexos','zentropy','finexos','noos','clapps','ucve','kontablo','general'],
                          default="zentropy")

    if not Confirm.ask(f"\n¿Ingestar {len(sessions)} sesión(es) en Supabase?", default=True):
        rprint("[yellow]Cancelado.[/yellow]")
        return

    supabase   = create_client(url, key)
    saved_s    = 0
    saved_m    = 0
    errors     = 0

    for s in sessions:
        try:
            res = supabase.schema("zentropia").table("sessions").insert({
                "user_id":      user_id,
                "title":        s["title"],
                "provider":     s["provider"],
                "model":        s.get("model", "unknown"),
                "context_tags": tags,
                "status":       "active",
                "metadata": {
                    "project":       project,
                    "ingested_at":   datetime.now().isoformat(),
                    "original_date": s.get("created_at", ""),
                    "source_file":   Path(file_path).name
                }
            }).execute()

            session_id = res.data[0]["id"]
            saved_s += 1

            rows = [{
                "session_id":  session_id,
                "user_id":     user_id,
                "role":        m["role"],
                "content":     m["content"],
                "token_count": len(m["content"]) // 4,
                "metadata":    {"original_ts": m.get("created_at","")}
            } for m in s["messages"]]

            for i in range(0, len(rows), 50):
                supabase.schema("zentropia").table("messages").insert(rows[i:i+50]).execute()
                saved_m += len(rows[i:i+50])

            rprint(f"  [green]✓[/green] {s['title'][:60]} → {len(s['messages'])} msgs")

        except Exception as e:
            rprint(f"  [red]✗[/red] {s['title'][:60]}: {e}")
            errors += 1

    rprint(f"\n[bold green]{'='*50}[/bold green]")
    rprint(f"[bold green]✅ {saved_s} sesiones / {saved_m} mensajes → zentropia[/bold green]")
    if errors:
        rprint(f"[yellow]⚠️  {errors} errores[/yellow]")
    rprint(f"[bold green]{'='*50}[/bold green]\n")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        rprint("[red]Uso: python scripts/ingest.py <archivo.json|.zip|.md>[/red]")
        sys.exit(1)
    ingest(sys.argv[1])
