FROM ubuntu:22.04

# Set non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Install basic utilities and Kali-like common tools
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
    net-tools \
    iputils-ping \
    nmap \
    hydra \
    john \
    sqlmap \
    nikto \
    whois \
    dnsutils \
    netcat \
    tmux \
    zsh \
    build-essential \
    && apt-get clean

# Optional: install Metasploit Framework from Rapid7 (not from Kali, but widely used)
RUN curl https://raw.githubusercontent.com/rapid7/metasploit-framework/master/msfinstall > msfinstall && \
    chmod 755 msfinstall && \
    ./msfinstall && \
    rm msfinstall

# Set default shell to bash (or zsh if you prefer)
CMD [ "bash" ]