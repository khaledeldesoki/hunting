#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

DOMAIN=$1
mkdir -p results/$DOMAIN/{subdomains,urls,js,nuclei,endpoints,ports}

echo "[+] Starting deep reconnaissance for $DOMAIN"

# Subdomain enumeration
echo "[+] Running multiple subdomain enumeration tools..."
subfinder -d $DOMAIN -o results/$DOMAIN/subdomains/subfinder.txt
assetfinder --subs-only $DOMAIN > results/$DOMAIN/subdomains/assetfinder.txt

# Run Sublist3r if available
if [ -d "/workspace/tools/Sublist3r" ]; then
    cd /workspace/tools/Sublist3r
    python3 sublist3r.py -d $DOMAIN -o /workspace/results/$DOMAIN/subdomains/sublist3r.txt
    cd /workspace
fi

# Combine and deduplicate
cat results/$DOMAIN/subdomains/*.txt | sort -u > results/$DOMAIN/subdomains/all_subdomains.txt

# Probe for live hosts
echo "[+] Probing for live hosts..."
cat results/$DOMAIN/subdomains/all_subdomains.txt | httpx -ports 80,443,8080,8443,3000,5000,8000,9000 -o results/$DOMAIN/live_hosts.txt

# Port scanning
echo "[+] Running port scan on live hosts..."
if command -v naabu &> /dev/null && [ -s results/$DOMAIN/live_hosts.txt ]; then
    naabu -l results/$DOMAIN/live_hosts.txt -o results/$DOMAIN/ports/open_ports.txt
fi

# URL gathering
echo "[+] Gathering URLs..."
if [ -s results/$DOMAIN/live_hosts.txt ]; then
    cat results/$DOMAIN/live_hosts.txt | gau > results/$DOMAIN/urls/gau.txt 2>/dev/null
    cat results/$DOMAIN/live_hosts.txt | waybackurls > results/$DOMAIN/urls/wayback.txt 2>/dev/null
    cat results/$DOMAIN/urls/*.txt | sort -u > results/$DOMAIN/urls/all_urls.txt
fi

# JavaScript file discovery
echo "[+] Finding JavaScript files..."
if [ -s results/$DOMAIN/urls/all_urls.txt ]; then
    cat results/$DOMAIN/urls/all_urls.txt | grep -E "\.js$" > results/$DOMAIN/js/js_files.txt
    cat results/$DOMAIN/live_hosts.txt | getJS --complete > results/$DOMAIN/js/getjs_output.txt 2>/dev/null
fi

# Nuclei scanning
echo "[+] Running Nuclei scans..."
if [ -s results/$DOMAIN/live_hosts.txt ]; then
    nuclei -l results/$DOMAIN/live_hosts.txt -o results/$DOMAIN/nuclei/vulnerabilities.txt -severity medium,high,critical
fi

# Screenshots
echo "[+] Taking screenshots..."
if [ -s results/$DOMAIN/live_hosts.txt ]; then
    cat results/$DOMAIN/live_hosts.txt | aquatone -out results/$DOMAIN/aquatone
fi

echo "[+] Deep reconnaissance completed! Results saved in results/$DOMAIN/"
echo "[+] Summary:"
echo "    Subdomains found: $(wc -l < results/$DOMAIN/subdomains/all_subdomains.txt)"
echo "    Live hosts: $(wc -l < results/$DOMAIN/live_hosts.txt)"
if [ -f results/$DOMAIN/urls/all_urls.txt ]; then
    echo "    URLs gathered: $(wc -l < results/$DOMAIN/urls/all_urls.txt)"
fi
if [ -f results/$DOMAIN/js/js_files.txt ]; then
    echo "    JavaScript files: $(wc -l < results/$DOMAIN/js/js_files.txt)"
fi
