# Switch SSO Mode - GalDoc
# Usage: .\switch-mode.ps1 [dev|prod]

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("dev","prod")]
    [string]$Mode
)

$envFile = ".env"
$envDevFile = ".env.dev"
$envProdFile = ".env.prod"

if ($Mode -eq "dev") {
    if (Test-Path $envDevFile) {
        Copy-Item $envDevFile $envFile -Force
        Write-Host "✅ Switched to" -NoNewline
        Write-Host " DEVELOPMENT" -ForegroundColor Green -NoNewline
        Write-Host " mode"
        Write-Host ""
        Write-Host "Next:" -ForegroundColor Yellow
        Write-Host "  python app.py"
    } else {
        Write-Host "❌ File $envDevFile not found!" -ForegroundColor Red
        Write-Host "Create it first with:"
        Write-Host "  cp .env.example $envDevFile"
        exit 1
    }
}
elseif ($Mode -eq "prod") {
    if (Test-Path $envProdFile) {
        Copy-Item $envProdFile $envFile -Force
        Write-Host "✅ Switched to" -NoNewline
        Write-Host " PRODUCTION" -ForegroundColor Cyan -NoNewline
        Write-Host " mode"
        Write-Host ""
        Write-Host "⚠️  Make sure:" -ForegroundColor Yellow
        Write-Host "  1. JWT_SECRET is configured in .env.prod"
        Write-Host "  2. APP_AUDIENCE is configured in .env.prod"
        Write-Host "  3. Portal SSO is running"
        Write-Host "  4. PORTAL_URL is correct"
        Write-Host "  5. MAX_SESSIONS_PER_USER / MAX_SESSIONS_GLOBAL are set"
        Write-Host ""
        Write-Host "Next:" -ForegroundColor Yellow
        Write-Host "  python app.py"
    } else {
        Write-Host "❌ File $envProdFile not found!" -ForegroundColor Red
        Write-Host "Create it first with:"
        Write-Host "  cp .env.example $envProdFile"
        Write-Host "  # Edit $envProdFile and set:"
        Write-Host "  #   SSO_MODE=production"
        Write-Host "  #   JWT_SECRET=<your-secret>"
        exit 1
    }
}

# Show current mode
Write-Host ""
Write-Host "Current .env content:" -ForegroundColor Cyan
Write-Host "─────────────────────"
Get-Content $envFile | Select-String -Pattern "SSO_MODE|DEV_USER_EMAIL|JWT_SECRET|APP_AUDIENCE|PORTAL_URL|MAX_SESSIONS_PER_USER|MAX_SESSIONS_GLOBAL|DEBUG" | ForEach-Object {
    Write-Host $_.Line
}
Write-Host "─────────────────────"
