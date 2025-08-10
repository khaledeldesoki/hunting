ion
ENV DEBIAN_FRONTEND=noninteractive
ENV GOPATH=/root/go
ENV PATH=$PATH:/root/go/bin:/usr/local/go/bin:/workspace/scripts

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
    dirb \
    dirbuster \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Go
RUN wget https://go.dev/dl/go1.21.6.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.21.6.linux-amd64.tar.gz && \
    rm go1.21.6.linux-amd64.tar.gz

# Install Rust and Cargo
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Create directories for tools
RUN mkdir -p /workspace/tools /workspace/wordlists /workspace/scripts /workspace/results /workspace/targets /workspace/reports

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
    pyjwt[crypto] \
    flask \
    django \
    scrapy \
    cloud_enum \
    arjun \
    awscli \
    boto3 \
    azure-cli \
    graphql-core

# Install Node.js tools
RUN npm install -g \
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
    go install -v github.com/tomnomnom/qsreplace@latest && \
    go install -v github.com/tomnomnom/freq@latest && \
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && \
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest && \
    go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest && \
    go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest && \
    go install -v github.com/projectdiscovery/chaos-client/cmd/chaos@latest && \
    go install -v github.com/projectdiscovery/notify/cmd/notify@latest && \
    go install -v github.com/projectdiscovery/katana/cmd/katana@latest && \
    go install -v github.com/projectdiscovery/alterx/cmd/alterx@latest && \
    go install -v github.com/projectdiscovery/proxify/cmd/proxify@latest && \
    go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest && \
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
    go install -v github.com/lc/subjs@latest && \
    go install -v github.com/bp0lr/gauplus@latest && \
    go install -v github.com/ferreiraklet/airixss@latest && \
    go install -v github.com/dwisiswant0/unew@latest

# Install additional tools from GitHub
RUN cd /workspace/tools && \
    git clone https://github.com/aboul3la/Sublist3r.git && \
    cd Sublist3r && pip3 install -r requirements.txt

RUN cd /workspace/tools && \
    git clone https://github.com/obheda12/GitDorker.git && \
    cd GitDorker && pip3 install -r requirements.txt

RUN cd /workspace/tools && \
    git clone https://github.com/trufflesecurity/truffleHog.git && \
    cd truffleHog && go mod download && go build

RUN cd /workspace/tools && \
    git clone https://github.com/s0md3v/XSStrike.git && \
    cd XSStrike && pip3 install -r requirements.txt

RUN cd /workspace/tools && \
    git clone https://github.com/devanshbatham/ParamSpider && \
    cd ParamSpider && pip3 install -r requirements.txt

