#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <url>"
    exit 1
fi

URL=$1
DOMAIN=$(echo $URL | sed 's/https\?:\/\///' | cut -d'/' -f1)
mkdir -p results/$DOMAIN/parameters

echo "[+] Discovering parameters for $URL"

# Arjun parameter discovery
echo "[+] Running Arjun..."
if command -v arjun &> /dev/null; then
    arjun -u $URL -o results/$DOMAIN/parameters/arjun.txt
else
    echo "Arjun not found, skipping..."
fi

# ParamSpider
echo "[+] Running ParamSpider..."
if [ -d "/workspace/tools/ParamSpider" ]; then
    cd /workspace/tools/ParamSpider
    python3 paramspider.py --domain $DOMAIN --output /workspace/results/$DOMAIN/parameters/paramspider.txt
    cd /workspace
else
    echo "ParamSpider not found, skipping..."
fi

echo "[+] Parameter discovery completed!"