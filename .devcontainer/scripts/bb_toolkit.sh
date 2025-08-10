#!/bin/bash

echo "🔍 Bug Bounty Toolkit - Choose your weapon:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "1.  Quick Recon (subfinder + httpx + aquatone)"
echo "2.  Deep Recon (comprehensive enumeration)"
echo "3.  Parameter Discovery"
echo "4.  XSS Testing"
echo "5.  Directory Bruteforce"
echo "6.  Nuclei Vulnerability Scan"
echo "7.  JavaScript Analysis"
echo "8.  CORS Testing"
echo "9.  JWT Analysis"
echo "10. SQL Injection Test"
echo "11. Cloud Storage Scanner"
echo "12. Git Secrets Scanner"
echo "13. Port Scan"
echo "14. Technology Detection"
echo "15. Show All Available Tools"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

read -p "Enter your choice (1-15): " choice

case $choice in
    1)
        read -p "Enter domain: " domain
        quick_recon.sh $domain
        ;;
    2)
        read -p "Enter domain: " domain
        deep_recon.sh $domain
        ;;
    3)
        read -p "Enter URL: " url
        param_discovery.sh $url
        ;;
    4)
        read -p "Enter URLs file path: " urls_file
        xss_test.sh $urls_file
        ;;
    5)
        read -p "Enter URL: " url
        echo "Choose wordlist:"
        echo "1) Common (fast)"
        echo "2) Big (medium)"
        echo "3) Directory list (thorough)"
        read -p "Choice: " wl_choice
        case $wl_choice in
            1) wordlist="/workspace/wordlists/SecLists/Discovery/Web-Content/common.txt" ;;
            2) wordlist="/workspace/wordlists/SecLists/Discovery/Web-Content/big.txt" ;;
            3) wordlist="/workspace/wordlists/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt" ;;
            *) wordlist="/workspace/wordlists/SecLists/Discovery/Web-Content/common.txt" ;;
        esac
        if [ -f "$wordlist" ]; then
            ffuf -w $wordlist -u $url/FUZZ -c -ac
        else
            echo "Wordlist not found. Using dirb instead..."
            dirb $url
        fi
        ;;
    6)
        read -p "Enter target (URL or file): " target
        nuclei -target $target -severity medium,high,critical
        ;;
    7)
        read -p "Enter domain or URL: " target
        echo "[+] Extracting JavaScript files..."
        getJS --complete --url $target
        echo "[+] Running LinkFinder..."
        python3 /workspace/tools/LinkFinder/linkfinder.py -i $target -o cli
        ;;
    8)
        read -p "Enter URLs file: " urls_file
        if [ -f "$urls_file" ]; then
            python3 /workspace/tools/CORScanner/cors_scan.py -i $urls_file
        else
            echo "File not found: $urls_file"
        fi
        ;;
    9)
        read -p "Enter JWT token: " token
        python3 /workspace/tools/jwt_tool/jwt_tool.py $token
        ;;
    10)
        read -p "Enter URL: " url
        echo "Running SQLmap with safe settings..."
        sqlmap -u "$url" --batch --level=2 --risk=2 --random-agent
        ;;
    11)
        read -p "Enter company name: " company
        echo "[+] Scanning for cloud storage..."
        python3 /workspace/tools/S3Scanner/s3scanner.py -l $company
        ;;
    12)
        read -p "Enter GitHub URL or local directory: " target
        echo "[+] Scanning for secrets..."
        if [[ $target == https://github.com/* ]]; then
            echo "GitHub scanning not available in this version"
        else
            echo "Local directory scanning not implemented yet"
        fi
        ;;
    13)
        read -p "Enter target (IP or domain): " target
        echo "Choose scan type:"
        echo "1) Quick scan (top 1000 ports)"
        echo "2) Full scan (all ports)"
        read -p "Choice: " scan_choice
        case $scan_choice in
            1) nmap -sS -T4 --top-ports 1000 $target ;;
            2) nmap -sS -T4 -p- $target ;;
        esac
        ;;
    14)
        read -p "Enter URL: " url
        echo "[+] Detecting technologies..."
        httpx -target $url -tech-detect
        ;;
    15)
        echo ""
        echo "🛠️  Available Tools:"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "📡 Subdomain Enumeration:"
        echo "   subfinder, assetfinder, sublist3r"
        echo ""
        echo "🌐 Web Probing & Analysis:"
        echo "   httpx, httprobe, aquatone"
        echo ""
        echo "🔍 URL & Endpoint Discovery:"
        echo "   gau, waybackurls, gospider, katana, hakrawler"
        echo ""
        echo "🚨 Vulnerability Scanning:"
        echo "   nuclei, nikto, sqlmap, naabu"
        echo ""
        echo "💥 Fuzzing & Discovery:"
        echo "   ffuf, gobuster, dirb"
        echo ""
        echo "🔢 Parameter Discovery:"
        echo "   arjun, paramspider"
        echo ""
        echo "⚡ XSS Testing:"
        echo "   dalfox, xsstrike"
        echo ""
        echo "📜 JavaScript Analysis:"
        echo "   getJS, linkfinder, subjs"
        echo ""
        echo "🔐 Specialized Testing:"
        echo "   jwt_tool (JWT), cors_scan (CORS), ssrfmap (SSRF)"
        echo ""
        echo "☁️  Cloud Security:"
        echo "   s3scanner, cloud_enum"
        echo ""
        echo "📂 Wordlists Location:"
        echo "   /workspace/wordlists/SecLists/"
        echo "   /workspace/wordlists/PayloadsAllTheThings/"
        echo ""
        echo "🎯 Custom Scripts:"
        echo "   quick_recon.sh, deep_recon.sh, bb_toolkit.sh"
        ;;
    *)
        echo "❌ Invalid choice"
        ;;
esac