RUN cd /workspace/tools && \
    git clone https://github.com/1ndianl33t/Gf-Patterns && \
    mkdir -p ~/.gf && \
    cp Gf-Patterns/*.json ~/.gf/

RUN cd /workspace/tools && \
    git clone https://github.com/NotSoSecure/cloud_enum.git

RUN cd /workspace/tools && \
    git clone https://github.com/sa7mon/S3Scanner.git && \
    cd S3Scanner && pip3 install -r requirements.txt

RUN cd /workspace/tools && \
    git clone https://github.com/EnableSecurity/wafw00f.git && \
    cd wafw00f && python3 setup.py install

RUN cd /workspace/tools && \
    git clone https://github.com/christophetd/CloudFlair.git && \
    cd CloudFlair && pip3 install -r requirements.txt

RUN cd /workspace/tools && \
    git clone https://github.com/swisskyrepo/SSRFmap.git && \
    cd SSRFmap && pip3 install -r requirements.txt

RUN cd /workspace/tools && \
    git clone https://github.com/ticarpi/jwt_tool.git && \
    cd jwt_tool && python3 -m pip install termcolor cprint pycryptodomex requests

RUN cd /workspace/tools && \
    git clone https://github.com/codingo/NoSQLMap.git && \
    cd NoSQLMap && python3 setup.py install

RUN cd /workspace/tools && \
    git clone https://github.com/chenjj/CORScanner.git && \
    cd CORScanner && pip3 install -r requirements.txt

RUN cd /workspace/tools && \
    git clone https://github.com/PortSwigger/turbo-intruder.git

RUN cd /workspace/tools && \
    git clone https://github.com/xmendez/wfuzz.git && \
    cd wfuzz && python3 setup.py install

# Install LinkFinder
RUN cd /workspace/tools && \
    git clone https://github.com/GerbenJavado/LinkFinder.git && \
    cd LinkFinder && pip3 install -r requirements.txt && \
    python3 setup.py install

# Install wordlists
RUN cd /workspace/wordlists && \
    git clone https://github.com/danielmiessler/SecLists.git && \
    git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git && \
    git clone https://github.com/fuzzdb-project/fuzzdb.git

# Install aquatone manually
RUN wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip && \
    unzip aquatone_linux_amd64_1.7.0.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/aquatone && \
    rm aquatone_linux_amd64_1.7.0.zip

# Update Nuclei templates
RUN nuclei -update-templates

# Copy script files
COPY scripts/ /workspace/scripts/
RUN chmod +x /workspace/scripts/*.sh

# Set up aliases and environment
RUN echo 'alias ll="ls -la"' >> ~/.bashrc && \
    echo 'alias la="ls -A"' >> ~/.bashrc && \
    echo 'alias l="ls -CF"' >> ~/.bashrc && \
    echo 'alias hunt="cd /workspace"' >> ~/.bashrc && \
    echo 'alias tools="cd /workspace/tools"' >> ~/.bashrc && \
    echo 'alias wordlists="cd /workspace/wordlists"' >> ~/.bashrc && \
    echo 'export PATH=$PATH:/workspace/tools:/workspace/scripts' >> ~/.bashrc

# Create subfinder config
RUN mkdir -p ~/.config/subfinder && \
    echo 'sources:' > ~/.config/subfinder/config.yaml && \
    echo '  - chaos' >> ~/.config/subfinder/config.yaml && \
    echo '  - crtsh' >> ~/.config/subfinder/config.yaml && \
    echo '  - certspotter' >> ~/.config/subfinder/config.yaml && \
    echo '  - threatcrowd' >> ~/.config/subfinder/config.yaml && \
    echo '  - virustotal' >> ~/.config/subfinder/config.yaml

# Create README
RUN echo '# Bug Bounty Hunting Environment' > /workspace/README.md && \
    echo '' >> /workspace/README.md && \
    echo 'Welcome to your comprehensive bug bounty hunting environment!' >> /workspace/README.md && \
    echo '' >> /workspace/README.md && \
    echo '## Quick Start' >> /workspace/README.md && \
    echo '- Run `bb_toolkit.sh` for an interactive menu' >> /workspace/README.md && \
    echo '- Use `quick_recon.sh <domain>` for fast reconnaissance' >> /workspace/README.md && \
    echo '- Use `deep_recon.sh <domain>` for thorough enumeration' >> /workspace/README.md && \
    echo '' >> /workspace/README.md && \
    echo '## Directory Structure' >> /workspace/README.md && \
    echo '- `/workspace/tools/` - All installed tools' >> /workspace/README.md && \
    echo '- `/workspace/scripts/` - Custom automation scripts' >> /workspace/README.md && \
    echo '- `/workspace/wordlists/` - Various wordlists' >> /workspace/README.md && \
    echo '- `/workspace/results/` - Your scan results' >> /workspace/README.md && \
    echo '- `/workspace/targets/` - Target information' >> /workspace/README.md && \
    echo '- `/workspace/reports/` - Your reports' >> /workspace/README.md && \
    echo '' >> /workspace/README.md && \
    echo 'Happy Hunting! 🎯' >> /workspace/README.md

# Set working directory and default command
WORKDIR /workspace
CMD ["bash", "-c", "echo '🎯 Bug bounty environment ready! Check README.md for usage.' && cat README.md && exec bash"]
