# CLAUDE.md — Adaptador para Claude (claude.ai y Claude Code)
> Extiende AGENTS.md con comportamiento específico para Claude.
> Leer AGENTS.md primero para el protocolo completo.
> Última actualización: 2026-03-09

---

## Convención de ramas para Claude

```bash
# Prefijo obligatorio: claude/
git checkout -b claude/[número-issue]-[descripción-corta]

# Commit con co-autoría:
git commit -m "tipo(scope): descripción
Co-authored-by: Claude <claude@anthropic.com>"

# Siempre PR — nunca merge directo a main
git push origin claude/[número-issue]-descripción
```

## Comportamiento específico para Claude

- Si la tarea involucra agentes MNENTROPY/VECTROPY, leer `docs/COGNITIVE_ARCHITECTURE.md`
- Si el repo tiene temperatura < 273 K (HIBERNANDO), confirmar con el usuario antes de escribir código
- Al cerrar un issue, verificar si ESTADO.md necesita actualización y proponerla
- Para operaciones de GitHub (crear issues, mover en project), usar `gh` CLI cuando sea posible

## Referencia rápida

```bash
# Crear issue estructurado
gh issue create --title "[TASK] descripción" \
  --body-file .github/ISSUE_TEMPLATE/task.md \
  --project "Mission Control"

# Ver estado del project
gh project view 5 --owner ChristianLuciani

# Ver campos disponibles
gh project field-list 5 --owner ChristianLuciani
```

> Para el protocolo completo: ver AGENTS.md
> Para el contexto del usuario activo: ver user_data/[tenant_id]/context.md
