
FROM ubuntu:22.04

# Set non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive
ENV GOPATH=/root/go
ENV PATH=$PATH:/root/go/bin:/usr/local/go/bin

# Create workspace directory
WORKDIR /workspace

# Install basic utilities and system packages
RUN apt-get update && \
    apt-get install -y \
    sudo \
    wget \
    curl \
    gnupg2 \
    lsb-release \
    git \
    python3 \
    python3-pip \
    python3-venv \
    net-tools \
    iputils-ping \
    nmap \
    masscan \
    hydra \
    john \
    sqlmap \
    nikto \
    whois \
    dnsutils \
    netcat-openbsd \
    tmux \
    zsh \
    build-essential \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    unzip \
    jq \
    tree \
    vim \
    nano \
    htop \
    screen \
    parallel \
    nodejs \
    npm \
    chromium-browser \
    xvfb \
    && apt-get clean

# Install Go
RUN wget https://go.dev/dl/go1.21.6.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.21.6.linux-amd64.tar.gz && \
    rm go1.21.6.linux-amd64.tar.gz

# Install Rust and Cargo
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Create directories for tools
RUN mkdir -p /workspace/tools /workspace/wordlists /workspace/scripts

# Install Python tools
RUN pip3 install --upgrade pip && \
    pip3 install \
    requests \
    beautifulsoup4 \
    selenium \
    paramiko \
    dnspython \
    pycryptodome \
    colorama \
    tldextract \
    urllib3 \
    aiohttp \
    asyncio \
    shodan \
    censys \
    pyfiglet \
    termcolor \
    jwt \
    flask \
    django \
    scrapy

# Install Node.js tools
RUN npm install -g \
    linkfinder \
    retire \
    eslint \
    js-beautify

# Install Go-based tools (Bug Bounty Essentials)
RUN go install -v github.com/tomnomnom/assetfinder@latest && \
    go install -v github.com/tomnomnom/httprobe@latest && \
    go install -v github.com/tomnomnom/waybackurls@latest && \
    go install -v github.com/tomnomnom/gf@latest && \
    go install -v github.com/tomnomnom/anew@latest && \
    go install -v github.com/tomnomnom/meg@latest && \
    go install -v github.com/tomnomnom/gron@latest && \
    go install -v github.com/tomnomnom/unfurl@latest && \
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && \
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest && \
    go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest && \
    go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest && \
    go install -v github.com/projectdiscovery/chaos-client/cmd/chaos@latest && \
    go install -v github.com/projectdiscovery/notify/cmd/notify@latest && \
    go install -v github.com/projectdiscovery/katana/cmd/katana@latest && \
    go install -v github.com/projectdiscovery/alterx/cmd/alterx@latest && \
    go install -v github.com/owasp-amass/amass/v4/...@master && \
    go install -v github.com/ffuf/ffuf/v2@latest && \
    go install -v github.com/OJ/gobuster/v3@latest && \
    go install -v github.com/lc/gau/v2/cmd/gau@latest && \
    go install -v github.com/hakluke/hakrawler@latest && \
    go install -v github.com/hakluke/hakrevdns@latest && \
    go install -v github.com/hakluke/haklistgen@latest && \
    go install -v github.com/hahwul/dalfox/v2@latest && \
    go install -v github.com/dwisiswant0/crlfuzz/cmd/crlfuzz@latest && \
    go install -v github.com/michenriksen/aquatone@latest && \
    go install -v github.com/jaeles-project/gospider@latest && \
    go install -v github.com/003random/getJS@latest && \
    go install -v github.com/glebarez/cero@latest && \
    go install -v github.com/projectdiscovery/proxify/cmd/proxify@latest && \
    go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest && \
    go install -v github.com/lc/subjs@latest && \
    go install -v github.com/tomnomnom/qsreplace@latest && \
    go install -v github.com/tomnomnom/freq@latest && \
    go install -v github.com/bp0lr/gauplus@latest && \
    go install -v github.com/ferreiraklet/airixss@latest && \
    go install -v github.com/dwisiswant0/unew@latest

