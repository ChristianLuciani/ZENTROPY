-- ZENTROPY — Cognitive Graph Schema
-- Migration: 002_cognitive_nodes
-- Date: 2026-03-08
-- Run in: Supabase SQL Editor (Dashboard → SQL Editor → New Query)

-- ─────────────────────────────────────────────
-- 0. Enable pgvector extension
-- ─────────────────────────────────────────────
CREATE EXTENSION IF NOT EXISTS vector;

-- ─────────────────────────────────────────────
-- 1. Projects — proyectos activos con valor estratégico
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS projects (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name             TEXT NOT NULL UNIQUE,
  status           TEXT DEFAULT 'active' CHECK (status IN ('active', 'paused', 'archived')),
  strategic_value  INTEGER DEFAULT 5 CHECK (strategic_value BETWEEN 1 AND 10),
  last_activity    TIMESTAMPTZ,
  description      TEXT,
  created_at       TIMESTAMPTZ DEFAULT now()
);

-- Proyectos iniciales
INSERT INTO projects (name, strategic_value, description) VALUES
  ('ZENTROPY',  10, 'Sistema de cognición externa y soberanía cognitiva'),
  ('CLAPPS',    9,  'SaaS para clínicas — plataforma federated automation'),
  ('NOOS',      8,  'Natural Organization Operating System — consultoría de sistemas complejos'),
  ('KONTABLO',  7,  'Ontología contable universal open-source'),
  ('PERSONAL',  5,  'Desarrollo personal, reflexiones, hábitos'),
  ('RESEARCH',  6,  'Investigación académica y publicaciones')
ON CONFLICT (name) DO NOTHING;

-- ─────────────────────────────────────────────
-- 2. Cognitive Nodes — nodos del grafo de conocimiento
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS cognitive_nodes (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),

  -- Clasificación
  type                TEXT NOT NULL CHECK (type IN (
                        'insight','decision','question','error',
                        'hypothesis','pattern','task','reference','observation'
                      )),
  status              TEXT DEFAULT 'active' CHECK (status IN (
                        'active','resolved','archived','review_required','blocked'
                      )),
  priority            TEXT DEFAULT 'medium' CHECK (priority IN (
                        'critical','high','medium','low','none'
                      )),

  -- Contenido
  content_raw         TEXT,
  content_distilled   TEXT NOT NULL,
  embedding           vector(768),          -- nomic-embed-text dimensions

  -- Origen
  source_system       TEXT CHECK (source_system IN (
                        'claude_ai','open_webui','cursor','github',
                        'calendar','filesystem','browser','voice','manual'
                      )),
  source_type         TEXT CHECK (source_type IN (
                        'conversation','commit','file','event','download','note'
                      )),
  source_uri          TEXT,
  source_model        TEXT,                 -- modelo de IA si aplica

  -- Autoría
  author_type         TEXT DEFAULT 'human' CHECK (author_type IN ('human','ai','system')),
  author_id           TEXT DEFAULT 'christian',

  -- Contexto
  project             TEXT REFERENCES projects(name),
  tags                TEXT[],

  -- Métricas cognitivas
  confidence          FLOAT DEFAULT 0.8 CHECK (confidence BETWEEN 0 AND 1),
  novelty             TEXT CHECK (novelty IN ('reinforcement','extension','rupture')),
  energy_cost         TEXT CHECK (energy_cost IN ('low','medium','high')),

  -- Acción
  action_required     BOOLEAN DEFAULT false,
  action_description  TEXT,

  -- Publicabilidad
  publishable_scope   TEXT DEFAULT 'private' CHECK (publishable_scope IN (
                        'private','team','public','publication'
                      )),

  -- Temporal
  occurred_at         TIMESTAMPTZ,
  captured_at         TIMESTAMPTZ DEFAULT now(),
  updated_at          TIMESTAMPTZ DEFAULT now(),

  -- Versionado
  version             INTEGER DEFAULT 1,
  merge_history       UUID[]
);

-- Índice vectorial para búsqueda semántica
CREATE INDEX IF NOT EXISTS cognitive_nodes_embedding_idx
  ON cognitive_nodes USING ivfflat (embedding vector_cosine_ops)
  WITH (lists = 100);

