# ADR-003 — Separación MNENTROPY / VECTROPY
> Estado: ACEPTADO | Fecha: 2026-03-08

## Contexto
La función de "Centinela Cognitivo" fue inicialmente concebida como un agente único. Al profundizar emergió que registro/destilación y planificación/priorización tienen naturalezas opuestas.

## Decisión
**Dos agentes con responsabilidades mutuamente exclusivas y comunicación unidireccional a través del grafo.**

| Dimensión | MNENTROPY | VECTROPY |
|---|---|---|
| Analogía neurológica | Hipocampo | Corteza Prefrontal |
| Orientación temporal | Pasado | Futuro |
| Input principal | Eventos del mundo | Grafo + proyectos |
| Output principal | Nodos en grafo | Brief de acciones |
| Horario | 12pm + 11pm | 7:30am + 2pm |
| Lee todo el grafo | SÍ | NO (subconjunto filtrado) |

## Principio clave
En el cerebro, hipocampo y PFC no se comunican directamente en tiempo real.
El hipocampo escribe a memoria a largo plazo; la PFC lee cuando planifica.
El grafo cognitivo es exactamente ese medio asincrónico.

## Consecuencia para el roadmap
VECTROPY es Fase 2. MNENTROPY es Fase 1.
No construir VECTROPY antes de tener ≥7 días de datos reales.
