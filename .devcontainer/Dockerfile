# Use Ubuntu base
FROM ubuntu:22.04

# Avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Basic packages
RUN apt-get update && apt-get install -y \
  git curl wget unzip tar build-essential \
  python3 python3-pip python3-venv \
  golang-go golang \
  nodejs npm \
  openjdk-17-jre-headless \
  nmap masscan \
  jq \
  netcat \
  gcc make \
  dnsutils \
  gnupg2 ca-certificates lsb-release \
  chromium-browser \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root vscode user (Codespaces standard)
RUN useradd -m -s /bin/bash vscode || true
USER vscode
WORKDIR /workspace

ENV GOPATH=/workspace/gopath
ENV PATH=$PATH:/workspace/gopath/bin:/usr/local/go/bin

# Keep Dockerfile small; heavy tooling installed via script
COPY --chown=vscode:vscode scripts /workspace/scripts
RUN chmod +x /workspace/scripts/*.sh

CMD ["/bin/bash"]