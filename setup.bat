@echo off
REM ═══════════════════════════════════════════════════════════════
REM MANIK.AI — One-Click Setup Script (Windows)
REM Usage: Double-click setup.bat OR run in terminal
REM ═══════════════════════════════════════════════════════════════

echo.
echo   MANIK.AI - Free, Open-Source, Self-Hosted Autonomous AI
echo   =========================================================
echo.

REM ── Check Python ──────────────────────────────────────────────
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python not found. Install from python.org
    pause
    exit /b 1
)
echo [OK] Python found

REM ── Check Node ────────────────────────────────────────────────
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Node.js not found. Install from nodejs.org
    pause
    exit /b 1
)
echo [OK] Node.js found

REM ── Create .env ───────────────────────────────────────────────
if not exist ".env" (
    copy .env.example .env >nul
    echo [NOTE] .env created — open it and add your OPENROUTER_API_KEY
) else (
    echo [OK] .env already exists
)

REM ── Python venv ───────────────────────────────────────────────
echo.
echo [STEP] Installing Python dependencies...
if not exist "backend\.venv" (
    python -m venv backend\.venv
)
call backend\.venv\Scripts\activate.bat
pip install --quiet --upgrade pip
pip install --quiet -r backend\requirements.txt
echo [OK] Python packages installed

REM ── Node packages ─────────────────────────────────────────────
echo.
echo [STEP] Installing Node.js dependencies...
npm install --silent
echo [OK] Node packages installed

REM ── Workspace ─────────────────────────────────────────────────
if not exist "backend\workspace" mkdir backend\workspace
echo [OK] Workspace ready

echo.
echo =========================================================
echo   Setup complete!
echo =========================================================
echo.
echo   1. Edit .env and add your OPENROUTER_API_KEY
echo   2. (Optional) Edit manik.config.yaml to add skills/tools
echo   3. To start:
echo.
echo      Web:     start.bat
echo      Desktop: npm run electron:dev
echo      Docker:  docker compose up -d
echo.
pause
