# ADR-004 — Spec-Driven Development con OpenSpec
> Estado: ACEPTADO | Fecha: 2026-03-08

## Contexto

El trabajo con agentes de IA (Claude Code, Cursor, futuros agentes) requiere
una capa de especificación que persista entre sesiones y sea legible por cualquier agente,
independientemente del proveedor. Sin esta capa, cada sesión comienza desde cero,
duplicando el costo cognitivo de contextualizar al agente.

### El problema del vendor lock-in cognitivo
Christian opera bajo condiciones variables: dispositivos distintos, límites de API,
franjas horarias, carga cognitiva. La herramienta disponible en un momento puede no
estar disponible en otro. El contexto del proyecto no puede depender de una herramienta
específica — debe vivir en el repositorio como texto plano.

## Decisión

**Adoptar Spec-Driven Development usando OpenSpec como convención de estructura,
con las specs viviendo en `/openspec/specs/` como markdown versionado en git.**

### Principio rector: la spec es el contrato, no la herramienta
OpenSpec CLI es conveniente pero opcional. Lo que importa es la estructura:
- `openspec/specs/[capability]/spec.md` — requisitos vivos del sistema
- `openspec/changes/[change-id]/` — propuestas de cambio con proposal + tasks

Si OpenSpec CLI no está disponible (límites de red, dispositivo, tier), los specs
se crean y editan manualmente. El formato es markdown — cualquier editor funciona.

### Relación con Intent as Code
Estos paradigmas no compiten — son capas distintas:

```
CORTEX / MNENTROPY     ← por qué existe el proyecto (cognición)
      ↓
OpenSpec / Specs       ← qué debe hacer el sistema (intención)
      ↓
Claude Code / Cursor   ← cómo se construye (ejecución)
```

Intent as Code es la filosofía. OpenSpec es la implementación táctica de esa filosofía
en el repositorio. ZENTROPY ya practica Intent as Code a través de sus ADRs y
COGNITIVE_ARCHITECTURE.md — OpenSpec formaliza eso para la capa de features.

## Alternativas consideradas

| Opción | Por qué no |
|---|---|
| Solo ADRs | No granulares a nivel de feature/capability |
| CLAUDE.md / Cursor Rules | Específicos de un agente, no portables |
| Kiro (AWS) | Requiere su IDE, lock-in de herramienta |
| Sin estructura formal | Costo cognitivo alto, contexto se pierde entre sesiones |

## Estructura en el repo
```
openspec/
  specs/
    zentropy-core/spec.md        ← qué es ZENTROPY como sistema
    mnentropy/spec.md            ← cómo funciona MNENTROPY
    vectropy/spec.md             ← cómo funciona VECTROPY
    cognitive-schema/spec.md     ← el cognitive_node contract
  changes/
    [change-id]/
      proposal.md
      tasks.md
      design.md
```

## Instalación (cuando la red lo permita)
```bash
npm install -g @fission-ai/openspec@latest
cd ZENTROPY
openspec init
```

## Consecuencias
- Cualquier agente (Claude, Cursor, Copilot, Kiro) puede leer `/openspec/specs/`
- Cambiar de herramienta no requiere recontextualizar el proyecto
- El costo de crear un spec es bajo: markdown en cualquier editor
- Revisión de cambios via PR sigue el mismo modelo que el código