-- Índices de búsqueda frecuente
CREATE INDEX IF NOT EXISTS cognitive_nodes_project_idx ON cognitive_nodes(project);
CREATE INDEX IF NOT EXISTS cognitive_nodes_type_idx ON cognitive_nodes(type);
CREATE INDEX IF NOT EXISTS cognitive_nodes_status_idx ON cognitive_nodes(status);
CREATE INDEX IF NOT EXISTS cognitive_nodes_captured_at_idx ON cognitive_nodes(captured_at DESC);
CREATE INDEX IF NOT EXISTS cognitive_nodes_tags_idx ON cognitive_nodes USING GIN(tags);

-- ─────────────────────────────────────────────
-- 3. Node Relations — edges del grafo
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS node_relations (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  source_id     UUID NOT NULL REFERENCES cognitive_nodes(id) ON DELETE CASCADE,
  target_id     UUID NOT NULL REFERENCES cognitive_nodes(id) ON DELETE CASCADE,
  relation_type TEXT NOT NULL CHECK (relation_type IN (
                  'depends_on','contradicts','extends','inspired_by',
                  'blocks','resolves','similar_to','implements'
                )),
  weight        FLOAT DEFAULT 0.5 CHECK (weight BETWEEN 0 AND 1),
  created_at    TIMESTAMPTZ DEFAULT now(),
  UNIQUE(source_id, target_id, relation_type)
);

CREATE INDEX IF NOT EXISTS node_relations_source_idx ON node_relations(source_id);
CREATE INDEX IF NOT EXISTS node_relations_target_idx ON node_relations(target_id);

-- ─────────────────────────────────────────────
-- 4. Daily Digest — output de MNENTROPY para VECTROPY
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS daily_digest (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  date            DATE NOT NULL UNIQUE,
  nodes_created   INTEGER DEFAULT 0,
  nodes_updated   INTEGER DEFAULT 0,
  nodes_merged    INTEGER DEFAULT 0,
  top_projects    TEXT[],
  action_items    JSONB DEFAULT '[]',
  summary         TEXT,
  raw_content     JSONB,
  created_at      TIMESTAMPTZ DEFAULT now()
);

-- ─────────────────────────────────────────────
-- 5. Daily Briefs — output de VECTROPY para el humano
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS daily_briefs (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  date                DATE NOT NULL UNIQUE,
  energy_forecast     TEXT CHECK (energy_forecast IN ('low','medium','high')),
  top_3               JSONB NOT NULL DEFAULT '[]',
  backlog_summary     TEXT,
  focus_recommendation TEXT,
  generated_at        TIMESTAMPTZ DEFAULT now(),
  acknowledged_at     TIMESTAMPTZ    -- cuando el humano lo marcó como leído
);

-- ─────────────────────────────────────────────
-- 6. Trigger: actualizar updated_at automáticamente
-- ─────────────────────────────────────────────
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER cognitive_nodes_updated_at
  BEFORE UPDATE ON cognitive_nodes
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ─────────────────────────────────────────────
-- 7. Función de búsqueda semántica
-- ─────────────────────────────────────────────
CREATE OR REPLACE FUNCTION search_similar_nodes(
  query_embedding vector(768),
  similarity_threshold FLOAT DEFAULT 0.75,
  max_results INTEGER DEFAULT 10,
  filter_project TEXT DEFAULT NULL
)
RETURNS TABLE (
  id UUID,
  type TEXT,
  content_distilled TEXT,
  project TEXT,
  tags TEXT[],
  similarity FLOAT,
  captured_at TIMESTAMPTZ
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    n.id,
    n.type,
    n.content_distilled,
    n.project,
    n.tags,
    1 - (n.embedding <=> query_embedding) AS similarity,
    n.captured_at
  FROM cognitive_nodes n
  WHERE
    n.embedding IS NOT NULL
    AND 1 - (n.embedding <=> query_embedding) > similarity_threshold
    AND (filter_project IS NULL OR n.project = filter_project)
  ORDER BY n.embedding <=> query_embedding
  LIMIT max_results;
END;
$$ LANGUAGE plpgsql;

-- ─────────────────────────────────────────────
-- Verificación final
-- ─────────────────────────────────────────────
SELECT 'Migration 002 completed successfully' AS status;
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_name IN ('projects','cognitive_nodes','node_relations','daily_digest','daily_briefs')
ORDER BY table_name;
