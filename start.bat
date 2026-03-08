@echo off
REM ═══════════════════════════════════════════════════════════════
REM MANIK.AI — Start Script (Windows)
REM Usage: Double-click start.bat OR run in terminal
REM ═══════════════════════════════════════════════════════════════

echo.
echo   Starting MANIK.AI...
echo.

if not exist ".env" (
    echo [ERROR] .env not found. Run setup.bat first.
    pause
    exit /b 1
)

REM Activate venv if present
if exist "backend\.venv\Scripts\activate.bat" (
    call backend\.venv\Scripts\activate.bat
)

echo [1/2] Starting Backend  (http://localhost:8000)
start "MANIK-Backend" cmd /k "cd backend && uvicorn main:app --reload --port 8000"

REM Wait a moment for backend to start
timeout /t 3 /nobreak >nul

echo [2/2] Starting Frontend (http://localhost:5173)
start "MANIK-Frontend" cmd /k "npm run dev"

echo.
echo   MANIK.AI is starting...
echo   Frontend: http://localhost:5173
echo   Backend:  http://localhost:8000
echo.
echo   Close the two terminal windows to stop.
echo.
pause
