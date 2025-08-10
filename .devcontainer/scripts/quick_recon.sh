#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

DOMAIN=$1
mkdir -p results/$DOMAIN

echo "[+] Starting quick reconnaissance for $DOMAIN"
echo "[+] Running subfinder..."
subfinder -d $DOMAIN -o results/$DOMAIN/subdomains.txt

echo "[+] Running assetfinder..."
assetfinder --subs-only $DOMAIN >> results/$DOMAIN/subdomains.txt

echo "[+] Removing duplicates..."
sort -u results/$DOMAIN/subdomains.txt -o results/$DOMAIN/subdomains.txt

echo "[+] Probing for live hosts..."
cat results/$DOMAIN/subdomains.txt | httpx -o results/$DOMAIN/live_hosts.txt

echo "[+] Taking screenshots..."
if [ -s results/$DOMAIN/live_hosts.txt ]; then
    cat results/$DOMAIN/live_hosts.txt | aquatone -out results/$DOMAIN/aquatone
fi

echo "[+] Quick reconnaissance completed! Results saved in results/$DOMAIN/"
echo "[+] Found $(wc -l < results/$DOMAIN/subdomains.txt) subdomains"
echo "[+] Found $(wc -l < results/$DOMAIN/live_hosts.txt) live hosts"
