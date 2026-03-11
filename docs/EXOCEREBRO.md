# El Exocerebro Agéntico — Arquitectura Cognitiva Completa
> Documento conceptual. No es código — es la visión que guía el código.
> Origen: sesión de diseño 2026-03-09 con Christian Luciani.
> Leer antes de diseñar cualquier agente nuevo.

---

## La Distinción Fundamental

Los frameworks de memoria existentes (Mem0, LangMem, Letta) resuelven:
> "El agente necesita recordar entre sesiones"
> → construyen memoria **para** el agente → el agente es más inteligente

ZENTROPY resuelve:
> "El humano necesita continuidad cognitiva entre sesiones"
> → construye memoria **del** humano, custodiada por agentes → el humano tiene más alcance

**El sujeto se invierte.** El humano es el beneficiario. Los agentes son instrumentos de custodia.

---

## Los Ejes Cognitivos

MNENTROPY y VECTROPY cubren el eje temporal (pasado ↔ futuro).
El cerebro humano opera simultáneamente en cuatro ejes:

```
EJE TEMPORAL     pasado ←→ futuro          MNENTROPY + VECTROPY ✅
EJE AFECTIVO     valencia ←→ urgencia      SENTROPY ⬜
EJE SOCIAL       yo ←→ otros               SOITROPY ⬜
EJE REGULATORIO  señal ←→ ruido            CRITROPY + HOMOTROPY ⬜
```

---

## Los 9 Agentes del Exocerebro

### MNENTROPY — El Hipocampo Digital *(Fase 1 — en desarrollo)*
**Analogía:** Hipocampo + Corteza Entorrinal
**Función:** Ingiere actividad del día → destila → persiste en grafo cognitivo
**Horario:** 12:00pm + 11:00pm (+ bajo demanda)
**Inputs:** conversaciones IA, git commits, ESTADO.md updates
**Output:** `zentropia.cognitive_nodes` + `zentropia.daily_digest`
**Pregunta que responde:** "¿Qué ocurrió cognitivamente hoy?"

### VECTROPY — La Corteza Prefrontal Digital *(Fase 1 — diseñado, bloqueado)*
**Analogía:** Corteza Prefrontal + Cíngulo Anterior
**Función:** Filtra el grafo → construye plan del día con 3 victorias concretas
**Horario:** 7:30am + 2:00pm
**Input:** subconjunto filtrado del grafo (action_required, priority:high)
**Output:** `zentropia.daily_briefs`
**Bloqueante:** requiere ≥7 días de datos reales de MNENTROPY
**Pregunta que responde:** "¿Qué hago hoy que más impulsa mis proyectos?"

### SENTROPY — La Amígdala Digital *(Fase 2)*
**Analogía:** Amígdala + Sistema Límbico + Ínsula
**Función:** Asigna valencia emocional y urgencia a los nodos cognitivos
**Input:** nodos de MNENTROPY sin clasificar afectivamente
**Output:** campo `valencia` y `urgencia` en cognitive_nodes
**Principio:** sin SENTROPY, VECTROPY planifica con datos pero sin peso emocional
**Pregunta que responde:** "¿Qué de lo que pasó hoy merece atención real?"

### HOMOTROPY — El Hipotálamo Digital *(Fase 2)*
**Analogía:** Hipotálamo + Sistema de Homeostasis
**Función:** Monitorea la salud del ecosistema ZENTROPY completo
**Input:** temperatura de repos, ratio creación/cierre, carga de Mission Control
**Output:** informe periódico de homeostasis del sistema
**Principio:** sin HOMOTROPY el sistema colapsa en su propio peso
**Pregunta que responde:** "¿Está el sistema en equilibrio dinámico o en entropía?"

### SYNTROPY — La Red por Defecto *(Fase 3)*
**Analogía:** Default Mode Network + Corteza Asociativa
**Función:** Encuentra conexiones no obvias entre nodos distantes del grafo
**Horario:** corre en idle — cuando el humano no trabaja
**Input:** todo el grafo sin filtro temporal
**Output:** nodos tipo `conexion_latente` — serendipia estructurada
**Nota:** Estelectica es SYNTROPY en forma de investigación filosófica
**Pregunta que responde:** "¿Qué debería haberse conectado y no se conectó?"

### CRITROPY — El Cíngulo Anterior Digital *(Fase 3)*
**Analogía:** Corteza Cingulada Anterior + Monitor de Conflicto
**Función:** Detecta contradicciones entre lo declarado y lo ejecutado
**Input:** ADRs + patrones de comportamiento + promesas no cumplidas
**Output:** alertas de disonancia — "declaraste X pero tu comportamiento es Y"
**Principio:** el agente más incómodo y probablemente el más valioso
**Pregunta que responde:** "¿Dónde me estoy mintiendo a mí mismo?"

### SOMATROPY — El Cerebelo Digital *(Fase 4)*
**Analogía:** Cerebelo + Propiocepción + Ritmo Circadiano
**Función:** Modela el estado energético real del usuario en cada momento
**Input:** hora del día, historial de productividad por horario, patrones declarados
**Output:** calibración de carga cognitiva → informa a VECTROPY cuándo hacer qué
**Pregunta que responde:** "¿Cuánta energía real hay disponible ahora?"

### SOITROPY — La Teoría de la Mente Digital *(Fase 4)*
**Analogía:** Unión Temporoparietal + Neuronas Espejo
**Función:** Simula cómo recibirán tus artefactos audiencias específicas
**Input:** artefactos creados + perfiles de audiencias declaradas
**Output:** perspectiva externa simulada antes de publicar/enviar
**Caso concreto:** traduce cv-cluciani a la perspectiva del museo que no se ha contactado
**Pregunta que responde:** "¿Cómo se ve esto desde afuera?"

