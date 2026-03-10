#!/usr/bin/env zsh
# ═══════════════════════════════════════════════════════════════════
# new-repo.sh — Crea un repositorio nuevo desde el template correcto
# Uso: ./scripts/new-repo.sh
# Requiere: gh CLI autenticado, git, dirección de ZENTROPY en ZENTROPY_PATH
# ═══════════════════════════════════════════════════════════════════

set -e

ZENTROPY_PATH="${ZENTROPY_PATH:-$HOME/PROJECTOS/GitHub/ChristianLuciani/ZENTROPY}"
TEMPLATES="$ZENTROPY_PATH/templates"
GITHUB_USER="ChristianLuciani"
MISSION_CONTROL_ID="5"

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

echo ""
echo "${BOLD}═══════════════════════════════════════════════════${NC}"
echo "${BOLD}  🌀 ZENTROPY — Nuevo Repositorio                  ${NC}"
echo "${BOLD}═══════════════════════════════════════════════════${NC}"
echo ""

# ── 1. NOMBRE ──────────────────────────────────────────────────────
echo "${BLUE}1. Nombre del repositorio${NC} (sin espacios, usar-guiones):"
read REPO_NAME
if [[ -z "$REPO_NAME" ]]; then echo "${RED}Error: nombre requerido${NC}"; exit 1; fi

# ── 2. TIPO ────────────────────────────────────────────────────────
echo ""
echo "${BLUE}2. Tipo${NC} (taxonomía TIPO × CONTEXTO):"
echo "   1) SISTEMA       — infraestructura que habilita otros proyectos"
echo "   2) PRODUCTO      — tiene o busca usuarios reales"
echo "   3) INVESTIGACIÓN — hace preguntas, publica hallazgos"
echo "   4) HERRAMIENTA   — resuelve un problema específico acotado"
echo "   5) IDENTIDAD     — representa quién eres hacia el exterior"
read -r TIPO_NUM
case $TIPO_NUM in
  1) TIPO="SISTEMA";       TEMPLATE="sistema" ;;
  2) TIPO="PRODUCTO";      TEMPLATE="producto" ;;
  3) TIPO="INVESTIGACIÓN"; TEMPLATE="investigacion" ;;
  4) TIPO="HERRAMIENTA";   TEMPLATE="herramienta" ;;
  5) TIPO="IDENTIDAD";     TEMPLATE="identidad" ;;
  *) echo "${RED}Opción inválida${NC}"; exit 1 ;;
esac

# ── 3. CONTEXTO ────────────────────────────────────────────────────
echo ""
echo "${BLUE}3. Contexto${NC}:"
echo "   1) OPUS           — obra mayor, legado intelectual"
echo "   2) MÉTIER         — trabajo profesional, ingresos"
echo "   3) AKADEMIA       — formación y conocimiento"
echo "   4) INFRAESTRUCTURA — ecosistema personal"
echo "   5) VIDA           — personal no profesional"
read -r CTX_NUM
case $CTX_NUM in
  1) CONTEXTO="OPUS" ;;
  2) CONTEXTO="MÉTIER" ;;
  3) CONTEXTO="AKADEMIA" ;;
  4) CONTEXTO="INFRAESTRUCTURA" ;;
  5) CONTEXTO="VIDA" ;;
  *) echo "${RED}Opción inválida${NC}"; exit 1 ;;
esac

# ── 4. DESCRIPCIÓN CORTA ───────────────────────────────────────────
echo ""
echo "${BLUE}4. Descripción en una línea${NC} (para README y CLASIFICACION.yml):"
read DESCRIPCION

# ── 5. PROYECTO PADRE ─────────────────────────────────────────────
echo ""
echo "${BLUE}5. Proyecto padre${NC} en Mission Control (ZENTROPY / CLAPPS / NEXOS / otro / ninguno):"
read PROYECTO_PADRE
[[ -z "$PROYECTO_PADRE" ]] && PROYECTO_PADRE="null"

# ── 6. DIRECTORIO DESTINO ─────────────────────────────────────────
echo ""
echo "${BLUE}6. Directorio destino${NC} (Enter para $HOME/PROJECTOS/GitHub/$GITHUB_USER):"
read DEST_DIR
[[ -z "$DEST_DIR" ]] && DEST_DIR="$HOME/PROJECTOS/GitHub/$GITHUB_USER"
TARGET="$DEST_DIR/$REPO_NAME"

# ── CONFIRMACIÓN ───────────────────────────────────────────────────
echo ""
echo "${BOLD}─────────────────────────────────────────────────────${NC}"
echo "  Repo:       ${GREEN}$REPO_NAME${NC}"
echo "  Tipo:       ${GREEN}$TIPO${NC}"
echo "  Contexto:   ${GREEN}$CONTEXTO${NC}"
echo "  Template:   ${GREEN}$TEMPLATE${NC}"
echo "  Descripción: ${GREEN}$DESCRIPCION${NC}"
echo "  Proyecto:   ${GREEN}$PROYECTO_PADRE${NC}"
echo "  Destino:    ${GREEN}$TARGET${NC}"
echo "${BOLD}─────────────────────────────────────────────────────${NC}"
echo ""
echo "¿Continuar? [s/N]"
read CONFIRM
[[ "$CONFIRM" != "s" && "$CONFIRM" != "S" ]] && echo "Cancelado." && exit 0

