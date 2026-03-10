# Templates de Repositorio — ZENTROPY

> Sistema jerárquico de templates que implementa ADR-O-003.
> Cada template "nace maduro" — responde todas las preguntas de madurez nivel 2
> desde el primer commit, mediante prompts activadores.

## Uso

```bash
# Crear un nuevo repositorio desde terminal
cd ZENTROPY
./scripts/new-repo.sh
```

El script interactivo:
1. Pregunta nombre, tipo, contexto, descripción, proyecto padre
2. Copia el template correcto con herencia aplicada
3. Personaliza todos los archivos con el nombre del proyecto
4. Inicializa git y crea el repo en GitHub
5. Crea el issue inicial en Mission Control

## Jerarquía de herencia

```
BASE (todos los repos)
 ├── INVESTIGACIÓN
 ├── IDENTIDAD
 ├── HERRAMIENTA
 │    └── PRODUCTO
 │         └── SISTEMA (más completo)
```

Los templates se componen en capas. SISTEMA incluye todo lo de PRODUCTO,
que incluye todo lo de HERRAMIENTA, que incluye todo lo de BASE.

## Archivos por template

### BASE (universal)
| Archivo | Propósito |
|---------|-----------|
| `README.md` | Qué es, por qué existe, para quién, cómo empezar |
| `ESTADO.md` | Próximo paso, bloqueantes, DoD — la brújula operativa |
| `CLASIFICACION.yml` | Contrato legible por máquina para MNENTROPY |
| `.gitignore` | Configurado para Python, Node, macOS, IDEs |
| `.env.example` | Variables de entorno requeridas documentadas |
| `docs/CONTRIBUTING.md` | Convenciones de ramas y commits |
| `docs/adr/ADR-000-template.md` | Template para decisiones arquitectónicas |

### INVESTIGACIÓN (+ BASE)
| Archivo | Propósito |
|---------|-----------|
| `INDICE.md` | Mapa del conocimiento acumulado |
| `docs/PREGUNTA.md` | La hipótesis central — no avanzar sin completarla |
| `docs/HALLAZGOS.md` | Registro acumulativo de conclusiones |
| `docs/REFERENCIAS.md` | Fuentes y bibliografía |
| `docs/METODOLOGIA.md` | Cómo investigamos |

### HERRAMIENTA (+ BASE)
| Archivo | Propósito |
|---------|-----------|
| `CHANGELOG.md` | Historial de versiones |
| `docs/API.md` | Interfaz pública documentada |
| `tests/smoke.test.md` | Tests mínimos de funcionamiento |

### PRODUCTO (+ HERRAMIENTA + BASE)
| Archivo | Propósito |
|---------|-----------|
| `docs/USER_STORIES.md` | Para quién y para qué |
| `docs/ROADMAP.md` | Visión y fases del producto |
| `docs/specs/SPEC-000-template.md` | Template de especificación funcional |

### SISTEMA (+ PRODUCTO + HERRAMIENTA + BASE)
| Archivo | Propósito |
|---------|-----------|
| `docs/ARCHITECTURE.md` | Cómo está construido y por qué |
| `docs/RUNBOOK.md` | Operaciones, diagnóstico, setup |

### IDENTIDAD (+ BASE)
| Archivo | Propósito |
|---------|-----------|
| `CONTENIDO.md` | Inventario y vigencia del contenido |
| `assets/` | Recursos visuales reutilizables |

## Principio de los prompts activadores

Cada archivo del template contiene comentarios `<!-- PROMPT: ... -->` que:
- Formulan preguntas específicas que obligan a reflexionar
- Explican el propósito de cada sección
- Dan ejemplos de respuestas buenas vs malas
- Se eliminan una vez completados

**Un repo con prompts sin responder = nivel de madurez 0.**
**Un repo con todos los prompts respondidos = nivel de madurez 2 mínimo garantizado.**

## Temperatura inicial

Todos los repos nuevos inician a `373 K` (umbral ACTIVO).
MNENTROPY actualizará la temperatura automáticamente desde el git log.