# Install additional reconnaissance tools
RUN git clone https://github.com/aboul3la/Sublist3r.git /workspace/tools/Sublist3r && \
    cd /workspace/tools/Sublist3r && pip3 install -r requirements.txt

# Install GitDorker for GitHub reconnaissance
RUN git clone https://github.com/obheda12/GitDorker.git /workspace/tools/GitDorker && \
    cd /workspace/tools/GitDorker && pip3 install -r requirements.txt

# Install truffleHog for secret scanning
RUN git clone https://github.com/trufflesecurity/truffleHog.git /workspace/tools/truffleHog && \
    cd /workspace/tools/truffleHog && go mod download && go build

# Install XSStrike
RUN git clone https://github.com/s0md3v/XSStrike.git /workspace/tools/XSStrike && \
    cd /workspace/tools/XSStrike && pip3 install -r requirements.txt

# Install Arjun for parameter discovery
RUN git clone https://github.com/s0md3v/Arjun.git /workspace/tools/Arjun && \
    cd /workspace/tools/Arjun && python3 setup.py install

# Install ParamSpider
RUN git clone https://github.com/devanshbatham/ParamSpider /workspace/tools/ParamSpider && \
    cd /workspace/tools/ParamSpider && pip3 install -r requirements.txt

# Install Gf patterns
RUN git clone https://github.com/1ndianl33t/Gf-Patterns /workspace/tools/Gf-Patterns && \
    mkdir -p ~/.gf && \
    cp /workspace/tools/Gf-Patterns/*.json ~/.gf/

# Install SecLists wordlists
RUN git clone https://github.com/danielmiessler/SecLists.git /workspace/wordlists/SecLists

# Install PayloadsAllTheThings
RUN git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git /workspace/wordlists/PayloadsAllTheThings

# Install FuzzDB
RUN git clone https://github.com/fuzzdb-project/fuzzdb.git /workspace/wordlists/fuzzdb

# Install cloud enumeration tools
RUN pip3 install cloud_enum && \
    git clone https://github.com/NotSoSecure/cloud_enum.git /workspace/tools/cloud_enum

# Install S3 bucket tools
RUN git clone https://github.com/sa7mon/S3Scanner.git /workspace/tools/S3Scanner && \
    cd /workspace/tools/S3Scanner && pip3 install -r requirements.txt

# Install Burp Suite Community (manual download required)
RUN wget "https://portswigger-cdn.net/burp/releases/download?product=community&version=2023.10.3.7&type=Linux" -O burpsuite.sh && \
    chmod +x burpsuite.sh

# Install additional web testing tools
RUN wget https://github.com/michenriksen/aquatone/releases/latest/download/aquatone_linux_amd64_1.7.0.zip && \
    unzip aquatone_linux_amd64_1.7.0.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/aquatone && \
    rm aquatone_linux_amd64_1.7.0.zip

# Install dirb and dirbuster
RUN apt-get install -y dirb dirbuster

# Install JWT tools
RUN pip3 install pyjwt[crypto] && \
    git clone https://github.com/ticarpi/jwt_tool.git /workspace/tools/jwt_tool && \
    cd /workspace/tools/jwt_tool && \
    python3 -m pip install termcolor cprint pycryptodomex requests

# Install mobile testing tools
RUN git clone https://github.com/MobSF/Mobile-Security-Framework-MobSF.git /workspace/tools/MobSF

# Install API testing tools
RUN pip3 install arjun && \
    git clone https://github.com/assetnote/kiterunner.git /workspace/tools/kiterunner && \
    cd /workspace/tools/kiterunner && make build

# Install GraphQL testing tools
RUN git clone https://github.com/doyensec/graph-ql-voyager.git /workspace/tools/graphql-voyager && \
    pip3 install graphql-core

# Install container and cloud security tools
RUN curl -sSL https://get.docker.com/ | sh || true && \
    pip3 install awscli boto3 azure-cli

# Install advanced fuzzing tools
RUN git clone https://github.com/xmendez/wfuzz.git /workspace/tools/wfuzz && \
    cd /workspace/tools/wfuzz && python3 setup.py install

# Create useful aliases and functions
RUN echo 'alias ll="ls -la"' >> ~/.bashrc && \
    echo 'alias la="ls -A"' >> ~/.bashrc && \
    echo 'alias l="ls -CF"' >> ~/.bashrc && \
    echo 'alias hunt="cd /workspace"' >> ~/.bashrc && \
    echo 'alias tools="cd /workspace/tools"' >> ~/.bashrc && \
    echo 'alias wordlists="cd /workspace/wordlists"' >> ~/.bashrc && \
    echo 'export PATH=$PATH:/workspace/tools' >> ~/.bashrc

# Create useful scripts
RUN cat > /workspace/scripts/quick_recon.sh << 'EOF'
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
cat results/$DOMAIN/live_hosts.txt | aquatone -out results/$DOMAIN/aquatone

echo "[+] Quick reconnaissance completed! Results saved in results/$DOMAIN/"
EOF

RUN chmod +x /workspace/scripts/quick_recon.sh

# Create advanced recon script
RUN cat > /workspace/scripts/deep_recon.sh << 'EOF'
#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

DOMAIN=$1
mkdir -p results/$DOMAIN/{subdomains,urls,js,nuclei,endpoints}

echo "[+] Starting deep reconnaissance for $DOMAIN"

# Subdomain enumeration
echo "[+] Running multiple subdomain enumeration tools..."
subfinder -d $DOMAIN -o results/$DOMAIN/subdomains/subfinder.txt
assetfinder --subs-only $DOMAIN > results/$DOMAIN/subdomains/assetfinder.txt
amass enum -passive -d $DOMAIN -o results/$DOMAIN/subdomains/amass.txt

# Combine and deduplicate
cat results/$DOMAIN/subdomains/*.txt | sort -u > results/$DOMAIN/subdomains/all_subdomains.txt

# Probe for live hosts
echo "[+] Probing for live hosts..."
cat results/$DOMAIN/subdomains/all_subdomains.txt | httpx -ports 80,443,8080,8443,3000,5000,8000,9000 -o results/$DOMAIN/live_hosts.txt

# Port scanning
echo "[+] Running port scan on live hosts..."
naabu -l results/$DOMAIN/live_hosts.txt -o results/$DOMAIN/open_ports.txt

# URL gathering
echo "[+] Gathering URLs..."
cat results/$DOMAIN/live_hosts.txt | gau > results/$DOMAIN/urls/gau.txt
cat results/$DOMAIN/live_hosts.txt | waybackurls > results/$DOMAIN/urls/wayback.txt
cat results/$DOMAIN/urls/*.txt | sort -u > results/$DOMAIN/urls/all_urls.txt

# JavaScript file discovery
echo "[+] Finding JavaScript files..."
cat results/$DOMAIN/urls/all_urls.txt | grep -E "\.js$" > results/$DOMAIN/js/js_files.txt
cat results/$DOMAIN/live_hosts.txt | getJS --complete > results/$DOMAIN/js/getjs_output.txt

# Endpoint discovery from JS
echo "[+] Extracting endpoints from JavaScript..."
cat results/$DOMAIN/js/js_files.txt | while read url; do
    echo "Processing: $url"
    curl -s "$url" | linkfinder -o cli >> results/$DOMAIN/endpoints/js_endpoints.txt
done

# Nuclei scanning
echo "[+] Running Nuclei scans..."
nuclei -l results/$DOMAIN/live_hosts.txt -o results/$DOMAIN/nuclei/vulnerabilities.txt

# Screenshots
echo "[+] Taking screenshots..."
cat results/$DOMAIN/live_hosts.txt | aquatone -out results/$DOMAIN/aquatone

echo "[+] Deep reconnaissance completed! Results saved in results/$DOMAIN/"
echo "[+] Summary:"
echo "    Subdomains found: $(wc -l < results/$DOMAIN/subdomains/all_subdomains.txt)"
echo "    Live hosts: $(wc -l < results/$DOMAIN/live_hosts.txt)"
echo "    URLs gathered: $(wc -l < results/$DOMAIN/urls/all_urls.txt)"
echo "    JavaScript files: $(wc -l < results/$DOMAIN/js/js_files.txt)"
EOF

RUN chmod +x /workspace/scripts/deep_recon.sh

# Create parameter discovery script
RUN cat > /workspace/scripts/param_discovery.sh << 'EOF'
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
python3 /workspace/tools/Arjun/arjun.py -u $URL -o results/$DOMAIN/parameters/arjun.txt

# ParamSpider
echo "[+] Running ParamSpider..."
cd /workspace/tools/ParamSpider
python3 paramspider.py --domain $DOMAIN --output /workspace/results/$DOMAIN/parameters/paramspider.txt

echo "[+] Parameter discovery completed!"
EOF

RUN chmod +x /workspace/scripts/param_discovery.sh

# Create XSS testing script
RUN cat > /workspace/scripts/xss_test.sh << 'EOF'
#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <urls_file>"
    exit 1
fi

URLS_FILE=$1
DOMAIN=$(basename $URLS_FILE .txt)
mkdir -p results/$DOMAIN/xss

echo "[+] Testing for XSS vulnerabilities..."

# Using dalfox
echo "[+] Running dalfox..."
cat $URLS_FILE | dalfox pipe --output results/$DOMAIN/xss/dalfox.txt

# Using XSStrike
echo "[+] Running XSStrike on URLs with parameters..."
cat $URLS_FILE | grep "=" | head -20 | while read url; do
    echo "Testing: $url"
    python3 /workspace/tools/XSStrike/xsstrike.py -u "$url" --crawl >> results/$DOMAIN/xss/xsstrike.txt
done

echo "[+] XSS testing completed!"
EOF

RUN chmod +x /workspace/scripts/xss_test.sh

# Install additional manual tools
RUN git clone https://github.com/EnableSecurity/wafw00f.git /workspace/tools/wafw00f && \
    cd /workspace/tools/wafw00f && python3 setup.py install

# Install CloudFlare bypass tools
RUN git clone https://github.com/christophetd/CloudFlair.git /workspace/tools/CloudFlair && \
    cd /workspace/tools/CloudFlair && pip3 install -r requirements.txt

# Install SSRF testing tools
RUN git clone https://github.com/swisskyrepo/SSRFmap.git /workspace/tools/SSRFmap && \
    cd /workspace/tools/SSRFmap && pip3 install -r requirements.txt

# Install JWT testing tools
RUN git clone https://github.com/ticarpi/jwt_tool.git /workspace/tools/jwt_tool && \
    cd /workspace/tools/jwt_tool && python3 -m pip install termcolor cprint pycryptodomex requests

# Install NoSQL injection tools
RUN git clone https://github.com/codingo/NoSQLMap.git /workspace/tools/NoSQLMap && \
    cd /workspace/tools/NoSQLMap && python3 setup.py install

# Install CORS testing tools
RUN git clone https://github.com/chenjj/CORScanner.git /workspace/tools/CORScanner && \
    cd /workspace/tools/CORScanner && pip3 install -r requirements.txt

# Install race condition testing tools
RUN git clone https://github.com/PortSwigger/turbo-intruder.git /workspace/tools/turbo-intruder

# Update Nuclei templates
RUN nuclei -update-templates

# Create results directory structure
RUN mkdir -p /workspace/results /workspace/targets /workspace/reports

# Create useful configuration files
RUN cat > /workspace/tools/subfinder_config.yaml << 'EOF'
# Subfinder configuration
version: 2
sources:
  - chaos
  - crtsh
  - certspotter
  - threatcrowd
  - virustotal
  - sublist3r
resolvers:
  - 1.1.1.1
  - 1.0.0.1
  - 8.8.8.8
  - 8.8.4.4
EOF

# Create a comprehensive bug bounty toolkit script
RUN cat > /workspace/scripts/bb_toolkit.sh << 'EOF'
#!/bin/bash

echo "Bug Bounty Toolkit - Choose your weapon:"
echo "1. Quick Recon (subfinder + httpx + aquatone)"
echo "2. Deep Recon (comprehensive enumeration)"
echo "3. Parameter Discovery"
echo "4. XSS Testing"
echo "5. Directory Bruteforce"
echo "6. Nuclei Vulnerability Scan"
echo "7. JavaScript Analysis"
echo "8. CORS Testing"
echo "9. JWT Analysis"
echo "10. Custom Scan"

read -p "Enter your choice (1-10): " choice

case $choice in
    1)
        read -p "Enter domain: " domain
        /workspace/scripts/quick_recon.sh $domain
        ;;
    2)
        read -p "Enter domain: " domain
        /workspace/scripts/deep_recon.sh $domain
        ;;
    3)
        read -p "Enter URL: " url
        /workspace/scripts/param_discovery.sh $url
        ;;
    4)
        read -p "Enter URLs file path: " urls_file
        /workspace/scripts/xss_test.sh $urls_file
        ;;
    5)
        read -p "Enter URL: " url
        ffuf -w /workspace/wordlists/SecLists/Discovery/Web-Content/common.txt -u $url/FUZZ
        ;;
    6)
        read -p "Enter target (URL or file): " target
        nuclei -target $target
        ;;
    7)
        read -p "Enter domain: " domain
        getJS --complete --url $domain
        ;;
    8)
        read -p "Enter URLs file: " urls_file
        python3 /workspace/tools/CORScanner/cors_scan.py -i $urls_file
        ;;
    9)
        read -p "Enter JWT token: " token
        python3 /workspace/tools/jwt_tool/jwt_tool.py $token
        ;;
    10)
        echo "Available tools in PATH:"
        echo "Go tools: subfinder, httpx, nuclei, naabu, dnsx, katana, etc."
        echo "Python tools: sqlmap, nikto, arjun, xsstrike, etc."
        echo "Custom scripts in /workspace/scripts/"
        ;;
    *)
        echo "Invalid choice"
        ;;
esac
EOF

RUN chmod +x /workspace/scripts/bb_toolkit.sh

# Set up PATH and environment
ENV PATH="/workspace/scripts:$PATH"

# Create welcome message
RUN cat > /workspace/README.md << 'EOF'
# Bug Bounty Hunting Environment

Welcome to your comprehensive bug bounty hunting environment!

## Quick Start
- Run `bb_toolkit.sh` for an interactive menu
- Use `quick_recon.sh <domain>` for fast reconnaissance
- Use `deep_recon.sh <domain>` for thorough enumeration

## Available Tools

### Subdomain Enumeration
- subfinder, assetfinder, amass, sublist3r

### Web Probing & Screenshots
- httpx, httprobe, aquatone

### URL & Endpoint Discovery
- gau, waybackurls, gospider, katana, hakrawler

### Directory & Parameter Discovery
- ffuf, gobuster, arjun, paramspider

### Vulnerability Scanning
- nuclei, nikto, sqlmap

### Specialized Testing
- dalfox (XSS), jwt_tool (JWT), corsscanner (CORS)
- xsstrike, ssrfmap, nosqlmap

### JavaScript Analysis
- getJS, linkfinder, subjs

### Cloud Security
- cloud_enum, S3Scanner

## Wordlists
- SecLists: `/workspace/wordlists/SecLists/`
- PayloadsAllTheThings: `/workspace/wordlists/PayloadsAllTheThings/`
- FuzzDB: `/workspace/wordlists/fuzzdb/`

## Directory Structure
- `/workspace/tools/` - All installed tools
- `/workspace/scripts/` - Custom automation scripts
- `/workspace/wordlists/` - Various wordlists
- `/workspace/results/` - Your scan results
- `/workspace/targets/` - Target information
- `/workspace/reports/` - Your reports

Happy Hunting! 
EOF

# Set working directory and shell
WORKDIR /workspace
CMD ["bash", "-c", "cat README.md && exec bash"]