# ── CONSTRUIR REPO ─────────────────────────────────────────────────
echo ""
echo "${YELLOW}→ Creando estructura...${NC}"
mkdir -p "$TARGET"

# Copiar BASE primero (todos los repos la heredan)
cp -r "$TEMPLATES/base/." "$TARGET/"

# Copiar template específico (respetando jerarquía)
case $TEMPLATE in
  sistema)
    cp -rn "$TEMPLATES/herramienta/." "$TARGET/" 2>/dev/null || true
    cp -rn "$TEMPLATES/producto/." "$TARGET/" 2>/dev/null || true
    cp -rn "$TEMPLATES/sistema/." "$TARGET/" 2>/dev/null || true
    ;;
  producto)
    cp -rn "$TEMPLATES/herramienta/." "$TARGET/" 2>/dev/null || true
    cp -rn "$TEMPLATES/producto/." "$TARGET/" 2>/dev/null || true
    ;;
  herramienta)
    cp -rn "$TEMPLATES/herramienta/." "$TARGET/" 2>/dev/null || true
    ;;
  investigacion)
    cp -rn "$TEMPLATES/investigacion/." "$TARGET/" 2>/dev/null || true
    ;;
  identidad)
    cp -rn "$TEMPLATES/identidad/." "$TARGET/" 2>/dev/null || true
    ;;
esac

# Reemplazar [NOMBRE] en todos los archivos
echo "${YELLOW}→ Personalizando archivos...${NC}"
find "$TARGET" -type f -name "*.md" -o -name "*.yml" | while read f; do
  sed -i '' "s/\[NOMBRE\]/$REPO_NAME/g" "$f"
done

# Actualizar CLASIFICACION.yml con valores reales
FECHA=$(date +%Y-%m-%d)
sed -i '' "s/\[SISTEMA | PRODUCTO | INVESTIGACIÓN | HERRAMIENTA | IDENTIDAD | RECURSO | REGISTRO\]/$TIPO/" "$TARGET/CLASIFICACION.yml"
sed -i '' "s/\[OPUS | MÉTIER | AKADEMIA | INFRAESTRUCTURA | VIDA\]/$CONTEXTO/" "$TARGET/CLASIFICACION.yml"
sed -i '' "s|\[Una línea. Qué hace.\]|$DESCRIPCION|" "$TARGET/CLASIFICACION.yml"
sed -i '' "s|\[nombre del proyecto en zentropia.projects — o null\]|$PROYECTO_PADRE|" "$TARGET/CLASIFICACION.yml"

# Agregar CLAUDE.md y AGENTS.md como referencias
echo "" >> "$TARGET/AGENTS.md" 2>/dev/null || cat > "$TARGET/AGENTS.md" << 'AGEOF'
# AGENTS.md
> Ver protocolo completo en ZENTROPY: https://github.com/ChristianLuciani/ZENTROPY/blob/main/AGENTS.md
AGEOF

# Inicializar git
echo "${YELLOW}→ Inicializando git...${NC}"
cd "$TARGET"
git init
git add -A
git commit -m "init: $REPO_NAME — $TIPO × $CONTEXTO

Template: $TEMPLATE
Descripción: $DESCRIPCION
Proyecto: $PROYECTO_PADRE

Generado por ZENTROPY new-repo.sh
$(date +%Y-%m-%d)"

# Crear repo en GitHub
echo "${YELLOW}→ Creando repo en GitHub...${NC}"
VISIBILITY="private"
echo "¿Visibilidad? [public/private] (Enter = private):"
read VIS
[[ "$VIS" == "public" ]] && VISIBILITY="public"

gh repo create "$GITHUB_USER/$REPO_NAME" \
  --"$VISIBILITY" \
  --description "$TIPO × $CONTEXTO — $DESCRIPCION" \
  --source="$TARGET" \
  --remote=origin \
  --push

# Crear issue inicial en Mission Control
echo "${YELLOW}→ Creando issue inicial en Mission Control...${NC}"
gh issue create \
  --repo "$GITHUB_USER/$REPO_NAME" \
  --title "[TASK] Setup inicial — completar prompts de activación" \
  --body "## Objetivo
Completar todos los prompts de activación en los archivos del template para que el repo quede en nivel de madurez 2 (ORIENTACIÓN).

## Criterio de DONE
- [ ] README.md completado (sin comentarios PROMPT)
- [ ] ESTADO.md completado con próximo paso concreto
- [ ] CLASIFICACION.yml verificado
- [ ] .env.example tiene las variables reales del proyecto
- [ ] Primer commit semántico hecho (no cuenta el de init)

## Tipo: $TIPO | Contexto: $CONTEXTO | Agente: 👤 Humano" \
  --project "Mission Control" 2>/dev/null || echo "${YELLOW}  (agregar manualmente a Mission Control si falla)${NC}"

echo ""
echo "${GREEN}${BOLD}═══════════════════════════════════════════════════${NC}"
echo "${GREEN}${BOLD}  ✅ Repo creado exitosamente                       ${NC}"
echo "${GREEN}${BOLD}═══════════════════════════════════════════════════${NC}"
echo ""
echo "  ${BOLD}Directorio:${NC} $TARGET"
echo "  ${BOLD}GitHub:${NC}     https://github.com/$GITHUB_USER/$REPO_NAME"
echo ""
echo "${YELLOW}  Próximo paso: completar los prompts de activación${NC}"
echo "  Empieza por: ${BOLD}ESTADO.md${NC} — define el primer paso concreto"
echo ""
