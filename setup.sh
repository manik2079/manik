#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
# MANIK.AI — One-Click Setup Script (Linux / macOS)
# Usage: chmod +x setup.sh && ./setup.sh
# ═══════════════════════════════════════════════════════════════
set -e

BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
CYAN="\033[36m"
RESET="\033[0m"

log()  { echo -e "${GREEN}✓${RESET} $1"; }
warn() { echo -e "${YELLOW}⚠${RESET} $1"; }
err()  { echo -e "${RED}✗ $1${RESET}"; exit 1; }
step() { echo -e "\n${BOLD}${CYAN}▶ $1${RESET}"; }

echo -e "${BOLD}"
echo "  ███╗   ███╗ █████╗ ███╗   ██╗██╗██╗  ██╗    █████╗ ██╗"
echo "  ████╗ ████║██╔══██╗████╗  ██║██║██║ ██╔╝   ██╔══██╗██║"
echo "  ██╔████╔██║███████║██╔██╗ ██║██║█████╔╝    ███████║██║"
echo "  ██║╚██╔╝██║██╔══██║██║╚██╗██║██║██╔═██╗    ██╔══██║██║"
echo "  ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║██║  ██╗██╗██║  ██║██║"
echo "  ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═╝"
echo -e "${RESET}"
echo -e "  ${CYAN}Free • Open-Source • Self-Hosted Autonomous AI Agent${RESET}\n"

# ── 1. Check dependencies ──────────────────────────────────────
step "Checking dependencies"

command -v python3 &>/dev/null || err "Python 3 not found. Install from python.org"
PYTHON_VER=$(python3 -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
log "Python $PYTHON_VER found"

command -v node &>/dev/null || err "Node.js not found. Install from nodejs.org"
NODE_VER=$(node --version)
log "Node.js $NODE_VER found"

command -v npm &>/dev/null || err "npm not found"
log "npm $(npm --version) found"

# ── 2. Create .env if not exists ───────────────────────────────
step "Setting up environment"

if [ ! -f ".env" ]; then
    cp .env.example .env
    warn ".env created from .env.example"
    warn "Open .env and add your OPENROUTER_API_KEY before starting"
else
    log ".env already exists"
fi

# ── 3. Python virtual environment ─────────────────────────────
step "Installing Python dependencies"

if [ ! -d "backend/.venv" ]; then
    python3 -m venv backend/.venv
    log "Virtual environment created at backend/.venv"
fi

source backend/.venv/bin/activate
pip install --quiet --upgrade pip
pip install --quiet -r backend/requirements.txt
log "Python packages installed"

# ── 4. Node dependencies ───────────────────────────────────────
step "Installing Node.js dependencies"
npm install --silent
log "Node packages installed"

# ── 5. Workspace directory ─────────────────────────────────────
mkdir -p backend/workspace
log "Workspace directory ready"

# ── Done ───────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}${BOLD}Setup complete!${RESET}"
echo ""
echo -e "  ${BOLD}Next steps:${RESET}"
echo -e "  1. Edit ${CYAN}.env${RESET} and add your ${BOLD}OPENROUTER_API_KEY${RESET}"
echo -e "  2. (Optional) Edit ${CYAN}manik.config.yaml${RESET} to add skills/tools"
echo -e "  3. Start MANIK.AI:"
echo ""
echo -e "     ${CYAN}# Web browser (localhost:5173):${RESET}"
echo -e "     ${BOLD}./start.sh${RESET}"
echo ""
echo -e "     ${CYAN}# Desktop app:${RESET}"
echo -e "     ${BOLD}npm run electron:dev${RESET}"
echo ""
echo -e "     ${CYAN}# Self-hosted Docker:${RESET}"
echo -e "     ${BOLD}docker compose up -d${RESET}"
echo ""
