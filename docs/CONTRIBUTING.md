# ZENTROPY — Convención de colaboración y ramas

## Modelo de ramas

```
main                    ← producción / verdad oficial. Solo Christian hace merge.
  └── claude/[tema]     ← cambios propuestos por Claude (claude.app)
  └── cursor/[tema]     ← cambios propuestos por agente IDE (Cursor, Claude Code)
  └── feature/[tema]    ← features desarrolladas por Christian directamente
  └── fix/[tema]        ← fixes rápidos
```

## Flujo de trabajo con Claude (claude.app)

1. **Claude** trabaja siempre en rama `claude/[descripción-corta]`
2. **Claude** abre un PR hacia `main` al terminar, con descripción de cambios
3. **Christian** revisa el PR, comenta, aprueba o pide cambios
4. **Christian** hace el merge — nunca Claude

### Por qué este modelo
- `main` siempre refleja decisiones humanas validadas
- El historial de git registra exactamente quién propuso qué
- Claude puede equivocarse — el PR es el punto de revisión
- El mismo modelo aplica para agentes IDE en el futuro

## Convención de commits por autor

| Prefijo | Autor | Ejemplo |
|---|---|---|
| Sin prefijo especial | Christian | `feat(db): nueva tabla` |
| `[claude]` en body | Claude via claude.app | commit normal + `Co-authored-by: Claude <claude@anthropic.com>` |
| `[cursor]` en body | Agente IDE | idem |

## Flujo estándar para Claude

```bash
# Claude siempre empieza así:
git checkout main && git pull origin main
git checkout -b claude/[tema]

# ... hace cambios ...

git add -A
git commit -m "tipo(scope): descripción
Co-authored-by: Claude <claude@anthropic.com>"
git push origin claude/[tema]
# → Luego abre PR en GitHub hacia main
```

## PR checklist (antes de pedir merge)
- [ ] Los cambios están en rama `claude/` o `cursor/`, nunca directamente en `main`
- [ ] El PR describe exactamente qué cambió y por qué
- [ ] No hay secrets ni credenciales en el diff
- [ ] Los tests pasan (cuando existan)
