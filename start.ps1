# GalDoc - Launch Script (PowerShell)
# Autore: Senior Software Architect

$VENV_PATH = "$PSScriptRoot\venv"

Clear-Host
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   GalDoc - Document Gallery Loader       " -ForegroundColor White -BackgroundColor Blue
Write-Host "==========================================" -ForegroundColor Cyan

# Check if virtual environment exists
if (-Not (Test-Path "$VENV_PATH")) {
    Write-Host "[!] Errore: Ambiente virtuale (venv) non trovato." -ForegroundColor Red
    Write-Host "[*] Esegui 'python -m venv venv' e 'pip install -r requirements.txt' prima." -ForegroundColor Yellow
    exit 1
}

# Activate virtual environment
Write-Host "[+] Attivazione ambiente virtuale..." -ForegroundColor Green
& "$VENV_PATH\Scripts\Activate.ps1"

if (-Not (Test-Path "$PSScriptRoot\.env")) {
    Write-Host "[!] Avviso: file .env non trovato in refs." -ForegroundColor Yellow
    Write-Host "[*] Configura almeno: SSO_MODE, JWT_SECRET, APP_AUDIENCE, PORTAL_URL" -ForegroundColor Yellow
}

Write-Host "[+] Configurazione SSO attesa:" -ForegroundColor Cyan
Write-Host "    - SSO_MODE" -ForegroundColor Gray
Write-Host "    - JWT_SECRET" -ForegroundColor Gray
Write-Host "    - APP_AUDIENCE" -ForegroundColor Gray
Write-Host "    - PORTAL_URL" -ForegroundColor Gray
Write-Host "    - MAX_SESSIONS_PER_USER" -ForegroundColor Gray
Write-Host "    - MAX_SESSIONS_GLOBAL" -ForegroundColor Gray

# Check dependencies (optional but helpful)
# Write-Host "[+] Verifica dipendenze..." -ForegroundColor Gray

# Run the application
Write-Host "[+] Avvio dell'applicazione Flask..." -ForegroundColor Green
Write-Host "[*] Premere CTRL+C per interrompere." -ForegroundColor Yellow
Write-Host ""

python "$PSScriptRoot\app.py"
