#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <urls_file>"
    exit 1
fi

URLS_FILE=$1
if [ ! -f "$URLS_FILE" ]; then
    echo "Error: File $URLS_FILE not found"
    exit 1
fi

DOMAIN=$(basename $(dirname $URLS_FILE))
mkdir -p results/$DOMAIN/xss

echo "[+] Testing for XSS vulnerabilities..."

# Using dalfox
echo "[+] Running dalfox..."
if command -v dalfox &> /dev/null; then
    cat $URLS_FILE | dalfox pipe --output results/$DOMAIN/xss/dalfox.txt
else
    echo "Dalfox not found, skipping..."
fi

# Using XSStrike
echo "[+] Running XSStrike on URLs with parameters..."
if [ -d "/workspace/tools/XSStrike" ]; then
    cat $URLS_FILE | grep "=" | head -10 | while read url; do
        echo "Testing: $url"
        timeout 30 python3 /workspace/tools/XSStrike/xsstrike.py -u "$url" --crawl >> results/$DOMAIN/xss/xsstrike.txt 2>/dev/null || true
    done
else
    echo "XSStrike not found, skipping..."
fi

echo "[+] XSS testing completed! Check results/$DOMAIN/xss/"
