FROM ubuntu:22.04

# Set non-interactive installation
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
    shodan \
    censys \
    pyfiglet \
    termcolor \
    'pyjwt[crypto]' \
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

# Install Go-based tools (Essential Bug Bounty Tools)
RUN go install -v github.com/tomnomnom/assetfinder@latest && \
    go install -v github.com/tomnomnom/httprobe@latest && \
    go install -v github.com/tomnomnom/waybackurls@latest && \
    go install -v github.com/tomnomnom/gf@latest && \
    go install -v github.com/tomnomnom/anew@latest && \
    go install -v github.com/tomnomnom/qsreplace@latest && \
    go install -v github.com/tomnomnom/unfurl@latest && \
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && \
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest && \
    go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest && \
    go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest && \
    go install -v github.com/projectdiscovery/katana/cmd/katana@latest && \
    go install -v github.com/projectdiscovery/proxify/cmd/proxify@latest && \
    go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest && \
    go install -v github.com/ffuf/ffuf/v2@latest && \
    go install -v github.com/OJ/gobuster/v3@latest && \
    go install -v github.com/lc/gau/v2/cmd/gau@latest && \
    go install -v github.com/hakluke/hakrawler@latest && \
    go install -v github.com/hahwul/dalfox/v2@latest && \
    go install -v github.com/jaeles-project/gospider@latest && \
    go install -v github.com/003random/getJS@latest && \
    go install -v github.com/lc/subjs@latest

# Install additional tools from GitHub
RUN cd /workspace/tools && \
    git clone https://github.com/aboul3la/Sublist3r.git && \
    cd Sublist3r && pip3 install -r requirements.txt

RUN cd /workspace/tools && \
    git clone https://github.com/s0md3v/XSStrike.git && \
    cd XSStrike && pip3 install -r requirements.txt

RUN cd /workspace/tools && \
    git clone https://github.com/devanshbatham/ParamSpider && \
    cd ParamSpider && pip3 install -r requirements.txt

RUN cd /workspace/tools && \
    git clone https://github.com/1ndianl33t/Gf-Patterns && \
    mkdir -p ~/.gf && \
    cp Gf-Patterns/*.json ~/.gf/ || true

RUN cd /workspace/tools && \
    git clone https://github.com/sa7mon/S3Scanner.git && \
    cd S3Scanner && pip3 install -r requirements.txt

RUN cd /workspace/tools && \
    git clone https://github.com/ticarpi/jwt_tool.git && \
    cd jwt_tool && python3 -m pip install termcolor cprint pycryptodomex requests

RUN cd /workspace/tools && \
    git clone https://github.com/chenjj/CORScanner.git && \
    cd CORScanner && pip3 install -r requirements.txt

RUN cd /workspace/tools && \
    git clone https://github.com/GerbenJavado/LinkFinder.git && \
    cd LinkFinder && pip3 install -r requirements.txt && \
    python3 setup.py install

RUN cd /workspace/tools && \
    git clone https://github.com/swisskyrepo/SSRFmap.git && \
    cd SSRFmap && pip3 install -r requirements.txt

# Install wordlists
RUN cd /workspace/wordlists && \
    git clone --depth 1 https://github.com/danielmiessler/SecLists.git && \
    git clone --depth 1 https://github.com/swisskyrepo/PayloadsAllTheThings.git

# Install aquatone manually
RUN wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip && \
    unzip aquatone_linux_amd64_1.7.0.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/aquatone && \
    rm aquatone_linux_amd64_1.7.0.zip

# Copy scripts directory
COPY scripts/ /workspace/scripts/

# Set up environment and aliases
RUN echo 'export PATH=$PATH:/workspace/scripts:/workspace/tools' >> ~/.bashrc && \
    echo 'alias hunt="cd /workspace"' >> ~/.bashrc && \
    echo 'alias tools="cd /workspace/tools"' >> ~/.bashrc && \
    echo 'alias wordlists="cd /workspace/wordlists"' >> ~/.bashrc && \
    echo 'alias results="cd /workspace/results"' >> ~/.bashrc && \
    echo 'alias ll="ls -la"' >> ~/.bashrc

# Create welcome message
RUN echo 'echo "🎯 Bug Bounty Environment Ready!"' >> ~/.bashrc && \
    echo 'echo "Run: bb_toolkit.sh for interactive menu"' >> ~/.bashrc && \
    echo 'echo "Quick start: quick_recon.sh <domain>"' >> ~/.bashrc

# Update Nuclei templates (this might fail in some environments, so make it optional)
RUN nuclei -update-templates || echo "Nuclei templates will be updated on first run"

# Set working directory and default command
WORKDIR /workspace
CMD ["bash"]