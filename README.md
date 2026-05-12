# 📄 REFS — Document Gallery

Benvenuto in **REFS**, un'applicazione web per la gestione e la visualizzazione di documenti personali (PDF e immagini) organizzati per utente.

L'applicazione integra un sistema di autenticazione **SSO (Single Sign-On)** con validazione JWT e genera automaticamente anteprime miniaturizzate per i documenti PDF caricati.

## ✨ Caratteristiche

- **🔐 Autenticazione SSO**: Integrazione con portale SSO centralizzato via JWT.
- **📂 Galleria per utente**: Ogni utente ha la propria cartella isolata di documenti.
- **🖼️ Anteprime PDF**: Generazione automatica di thumbnail dalla prima pagina del PDF tramite PyMuPDF.
- **⬆️ Upload documenti**: Caricamento di PDF e immagini con controllo del tipo e della dimensione.
- **⚙️ Impostazioni per tenant**: Ogni utente può personalizzare colore di sfondo e dimensione delle anteprime.
- **🛡️ Rate Limiting & Whitelist**: Gestione avanzata delle sessioni con limiti configurabili.
- **📱 Responsive**: Interfaccia moderna e adattiva.

## 🚀 Come Iniziare

### Opzione 1: Con Docker Compose (Consigliato) 🐳

#### Prerequisiti
- [Docker](https://www.docker.com/products/docker-desktop)
- [Docker Compose](https://docs.docker.com/compose/install/)

#### Avvio

1. Clona la repository:
   ```bash
   git clone https://github.com/paleoinfo/refs.git
   cd refs
   ```
2. Copia il file di configurazione:
   ```bash
   cp .env.example .env
   ```
3. Configura le variabili in `.env` (vedi sezione [Configurazione](#️-configurazione)).
4. Avvia l'applicazione:
   ```bash
   docker-compose up -d
   ```

L'applicazione sarà disponibile su `http://localhost:3010`.

**Comandi Docker Compose utili:**
```bash
# Visualizzare i log
docker-compose logs -f refs

# Arrestare il servizio
docker-compose down

# Ricostruire l'immagine (dopo modifiche al codice)
docker-compose build

# Riavviare il servizio
docker-compose restart refs
```

### Opzione 2: Installazione Locale

#### Prerequisiti

- Python 3.8+
- [Flask](https://flask.palletsprojects.com/)
- [PyMuPDF](https://pymupdf.readthedocs.io/) (`fitz`)
- [Pillow](https://pillow.readthedocs.io/)
- [PyJWT](https://pyjwt.readthedocs.io/)
- [python-dotenv](https://github.com/theskumar/python-dotenv)

#### Procedura

1. Clona la repository:
   ```bash
   git clone https://github.com/paleoinfo/refs.git
   cd refs
   ```
2. Crea un ambiente virtuale:
   ```bash
   python -m venv venv
   source venv/bin/activate  # Su Windows: venv\Scripts\activate
   ```
3. Installa le dipendenze:
   ```bash
   pip install -r requirements.txt
   ```
4. Configura le variabili d'ambiente (vedi sezione successiva).
5. Avvia il server:
   ```bash
   python app.py
   ```

L'applicazione sarà disponibile su `http://localhost:3010`.

## ⚙️ Configurazione

Crea un file `.env` nella root del progetto (puoi copiare `.env.example`) e configura le seguenti variabili:

```env
# Porta su cui avviare Flask
FLASK_PORT=3010

# Modalità SSO: 'dev' per sviluppo locale, 'production' per produzione
SSO_MODE=dev

# Segreto per la validazione JWT (obbligatorio in production)
JWT_SECRET=change-me-in-production

# URL del portale SSO
PORTAL_URL=http://localhost:5000

# Audience JWT attesa dall'applicazione
APP_AUDIENCE=refs-app

# Chiave segreta per le sessioni Flask
SERVER_SECRET_KEY=change-me-in-production

# Email dell'utente di test in modalità 'dev'
DEV_USER_EMAIL=demo@example.com

# Numero massimo di sessioni attive per utente
MAX_SESSIONS_PER_USER=3

# Numero massimo di sessioni globali
MAX_SESSIONS_GLOBAL=100

# Cartella per i file caricati
UPLOAD_FOLDER=/app/uploads

# Estensioni consentite (senza punto)
ALLOWED_EXTENSIONS=pdf,jpg,jpeg,png,gif,bmp

# Dimensione massima upload (default: 16MB)
MAX_CONTENT_LENGTH=16777216
```

> ⚠️ **Attenzione**: Non committare mai il file `.env` nella repository. È già escluso dal `.gitignore`.

## 🛠️ Architettura del Progetto

```
refs/
├── app.py                    # Backend Flask principale
├── requirements.txt          # Dipendenze Python
├── Dockerfile                # Immagine Docker
├── .env.example              # Template variabili d'ambiente
├── templates/
│   ├── gallery.html          # Galleria documenti utente
│   └── settings.html         # Impostazioni per tenant
├── shared_modules/
│   ├── sso_middleware.py     # Middleware SSO/JWT condiviso
│   └── __init__.py
├── static/
│   └── img/                  # Asset statici
└── documents/                # Documenti utente (esclusi dal repo)
    └── <username>/           # Cartella per singolo tenant
```

## 📦 Dipendenze principali

| Pacchetto | Utilizzo |
|-----------|----------|
| `Flask` | Framework web |
| `PyMuPDF` (`fitz`) | Generazione anteprime PDF |
| `Pillow` | Elaborazione immagini |
| `PyJWT` | Validazione token JWT |
| `python-dotenv` | Caricamento `.env` |
| `Werkzeug` | Proxy fix e utility HTTP |

## 🔒 Note di Sicurezza

- In modalità `production`, il `JWT_SECRET` è **obbligatorio** — l'app si rifiuta di avviarsi senza.
- I cookie di sessione in production sono configurati con `Secure`, `HttpOnly` e `SameSite=Lax`.
- Il rate limiter impedisce abusi con troppi login simultanei per singolo utente.
- I documenti degli utenti sono isolati per cartella e non accessibili cross-tenant.

---
Creato con ❤️ da Antigravity
