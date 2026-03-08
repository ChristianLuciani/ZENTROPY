# ADR-001 — Abstracción de proveedor LLM
> Estado: ACEPTADO | Fecha: 2026-03-08

## Contexto
ZENTROPY consume LLMs en dos contextos: interfaz conversacional (Open WebUI) y agentes internos (MNENTROPY, VECTROPY). OpenRouter como único proveedor crea vendor lock-in.

## Decisión
**LiteLLM como capa de abstracción para llamadas programáticas de los agentes.**
Open WebUI mantiene conexión directa con OpenRouter (configuración nativa).

## Arquitectura
```
Open WebUI  → OpenRouter → [modelos cloud]        # interfaz humana
MNENTROPY   → LiteLLM   → Ollama (local, default) # agentes
VECTROPY    → LiteLLM   → OpenRouter (fallback)
```

## Alternativas descartadas
| Opción | Motivo de descarte |
|---|---|
| OpenRouter directo en agentes | Vendor lock-in |
| Ollama directo | API no-standard, menos flexibilidad |
| Interfaz custom propia | Costo de mantenimiento injustificado |

## Implementación
```python
# agents/shared/llm_client.py
import litellm

def get_completion(prompt: str, model: str = "ollama/llama3.2") -> str:
    response = litellm.completion(
        model=model,
        messages=[{"role": "user", "content": prompt}]
    )
    return response.choices[0].message.content
```

## Revisión
Cuando MNENTROPY lleve 30 días operativo.
