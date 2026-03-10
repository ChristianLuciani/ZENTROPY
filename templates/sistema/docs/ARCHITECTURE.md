# Arquitectura — [NOMBRE]

<!-- 
═══════════════════════════════════════════════════════════════════
PROMPT DE ACTIVACIÓN — ARCHITECTURE.md
Documenta cómo está construido el sistema y POR QUÉ así.
Este archivo responde la pregunta: "¿Qué hay aquí y cómo encaja?"
Un agente IA que lee este archivo debe poder entender la estructura
sin leer el código.
═══════════════════════════════════════════════════════════════════
-->

## Visión de alto nivel

<!-- PROMPT: ¿Qué hace este sistema en términos de flujo?
     ¿Qué entra, qué sale, qué transforma?
     Un párrafo de 3-5 oraciones. -->

## Diagrama de componentes

<!-- PROMPT: Dibuja los componentes principales y sus relaciones.
     Puede ser ASCII art, un enlace a un diagrama, o texto descriptivo.
     Lo importante es que muestre las dependencias. -->

```
[Componente A] → [Componente B] → [Componente C]
       ↑                               ↓
[Componente D] ←───────────────────────
```

## Componentes

<!-- PROMPT: Para cada componente principal: qué es, qué hace, 
     qué decisión de diseño lo define -->

### [Componente A]
**Responsabilidad:** 
**Tecnología:** 
**Interfaz con otros componentes:** 
**Decisión de diseño clave:** Ver [ADR-XXX]

---

## Stack tecnológico

<!-- PROMPT: El stack completo con el PORQUÉ de cada elección.
     No solo "usamos Python" sino "usamos Python porque...".
     Ver ADRs para el razonamiento completo. -->

| Capa | Tecnología | Por qué |
|------|-----------|---------|
| | | |

---

## Principios de diseño aplicados

<!-- PROMPT: ¿Qué principios guían las decisiones de este sistema?
     (multi-tenancy, agnosticismo de proveedor, superficie mínima, etc.) -->

- **[Principio]:** [Cómo se aplica aquí]

---

## Flujos principales

<!-- PROMPT: Los 2-3 flujos más importantes del sistema, paso a paso. -->

### Flujo 1: [nombre]
```
1. [paso]
2. [paso]
3. [paso]
```

---

## Schema de datos *(si aplica)*

<!-- PROMPT: Las entidades principales y sus relaciones.
     Si hay archivos de schema separados, referenciarlos aquí. -->

Ver `docs/schema/` para los contratos de datos completos.

---

## ADRs vigentes

<!-- PROMPT: Lista los ADRs que afectan la arquitectura de este sistema.
     Ver docs/adr/ para los documentos completos. -->

| ADR | Decisión |
|-----|----------|
| ADR-001 | |

