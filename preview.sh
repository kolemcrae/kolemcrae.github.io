#!/usr/bin/env bash

# Terminal colors for professional look
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}====================================================${NC}"
echo -e "${CYAN}          Kole McRae Local Preview Server          ${NC}"
echo -e "${CYAN}====================================================${NC}"

PORT=8000
# Find first available port starting from 8000
while lsof -i -P -n | grep -q ":$PORT" 2>/dev/null ; do
    PORT=$((PORT+1))
done

# Check if python3 is available
if command -v python3 >/dev/null 2>&1; then
    echo -e "\n${GREEN}✓ Python 3 detected.${NC}"
    echo -e "${GREEN}✓ Starting local web server on port $PORT...${NC}"
    echo -e "${CYAN}→ Access your site locally at: ${YELLOW}http://localhost:$PORT/${NC}"
    echo -e "${CYAN}→ Press Ctrl+C to stop the server.${NC}\n"
    python3 -m http.server $PORT
# Check if python is available
elif command -v python >/dev/null 2>&1; then
    echo -e "\n${GREEN}✓ Python detected.${NC}"
    echo -e "${GREEN}✓ Starting local web server on port $PORT...${NC}"
    echo -e "${CYAN}→ Access your site locally at: ${YELLOW}http://localhost:$PORT/${NC}"
    echo -e "${CYAN}→ Press Ctrl+C to stop the server.${NC}\n"
    if python -c 'import sys; sys.exit(0 if sys.version_info[0] >= 3 else 1)' >/dev/null 2>&1; then
        python -m http.server $PORT
    else
        python -m SimpleHTTPServer $PORT
    fi
# Check if npx is available
elif command -v npx >/dev/null 2>&1; then
    echo -e "\n${GREEN}✓ Node/NPX detected.${NC}"
    echo -e "${GREEN}✓ Starting local web server on port $PORT via serve...${NC}"
    echo -e "${CYAN}→ Access your site locally at: ${YELLOW}http://localhost:$PORT/${NC}"
    echo -e "${CYAN}→ Press Ctrl+C to stop the server.${NC}\n"
    npx serve -l $PORT
else
    echo -e "\n${RED}✗ Error: Neither Python nor Node.js could be found on your system.${NC}"
    echo -e "To preview your site, please do one of the following:"
    echo -e "  1. Install Python 3 (standard on Linux: e.g., sudo dnf install python3)"
    echo -e "  2. Install Node.js"
    echo -e "  3. Double click on 'index.html' to open it directly in your browser."
    exit 1
fi
