# Runbook — [NOMBRE]

<!-- 
═══════════════════════════════════════════════════════════════════
PROMPT DE ACTIVACIÓN — RUNBOOK.md
El runbook responde: "¿Qué hago cuando algo sale mal a las 3am?"
También cubre el setup inicial y las operaciones de mantenimiento.
Si este sistema no va a producción todavía, documenta al menos
el setup y los comandos de diagnóstico.
═══════════════════════════════════════════════════════════════════
-->

## Setup inicial

```bash
# Clonar y configurar
git clone [url]
cd [nombre]
cp .env.example .env
# Editar .env con valores reales

# Instalar dependencias
# ...

# Inicializar (migraciones, seeds, etc.)
# ...

# Verificar que funciona
# ...
```

**Verificación de setup exitoso:**
- [ ] [qué debe verse o pasar]

---

## Comandos de operación

```bash
# Iniciar el sistema
[comando]

# Detener el sistema
[comando]

# Ver logs
[comando]

# Verificar estado
[comando]

# Reiniciar un componente específico
[comando]
```

---

## Diagnóstico y debugging

### Síntoma: [descripción del problema común 1]
**Causa más probable:** 
**Diagnóstico:**
```bash
# Comando para diagnosticar
```
**Resolución:**
```bash
# Comando para resolver
```

### Síntoma: [descripción del problema común 2]
**Causa más probable:** 
**Diagnóstico:** 
**Resolución:** 

---

## Operaciones de mantenimiento

### Backup
```bash
# Comando de backup
```

### Actualización de dependencias
```bash
# Proceso de actualización
```

### Rotación de secretos
1. Generar nuevo secreto en [servicio]
2. Actualizar `.env`
3. Reiniciar sistema
4. Verificar funcionamiento

---

## Escalado y límites conocidos

<!-- PROMPT: ¿Cuándo empieza a fallar este sistema por carga?
     ¿Qué hay que hacer cuando llegue a ese límite? -->

---

## Contactos y recursos

| Recurso | URL / Contacto |
|---------|----------------|
| Repositorio | [url] |
| Supabase dashboard | [url] |
| Logs | [ubicación] |

