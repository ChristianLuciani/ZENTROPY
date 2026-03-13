# Investigación: Masa Semántica — Fórmula de Peso para Nodos de MNENTROPY
**Fecha:** 2026-03-12  
**Origen:** Sesión filosófica Gemini → destilación técnica  
**Para:** Spec de MNENTROPY (sesión siguiente)  
**Decisión pendiente:** ADR-I-007 (Claridad Atómica) + ADR-I-008 (Conservación de la Señal)

---

## El Insight

De la investigación filosófica sobre Zentropo emerge una fórmula
para calcular el peso de cada nodo cognitivo — más precisa que la
fórmula de Mem0 porque incluye un término de validación biológica explícita.

---

## Fórmula de Masa Semántica M(nodo)

```python
M = α*F + β*C + γ*V + δ*R

F = frecuencia_en_conversaciones    # float 0-1, normalizado
C = grado_en_grafo                  # número de conexiones, normalizado
V = validacion_biologica            # float 0-1 (ver detalle abajo)
R = recencia                        # e^(-λ*Δt), λ=constante Ebbinghaus

# Pesos iniciales (ajustar tras 30 días de datos reales)
α, β, γ, δ = 0.25, 0.35, 0.30, 0.10
```

**V (validación biológica)** — el término que diferencia ZENTROPY:

```python
def calcular_V(nodo_id: str) -> float:
    señales = {
        "commit_semantico_menciona_nodo": 0.4,   # git log menciona el concepto
        "estado_md_menciona_nodo": 0.3,           # ESTADO.md actualizado con él
        "pr_merged_relacionado": 0.2,             # PR vinculado al concepto
        "correccion_explicita_usuario": 0.8,      # override manual — mayor peso
    }
    # V = suma de señales presentes, capped at 1.0
```

**Por qué V es diferente a los frameworks existentes:**
En Mem0/LangMem, importance se calcula algorítmicamente.
En ZENTROPY, el humano puede validar con acciones reales.
La voluntad biológica tiene veto sobre la inferencia estadística —
esto implementa la "Conservación de la Señal" del Protocolo Zentropy.

---

## Dinámica de Arcos — Potenciación y Poda

Los arcos entre nodos no son booleanos — son pesos float:

```python
# Potenciación (LTP): dos nodos co-ocurren en consolidación
peso_arco += 0.1 * min(M(nodo_a), M(nodo_b))

# Poda: arco inactivo por > umbral_días
if días_sin_activacion > umbral_poda:
    peso_arco *= factor_decaimiento  # factor < 1
    if peso_arco < umbral_eliminacion:
        eliminar_arco()
```

---

## Fragmentación por Claridad Atómica

Criterio operacional para cuando MNENTROPY debe fragmentar un nodo:

```python
def debe_fragmentar(nodo) -> bool:
    return (
        len(nodo.content.split('.')) > 3  # más de 3 oraciones
        or nodo.tipo == "compuesto"        # detectado como múltiples conceptos
        or nodo.ambiguedad_score > 0.6     # LLM detecta ambigüedad
    )
```

---

## Implicaciones para el Schema

El schema de `cognitive_nodes` necesita los siguientes campos nuevos:

```sql
ALTER TABLE zentropia.cognitive_nodes ADD COLUMN IF NOT EXISTS
  masa_semantica     FLOAT DEFAULT 0.5,
  frecuencia         FLOAT DEFAULT 0.0,
  grado_grafo        INTEGER DEFAULT 0,
  validacion_bio     FLOAT DEFAULT 0.0,
  ultima_activacion  TIMESTAMPTZ DEFAULT NOW();

-- Tabla de arcos ponderados (nueva)
CREATE TABLE IF NOT EXISTS zentropia.cognitive_edges (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  nodo_a      UUID REFERENCES zentropia.cognitive_nodes(id),
  nodo_b      UUID REFERENCES zentropia.cognitive_nodes(id),
  peso        FLOAT DEFAULT 0.1,
  tipo_relacion TEXT,
  ultima_activacion TIMESTAMPTZ DEFAULT NOW()
);
```

---

## Para el Spec de MNENTROPY

En la sesión de spec, incorporar:
1. La fórmula M(nodo) como función en `agents/shared/scoring.py`
2. La tabla `cognitive_edges` como migration 003
3. El proceso de fragmentación en el nodo DESTILADOR del StateGraph
4. La validación biológica como evento que puede dispararse desde:
   - git hooks (post-commit)
   - ESTADO.md watcher
   - Manual override via CLI
