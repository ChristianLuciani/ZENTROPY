# ADR-002 — Almacenamiento del Grafo Cognitivo
> Estado: ACEPTADO | Fecha: 2026-03-08

## Contexto
El grafo cognitivo necesita: embeddings vectoriales para búsqueda semántica, relaciones tipadas entre nodos, y acceso multi-dispositivo desde agentes Python.

## Decisión
**Supabase (PostgreSQL) + pgvector como almacenamiento principal.**
Markdown solo como representación secundaria de debuggeo, no fuente de verdad.

## Schema SQL
```sql
CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE cognitive_nodes (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type                TEXT NOT NULL,
  content_raw         TEXT,
  content_distilled   TEXT,
  embedding           vector(768),
  source_system       TEXT,
  source_type         TEXT,
  source_uri          TEXT,
  author              TEXT,
  project             TEXT,
  tags                TEXT[],
  status              TEXT DEFAULT 'active',
  priority            TEXT DEFAULT 'medium',
  confidence          FLOAT,
  novelty             TEXT,
  action_required     BOOLEAN DEFAULT false,
  action_description  TEXT,
  publishable_scope   TEXT DEFAULT 'private',
  energy_cost         TEXT,
  occurred_at         TIMESTAMPTZ,
  captured_at         TIMESTAMPTZ DEFAULT now(),
  updated_at          TIMESTAMPTZ DEFAULT now(),
  version             INTEGER DEFAULT 1,
  merge_history       UUID[]
);

CREATE INDEX ON cognitive_nodes
  USING ivfflat (embedding vector_cosine_ops)
  WITH (lists = 100);

CREATE TABLE node_relations (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  source_id     UUID REFERENCES cognitive_nodes(id),
  target_id     UUID REFERENCES cognitive_nodes(id),
  relation_type TEXT,
  weight        FLOAT,
  created_at    TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE daily_digest (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  date        DATE NOT NULL,
  content     JSONB,
  created_at  TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE daily_briefs (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  date        DATE NOT NULL,
  content     JSONB,
  created_at  TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE projects (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name              TEXT NOT NULL,
  status            TEXT DEFAULT 'active',
  strategic_value   INTEGER DEFAULT 5,
  last_activity     TIMESTAMPTZ,
  description       TEXT
);
```

## Revisión
Evaluar Neo4j cuando relaciones superen 10,000 edges.
