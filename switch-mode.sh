#!/bin/bash
# Switch SSO Mode - GalDoc
# Usage: ./switch-mode.sh [dev|prod]

MODE=$1
ENV_FILE=".env"
ENV_DEV_FILE=".env.dev"
ENV_PROD_FILE=".env.prod"

if [ -z "$MODE" ]; then
    echo "Usage: ./switch-mode.sh [dev|prod]"
    exit 1
fi

if [ "$MODE" == "dev" ]; then
    if [ -f "$ENV_DEV_FILE" ]; then
        cp "$ENV_DEV_FILE" "$ENV_FILE"
        echo -e "\033[0;32m✅ Switched to DEVELOPMENT mode\033[0m"
        echo ""
        echo -e "\033[0;33mNext:\033[0m"
        echo "  python app.py"
    else
        echo -e "\033[0;31m❌ File $ENV_DEV_FILE not found!\033[0m"
        echo "Create it first with:"
        echo "  cp .env.example $ENV_DEV_FILE"
        exit 1
    fi
elif [ "$MODE" == "prod" ]; then
    if [ -f "$ENV_PROD_FILE" ]; then
        cp "$ENV_PROD_FILE" "$ENV_FILE"
        echo -e "\033[0;36m✅ Switched to PRODUCTION mode\033[0m"
        echo ""
        echo -e "\033[0;33m⚠️  Make sure:\033[0m"
        echo "  1. JWT_SECRET is configured in .env.prod"
        echo "  2. APP_AUDIENCE is configured in .env.prod"
        echo "  3. Portal SSO is running"
        echo "  4. PORTAL_URL is correct"
        echo "  5. MAX_SESSIONS_PER_USER / MAX_SESSIONS_GLOBAL are set"
        echo ""
        echo -e "\033[0;33mNext:\033[0m"
        echo "  python app.py"
    else
        echo -e "\033[0;31m❌ File $ENV_PROD_FILE not found!\033[0m"
        echo "Create it first with:"
        echo "  cp .env.example $ENV_PROD_FILE"
        echo "  # Edit $ENV_PROD_FILE and set:"
        echo "  #   SSO_MODE=production"
        echo "  #   JWT_SECRET=<your-secret>"
        exit 1
    fi
else
    echo "Invalid mode: $MODE"
    echo "Usage: ./switch-mode.sh [dev|prod]"
    exit 1
fi

# Show current mode
echo ""
echo -e "\033[0;36mCurrent .env content:\033[0m"
echo "─────────────────────"
grep -E "SSO_MODE|DEV_USER_EMAIL|JWT_SECRET|APP_AUDIENCE|PORTAL_URL|MAX_SESSIONS_PER_USER|MAX_SESSIONS_GLOBAL|DEBUG" "$ENV_FILE"
echo "─────────────────────"
