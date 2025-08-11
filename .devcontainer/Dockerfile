# Use Kali rolling image
FROM docker.io/kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

# Keep small-ish; install core pentest packages and common utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      sudo wget curl git python3 python3-pip python3-venv \
      golang-go nodejs npm openjdk-17-jre-headless \
      nmap masscan jq netcat gnupg2 ca-certificates lsb-release \
      build-essential unzip tar dnsutils iproute2 iputils-ping \
      neofetch vim tmux htop less \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create non-root user 'vscode' (Codespaces convention)
RUN useradd -m -s /bin/bash vscode || true \
    && echo "vscode ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vscode \
    && chmod 0440 /etc/sudoers.d/vscode

USER vscode
WORKDIR /workspace

# Copy install script; will be run as vscode by postCreateCommand
COPY --chown=vscode:vscode scripts /workspace/scripts
RUN chmod +x /workspace/scripts/*.sh

CMD [ "bash" ]
