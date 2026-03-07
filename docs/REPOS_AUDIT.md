# 🗂️ REPOS AUDIT — Cartografía de Proyectos NEXOS
> Proceso de destilación de repositorios GitHub
> Criterios: Consolidar | Rescatar | Archivar | Eliminar | Priorizar

## 🧭 Criterios de Clasificación

| Estado | Emoji | Definición |
|--------|-------|------------|
| ACTIVO | 🟢 | Desarrollo en curso, commits recientes |
| RESCATAR | 🟡 | Valor real, necesita retomar |
| CONSOLIDAR | 🔵 | Fusionar con otro repo relacionado |
| ARCHIVAR | 🟠 | Preservar como referencia, sin desarrollo |
| ELIMINAR | 🔴 | Sin valor, duplicado o abandonado definitivamente |

---

## 📦 Cuenta Personal: ChristianLuciani

### Módulos NEXOS Core
| Repo | Clasificación | Módulo NEXOS | Notas | Acción |
|------|--------------|--------------|-------|--------|
| NEXOS | 🟢 ACTIVO | OS base | Monorepo con apps/sis, apps/orchestrator | Mantener |
| ZENTROPY | 🟢 ACTIVO | CIA | Recién creado, operacional | Mantener |
| FINEXOS | 🟡 RESCATAR | ERP | Reconstruir sobre Kontablo | Refactor mayor |
| FINEXOS-CONNECT | 🔴 ELIMINAR | — | Reemplazado por nueva arquitectura | Archivar → eliminar |
| accounting-esperanto | 🟢 ACTIVO | Kontablo | Investigación activa, bien estructurado | Mantener |
| CLApps | 🟢 ACTIVO | CLAPPS | Cliente activo, ingreso real | Prioridad alta |
| universal_cv_engine | 🟢 ACTIVO | UCVE | Schema en producción | Mantener |

### PKM / Conocimiento
| Repo | Clasificación | Notas | Acción |
|------|--------------|-------|--------|
| synapse-arc | 🟢 ACTIVO | PKM personal, bitácora activa | Mantener |
| MyNotes | 🟠 ARCHIVAR | ¿Qué hay aquí? | Revisar → archivar |
| Personal-Knowlege-System | 🔵 CONSOLIDAR | Posible duplicado de synapse-arc | Fusionar con synapse-arc |
| Synapse_CoR | 🟡 RESCATAR | ¿Relacionado con synapse-arc? | Revisar |

### Académico / Investigación
| Repo | Clasificación | Notas | Acción |
|------|--------------|-------|--------|
| BOOK-LABFISING1 | 🟠 ARCHIVAR | Libro física lab USFQ | Archivar |
| ChristianLuciani-LABFISICAUSFQ | 🟠 ARCHIVAR | Labs física | Archivar |
| LABFISICAUSFQ | 🟠 ARCHIVAR | Duplicado? | Consolidar o archivar |
| FISING1-* (múltiples) | 🟠 ARCHIVAR | Material curso física | Archivar grupo |
| Delay-Random-Walk | 🟠 ARCHIVAR | Investigación física | Archivar |
| Waves-through-RLC-Series-Circuit | 🟠 ARCHIVAR | Lab física | Archivar |
| NOOS | 🟡 RESCATAR | Framework sistemas complejos | Activo en NEXOS/docs |
| orquestador_sistematico_prompts | 🔵 CONSOLIDAR | Prompt engineering | Mover a synapse-arc o ZENTROPY |

### Web / Portfolio Personal
| Repo | Clasificación | Notas | Acción |
|------|--------------|-------|--------|
| christian-luciani | 🟠 ARCHIVAR | Portfolio Jekyll | ¿Activo o reemplazar? |
| CVLESSPROYECT | 🔴 ELIMINAR | CV antiguo | Archivar |
| cv-cluciani | 🔵 CONSOLIDAR | CV → usar UCVE en su lugar | Archivar cuando UCVE esté listo |
| clux | 🟡 REVISAR | ¿Qué es esto? | Revisar |
| physics-lab-book | 🟠 ARCHIVAR | Blog Jekyll física | Archivar |

### Proyectos Externos / Clientes
| Repo | Clasificación | Notas | Acción |
|------|--------------|-------|--------|
| angel-aidi | 🟡 RESCATAR | Proyecto Angel — AIDI | Revisar estado |
| angel-cashbox-sys | 🔴 ELIMINAR | ¿Duplicado? | Consolidar con angel-cashbox-system |
| angel-cashbox-system | 🟡 RESCATAR | Sistema caja Angel | Revisar |
| grupo-angel-apps | 🟢 ACTIVO | Apps Grupo Angel | Mantener |
| neuroaprendiz-ai | 🟡 RESCATAR | Proyecto educativo IA | Revisar viabilidad |
| PROYECTO-DRAHMAN-TESTEFORK | 🟠 ARCHIVAR | Fork de prueba | Archivar |

### Herramientas / Templates
| Repo | Clasificación | Notas | Acción |
|------|--------------|-------|--------|
| Docs-Manager | 🟡 REVISAR | ¿Activo? | Revisar |
| LI-Learning-Interface | 🟡 REVISAR | Interface de aprendizaje | Revisar |
| LoginSystem | 🔴 ELIMINAR | Sistema login antiguo | Archivar/eliminar |
| Monitor-Inventory | 🟡 REVISAR | ¿Activo? | Revisar |
| matrix_access_control | 🟡 REVISAR | Control acceso | Revisar |
| CRUD-Example | 🔴 ELIMINAR | Ejemplo tutorial | Eliminar |
| ud845-Pets | 🔴 ELIMINAR | Tutorial Android antiguo | Eliminar |

---

## 📊 Resumen Ejecutivo (pendiente completar)

```
Total repos revisados:    __/__
🟢 Activos:               __
🟡 A rescatar:            __
🔵 A consolidar:          __
🟠 A archivar:            __
🔴 A eliminar:            __
```

---

## 🗺️ Mapa de Prioridad de Ejecución

```
PRIORIDAD 1 (Esta semana):
  └─ ZENTROPY (operacional) ✅
  └─ CLAPPS (cliente activo)
  └─ UCVE (identidad profesional)

PRIORIDAD 2 (Este mes):
  └─ KONTABLO (base de FINEXOS)
  └─ FINEXOS (reconstrucción)
  └─ synapse-arc (PKM)

PRIORIDAD 3 (Este trimestre):
  └─ NOOS (investigación)
  └─ neuroaprendiz-ai
  └─ Limpiar repos académicos

ARCHIVO PERMANENTE:
  └─ Todos los repos FISING1-*
  └─ Labs física USFQ
  └─ Proyectos tutorial
```

---

## 📜 Proceso de Cierre de Repo

```bash
# Para cada repo a archivar:
# 1. Verificar que no hay datos únicos sin backup
# 2. En GitHub: Settings → scroll down → "Archive this repository"
# 3. Actualizar este archivo
# 4. Actualizar NEXOS_MANIFEST.md

# Para repos a ELIMINAR (IRREVERSIBLE - confirmar dos veces):
# 1. Verificar que está archivado primero
# 2. Settings → Delete this repository
# 3. Actualizar registro
```