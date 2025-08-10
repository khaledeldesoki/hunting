#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <target> [scan_type]"
    echo "Scan types: quick, full, vuln"
    exit 1
fi

TARGET=$1
SCAN_TYPE=${2:-quick}
DOMAIN=$(echo $TARGET | sed 's/https\?:\/\///' | cut -d'/' -f1)
mkdir -p results/$DOMAIN

echo "[+] Starting $SCAN_TYPE scan for $TARGET"

case $SCAN_TYPE in
    quick)
        echo "[+] Quick vulnerability scan..."
        nuclei -target $TARGET -severity high,critical -o results/$DOMAIN/nuclei_quick.txt
        ;;
    full)
        echo "[+] Full vulnerability scan..."
        nuclei -target $TARGET -o results/$DOMAIN/nuclei_full.txt
        ;;
    vuln)
        echo "[+] Comprehensive vulnerability assessment..."
        nuclei -target $TARGET -o results/$DOMAIN/nuclei_vuln.txt
        nikto -h $TARGET -output results/$DOMAIN/nikto.txt
        ;;
    *)
        echo "Unknown scan type: $SCAN_TYPE"
        exit 1
        ;;
esac

echo "[+] Scan completed! Results saved in results/$DOMAIN/"