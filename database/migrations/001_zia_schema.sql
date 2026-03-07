-- ============================================================
-- ZENTROPY INTELLIGENCE ARCHIVE (zentropia)
-- Schema para captura de cognición dialéctica con IA
-- ============================================================

CREATE SCHEMA IF NOT EXISTS zentropia;

-- ------------------------------------------------------------
-- 1. SESSIONS — Una sesión = una conversación con una IA
-- ------------------------------------------------------------
CREATE TABLE zentropia.sessions (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID NOT NULL REFERENCES public.profiles(id),
    title           TEXT,                          -- Resumen auto-generado o manual
    provider        TEXT NOT NULL,                 -- 'claude', 'chatgpt', 'gemini', 'cursor'...
    model           TEXT,                          -- 'claude-sonnet-4-6', 'gpt-4o'...
    context_tags    TEXT[]  DEFAULT '{}',          -- ['nexos','zentropy','finexos','noos']
    status          TEXT    DEFAULT 'active',      -- 'active' | 'archived' | 'distilled'
    insight_count   INTEGER DEFAULT 0,             -- Counter desnormalizado
    metadata        JSONB   DEFAULT '{}',          -- Flexibilidad para futuros campos
    created_at      TIMESTAMPTZ DEFAULT now(),
    updated_at      TIMESTAMPTZ DEFAULT now()
);

-- ------------------------------------------------------------
-- 2. MESSAGES — Mensajes individuales de la sesión
-- ------------------------------------------------------------
CREATE TABLE zentropia.messages (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    session_id      UUID NOT NULL REFERENCES zentropia.sessions(id) ON DELETE CASCADE,
    user_id         UUID NOT NULL REFERENCES public.profiles(id),
    role            TEXT NOT NULL CHECK (role IN ('user', 'assistant', 'system')),
    content         TEXT NOT NULL,
    token_count     INTEGER,                       -- Para tracking de costo
    metadata        JSONB DEFAULT '{}',
    created_at      TIMESTAMPTZ DEFAULT now()
);

-- ------------------------------------------------------------
-- 3. INSIGHTS — Conocimiento destilado de sesiones
--    El "oro" de Zentropy: ideas que NO deben perderse
-- ------------------------------------------------------------
CREATE TABLE zentropia.insights (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID NOT NULL REFERENCES public.profiles(id),
    session_id      UUID REFERENCES zentropia.sessions(id) ON DELETE SET NULL,
    title           TEXT NOT NULL,
    content         TEXT NOT NULL,
    insight_type    TEXT DEFAULT 'idea',           -- 'idea'|'decision'|'adr'|'pattern'|'todo'
    project_tag     TEXT,                          -- 'nexos'|'zentropy'|'finexos'|'noos'|'clapps'
    status          TEXT DEFAULT 'raw',            -- 'raw'|'refined'|'implemented'|'archived'
    source_range    JSONB DEFAULT '{}',            -- {start_msg_id, end_msg_id} origen exacto
    metadata        JSONB DEFAULT '{}',
    created_at      TIMESTAMPTZ DEFAULT now(),
    updated_at      TIMESTAMPTZ DEFAULT now()
);

-- ------------------------------------------------------------
-- ÍNDICES
-- ------------------------------------------------------------
CREATE INDEX idx_zentropia_sessions_user    ON zentropia.sessions(user_id);
CREATE INDEX idx_zentropia_sessions_tags    ON zentropia.sessions USING GIN(context_tags);
CREATE INDEX idx_zentropia_messages_session ON zentropia.messages(session_id);
CREATE INDEX idx_zentropia_insights_user    ON zentropia.insights(user_id);
CREATE INDEX idx_zentropia_insights_project ON zentropia.insights(project_tag);
CREATE INDEX idx_zentropia_insights_type    ON zentropia.insights(insight_type);

-- ------------------------------------------------------------
-- RLS — Activar pero permitir via service key en dev
-- ------------------------------------------------------------
ALTER TABLE zentropia.sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE zentropia.messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE zentropia.insights ENABLE ROW LEVEL SECURITY;

-- Políticas: cada usuario solo ve sus propios datos
CREATE POLICY "sessions_owner" ON zentropia.sessions
    USING (user_id = auth.uid());

CREATE POLICY "messages_owner" ON zentropia.messages
    USING (user_id = auth.uid());

CREATE POLICY "insights_owner" ON zentropia.insights
    USING (user_id = auth.uid());

-- ------------------------------------------------------------
-- COMENTARIOS (documentación en la DB)
-- ------------------------------------------------------------
COMMENT ON SCHEMA zentropia IS 'Zentropy Intelligence Archive — cognición dialéctica con IA';
COMMENT ON TABLE zentropia.sessions  IS 'Sesiones de conversación con proveedores IA';
COMMENT ON TABLE zentropia.messages  IS 'Mensajes individuales por sesión';
COMMENT ON TABLE zentropia.insights  IS 'Conocimiento destilado: ideas, decisiones, patrones';
