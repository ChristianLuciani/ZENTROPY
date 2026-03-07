# ADR-001: Fundación de Zentropy

**Fecha:** 2026-03-07  
**Estado:** Accepted

## Contexto
Las conversaciones con IA son la fuente primaria de generación de ideas
en NEXOS. Actualmente se pierden en múltiples proveedores sin persistencia.
El schema existente en Supabase (content_atoms, entities, missions) fue
creado para universal_cv_engine pero es compatible con la visión de Zentropy.

## Decisión
Reutilizar y extender el schema existente de Supabase en lugar de crear
uno nuevo. Primera extensión: añadir `tenant_id` cuando se active
multi-tenancy.

## Consecuencias
- No hay deuda técnica de migración inmediata.
- El schema de `content_atoms` (type, tags, weight_metrics JSONB) es 
  suficientemente flexible para modelar conversaciones IA.
- `entities` modelará sesiones de chat como entidades de tipo 
  `ai_conversation`.
