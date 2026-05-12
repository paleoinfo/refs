#!/bin/bash

echo "=========================================="
echo "  TRACCIATORE PLANIMETRIE"
echo "=========================================="
echo ""

# Controlla se Python è installato
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 non trovato. Installalo prima di procedere."
    exit 1
fi

echo "✓ Python 3 trovato"

# Installa dipendenze se necessario
if [ ! -d "venv" ]; then
    echo ""
    echo "Creazione ambiente virtuale..."
    python3 -m venv venv
    source venv/bin/activate
    echo "Installazione dipendenze..."
    pip install -r requirements.txt
else
    source venv/bin/activate
fi

echo ""
echo "=========================================="
echo "  Avvio applicazione..."
echo "=========================================="
echo ""
if [ ! -f ".env" ]; then
    echo "⚠️  File .env non trovato."
    echo "   Configura almeno: SSO_MODE, JWT_SECRET, APP_AUDIENCE, PORTAL_URL"
    echo ""
fi

echo "Configurazione SSO attesa:"
echo "  - SSO_MODE"
echo "  - JWT_SECRET"
echo "  - APP_AUDIENCE"
echo "  - PORTAL_URL"
echo "  - MAX_SESSIONS_PER_USER"
echo "  - MAX_SESSIONS_GLOBAL"
echo ""
echo "🌐 Apri il browser su: http://localhost:30xx"
echo ""
echo "Premi Ctrl+C per fermare il server"
echo ""

# Avvia Flask
python3 app.py