### LOGOTROPY — El Área de Broca Digital *(Fase 4)*
**Analogía:** Áreas del Lenguaje + Corteza Prefrontal Ventrolateral
**Función:** Convierte clusters de nodos internos en texto publicable
**Input:** cluster de nodos relacionados + audiencia destino + formato
**Output:** borrador articulado: ensayo, post, propuesta, resumen ejecutivo
**Distinción con MNENTROPY:** MNENTROPY consolida para el yo interno; LOGOTROPY articula para el exterior
**Pregunta que responde:** "¿Cómo se dice esto para que otro lo entienda?"

---

## Arquitectura de Comunicación

**Principio absoluto (ADR-I-003):** los agentes no se comunican directamente.
El grafo cognitivo en Supabase (`zentropia.*`) es el único canal.

```
AGENTE       ESCRIBE AL GRAFO              LEE DEL GRAFO
──────────────────────────────────────────────────────────────────
MNENTROPY    cognitive_nodes (destilados)  eventos externos
SENTROPY     campo: valencia, urgencia     nodos sin valorar
CRITROPY     nodos tipo: disonancia        ADRs + patrones
SYNTROPY     nodos tipo: conexion_latente  todo el grafo
SOMATROPY    campo: energia_disponible     patrones temporales
VECTROPY     daily_briefs                 nodos action_required + energia
SOITROPY     perspectiva_externa          artefactos + audiencias
LOGOTROPY    borradores articulados       clusters semánticos
HOMOTROPY    informe_homeostasis          métricas del sistema
```

---

## Inputs del Sistema — Dieta Pasiva

Ningún agente requiere input manual del usuario.
Los inputs son residuos de actividad ya existente:

```
FUENTE                   QUIÉN LA GENERA    QUIÉN LA INGIERE
──────────────────────────────────────────────────────────────
Conversaciones IA        Claude/Gemini      MNENTROPY
Git commits              Trabajo real       MNENTROPY + HOMOTROPY
Issues cerrados          Trabajo real       MNENTROPY + HOMOTROPY
ESTADO.md actualizado    Reflexión          MNENTROPY + CRITROPY
Hora del día / patrón    Fisiología         SOMATROPY
Temperatura de repos     Git activity       HOMOTROPY + SENTROPY
Artefactos publicados    Salida al mundo    LOGOTROPY → SOITROPY
Silencio / idle system   Ausencia           SYNTROPY (activa en pausa)
```

---

## Lo que Emerge

### Nivel 1: Emergencia local (2-3 agentes)
- MNENTROPY + SENTROPY → memoria con peso afectivo
- SYNTROPY + LOGOTROPY → insight articulado
- CRITROPY + VECTROPY → plan honesto (no solo optimista)
- SOMATROPY + VECTROPY → plan encarnado (cuándo, dado tu energía real)

### Nivel 2: Emergencia sistémica (el exocerebro como unidad)
Autoconocimiento estructurado — observación empírica de patrones propios:
- "¿En qué tipo de problemas genero más energía sostenida?"
- "¿Qué proyectos abandono consistentemente en qué fase?"
- "¿Cuánto tiempo pasa entre una idea y su primer commit semántico?"

### Nivel 3: Emergencia relacional (dos exocerebros conectados)
Cuando dos instancias ZENTROPY se conectan, SYNTROPY de usuario A
encuentra conexiones con nodos de usuario B que ninguno vería individualmente.
Es colaboración epistémica genuina — no intercambio de información.
Esto es lo que Estelectica estudia filosóficamente y ZENTROPY demostrará empíricamente.

---

## El Círculo Virtuoso — Autopoiesis

```
Christian trabaja en algo
        ↓
MNENTROPY captura y destila → grafo
        ↓
SYNTROPY encuentra conexiones no obvias → nuevas direcciones
        ↓
SENTROPY valora → VECTROPY prioriza → acción concreta
        ↓
Christian actúa ← cierra el círculo
        ↓
LOGOTROPY articula → publicación → feedback externo
        ↓
SOITROPY ingiere feedback → nuevo nodo
        ↓
CRITROPY detecta disonancia → el sistema se corrige honestamente
        ↓
MNENTROPY captura la corrección → el ciclo aprende
```

El círculo no es virtuoso porque es positivo —
es virtuoso porque **el sistema aprende de sus propios errores sin intervención manual**.

---

## Complejidad de Implementación por Agente

```
AGENTE SIMPLE (un proceso, un LLM call):
  MNENTROPY, VECTROPY, HOMOTROPY, SOMATROPY, SENTROPY

MICRO-SWARM (2-3 agentes internos, debate interno):
  SYNTROPY — un agente propone conexión, otro evalúa novedad
  CRITROPY — un agente busca evidencia, otro la cuestiona
  LOGOTROPY — un agente estructura, otro simplifica

SWARM COMPLETO: no justificado en ninguna fase actual
```

---

## Roadmap de Fases

```
FASE 1 — En desarrollo
  MNENTROPY (hipocampo) + VECTROPY (prefrontal)
  Círculo mínimo viable: ingesta → grafo → plan

FASE 2 — Alto impacto inmediato
  SENTROPY (peso afectivo) + HOMOTROPY (homeostasis del sistema)

FASE 3 — Madurez cognitiva
  SYNTROPY (creatividad) + CRITROPY (honestidad)

FASE 4 — Externalización
  SOITROPY (perspectiva externa) + LOGOTROPY (articulación)
  SOMATROPY (calibración energética)
```

**Criterio de priorización:** ¿qué función ausente está frenando el círculo virtuoso ahora mismo?
No el agente más sofisticado — el primero en la cadena causal.

