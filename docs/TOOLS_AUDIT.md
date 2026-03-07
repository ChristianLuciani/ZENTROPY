# 🧹 TOOLS AUDIT — Política "Una herramienta por función"
> Proceso: Exportar → Ingestar en Zentropy → Cerrar
> Actualizar este archivo al completar cada herramienta.

## 🤖 IAs Conversacionales

| Herramienta | Estado | Acción | Completado |
|-------------|--------|--------|------------|
| **Claude** | ✅ KEEPER | Es Zentropy. Exportar periódicamente. | — |
| ChatGPT | 🔴 CERRAR | Exportar JSON → `ingest.py` → cancelar suscripción | ⬜ |
| Gemini | 🟡 REVISAR | Exportar → evaluar si hay valor único | ⬜ |
| Perplexity | 🟡 REVISAR | ¿Hay historial valioso? → exportar o cerrar | ⬜ |
| Grok | 🟡 REVISAR | ¿Uso activo? → exportar o cerrar | ⬜ |

### Cómo exportar cada IA:
- **Claude:** Settings → Privacy → Export data (ZIP) o extensión Chrome
- **ChatGPT:** Settings → Data Controls → Export data (ZIP con conversations.json)
- **Gemini:** Google Takeout → seleccionar Gemini Apps
- **Perplexity:** No tiene export nativo → copiar manualmente o scraper

---

## 📋 Task Managers

| Herramienta | Estado | Acción |
|-------------|--------|--------|
| **GitHub Projects** | ✅ KEEPER | Migrar TODO aquí | — |
| Notion | 🔴 CERRAR | Exportar Markdown → ingestar → cerrar | ⬜ |
| Linear | 🟡 REVISAR | ¿Activo? → migrar issues a GitHub Projects | ⬜ |
| Trello | 🟡 REVISAR | ¿Activo? → exportar JSON → cerrar | ⬜ |
| ClickUp | 🟡 REVISAR | ¿Activo? → migrar o cerrar | ⬜ |

---

## 📝 Notas / PKM

| Herramienta | Estado | Acción |
|-------------|--------|--------|
| **Logseq** | ✅ KEEPER | Fuente de verdad de notas locales | — |
| **synapse-arc** | ✅ KEEPER | PKM en GitHub, complementa Logseq | — |
| Notion (notas) | 🔴 CERRAR | Exportar → Logseq o Zentropy | ⬜ |
| Obsidian | 🟡 REVISAR | ¿Activo? → consolidar en Logseq | ⬜ |
| Apple Notes | 🟡 REVISAR | Exportar contenido relevante | ⬜ |

---

## 💬 Comunicaciones (Unified Inbox — Futuro módulo NEXOS)

| Canal | Estado | Acción |
|-------|--------|--------|
| Gmail principal | ✅ KEEPER | Centralizar aquí | — |
| Gmail secundarios | 🟡 REVISAR | Consolidar o cerrar | ⬜ |
| Telegram | ✅ KEEPER | Alta prioridad para Unified Inbox | — |
| WhatsApp | 🟡 INTEGRAR | Webhook → Supabase (n8n futuro) | ⬜ |
| Slack (clientes) | 🟡 INTEGRAR | Export periódico → Zentropy | ⬜ |
| Discord | 🟡 REVISAR | ¿Uso activo? | ⬜ |

---

## 🛠️ IDEs Agénticos

| Herramienta | Estado | Acción |
|-------------|--------|--------|
| Cursor | 🟡 EVALUAR | Candidato principal | ⬜ |
| Windsurf | 🟡 EVALUAR | Candidato alternativo | ⬜ |
| Antigravity | 🟡 REVISAR | Ya tienes skills descargadas | ⬜ |

**Decisión pendiente (ADR-009):** Elegir UNO entre Cursor y Windsurf.

---

## 📊 Progreso Global

```
IAs conversacionales:  1/5 cerradas  ████░░░░░░  20%
Task managers:         0/4 cerrados  ░░░░░░░░░░   0%
Notas/PKM:             0/3 cerradas  ░░░░░░░░░░   0%
Comunicaciones:        0/6 integradas░░░░░░░░░░   0%
```

---

## 📜 Log de Cierres

| Fecha | Herramienta | Mensajes exportados | Notas |
|-------|-------------|--------------------|----|
| 2026-03-07 | Claude (esta conversación) | 54 msgs | Primera sesión Zentropy ✅ |