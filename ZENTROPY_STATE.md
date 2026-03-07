# 🌀 ZENTROPY STATE — Estado del Sistema
> Última actualización: 2026-03-07 | Actualizar tras cada sesión de trabajo

## 📍 Estado General
| Dimensión | Estado |
|-----------|--------|
| Fase actual | **Stage 1 — Captura de Cognición** |
| DB (Supabase) | ✅ Operacional — schema `zentropia` activo |
| Ingesta | ✅ Funcional — `ingest.py` probado |
| Open WebUI | ⬜ Pendiente — Stage 2 |
| Destilación | ⬜ Pendiente — Stage 3 |
| Multi-tenancy | 🟡 Diseñado, no implementado |

## ✅ Completado
- [x] Repo `ZENTROPY` creado en GitHub (rama `main`)
- [x] Conexión Supabase via `supabase-py 2.24` + service key
- [x] Schema `zentropia` en NEXOS_DB (sessions, messages, insights)
- [x] Tenant principal `cluciani` creado en `public.profiles`
- [x] `ingest.py` — parser universal Claude JSON/ZIP + ChatGPT + Markdown
- [x] Primera sesión ingresada (esta conversación — 54 mensajes)
- [x] `.gitignore` correcto — secrets protegidos

## 🔄 En Progreso
- [ ] Exportar e ingestar historial completo de Claude.ai
- [ ] Exportar e ingestar historial de ChatGPT
- [ ] Cerrar otras herramientas IA tras exportar

## ⬜ Backlog Ordenado por Prioridad
1. **Stage 2** — Open WebUI local (puerto 3010)
2. **Stage 2** — Conectar Open WebUI a OpenRouter
3. **Stage 3** — `distill_chat.py` — destilar sesiones en insights
4. **Stage 3** — `distill_repos.py` — auditoría y mapa de repositorios GitHub
5. **Stage 4** — GitHub Projects como task manager central
6. **Stage 4** — API/Edge Functions en TypeScript (Supabase)
7. **Stage 5** — Frontend web (acceso móvil)
8. **Stage 5** — Multi-tenancy público

## 📊 Métricas Actuales
| Tabla | Registros |
|-------|-----------|
| zentropia.sessions | 1 |
| zentropia.messages | 54 |
| zentropia.insights | 0 |
| public.profiles | 1 (cluciani) |

## 🚨 Deuda Técnica Conocida
| ID | Descripción | Impacto | Prioridad |
|----|-------------|---------|-----------|
| DT-001 | `profiles.id` no vinculado a `auth.uid()` de Supabase Auth | Bloquea RLS real con publishable key | Alta |
| DT-002 | No hay `tenant_id` explícito para multi-tenancy | Refactor mayor al escalar | Media |
| DT-003 | `ingest.py` no guarda URL de conversación | Pérdida de referencia | Baja |
| DT-004 | Schema `public` (UCVE) mezclado en NEXOS_DB | Entropía conceptual | Media |

## 🔐 Variables de Entorno Requeridas
```
SUPABASE_URL              ✅ configurado
SUPABASE_KEY              ✅ configurado (publishable)
SUPABASE_SERVICE_KEY      ✅ configurado (solo scripts dev)
NEXOS_USER_ID             ✅ configurado (UUID cluciani)
```