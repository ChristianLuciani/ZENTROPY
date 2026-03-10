# Guía de Contribución — [NOMBRE]

> Todo trabajo en este repo — humano o agente IA — sigue estas convenciones.

## Workflow de ramas

Leer `AGENTS.md` o `CLAUDE.md` en la raíz del repo para el protocolo completo.

```bash
# Antes de cualquier trabajo
git checkout main && git pull origin main

# Crear rama según quién trabaja
git checkout -b claude/[número-issue]-[descripción]   # Claude
git checkout -b cursor/[número-issue]-[descripción]   # Cursor / IDE
git checkout -b gemini/[número-issue]-[descripción]   # Gemini / Antigravity
git checkout -b feature/[descripción]                 # Humano
```

**Nunca push directo a `main`. Siempre PR.**

## Commits

Formato: `tipo(scope): descripción en imperativo`

```
tipo: feat | fix | docs | refactor | test | chore | style
scope: componente afectado (opcional)
```

Ejemplos:
```
feat(agents): implementar pipeline de ingestión en MNENTROPY
fix(db): corregir schema zentropia en migration 002
docs(adr): agregar ADR-003 separación de agentes
```

Si trabajó un agente IA, incluir co-autoría:
```bash
git commit -m "feat(scope): descripción

Co-authored-by: Claude <claude@anthropic.com>"
```

## Issues y Mission Control

1. Crear issue en Mission Control antes de empezar
2. Usar template en `.github/ISSUE_TEMPLATE/`
3. Vincular la rama al issue
4. Mover a ⚡ ACTIVO al empezar, 👁️ REVISIÓN al hacer PR

## Actualizar ESTADO.md

Al cerrar un PR, verificar si ESTADO.md necesita actualización:
- ¿Cambió el "próximo paso"?
- ¿Se resolvió algún bloqueante?
- ¿Se generó nueva deuda técnica?
