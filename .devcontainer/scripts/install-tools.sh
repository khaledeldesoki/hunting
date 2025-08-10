#!/usr/bin/env bash
set -euo pipefail

# This script installs many common bug-bounty tools into the Codespace.
# It is idempotent: re-running is safe.

export GOPATH=/workspace/gopath
export PATH=$PATH:$GOPATH/bin:$HOME/.local/bin
mkdir -p "$GOPATH/bin"

echo "[+] Updating apt and installing python/node helpers (may ask for sudo)..."
# apt packages already installed in Dockerfile; ensure pip packages and python tools
python3 -m pip install --user --upgrade pip setuptools wheel
python3 -m pip install --user linkfinder requests

echo "[+] Installing Go tools (this may take a few minutes)..."
# Use 'go install' to get latest versions in GOPATH/bin
# If go is missing on host, user must install it.
export GO111MODULE=on

# Subdomain & discovery
go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install github.com/tomnomnom/assetfinder@latest
go install github.com/OWASP/Amass/v3/...@latest || true

# Probing / HTTP
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/tomnomnom/httprobe@latest

# Fuzzing / brute
go install github.com/ffuf/ffuf@latest

# Web archive & URLs
go install github.com/tomnomnom/waybackurls@latest
go install github.com/lc/gau/v2/cmd/gau@latest

# Directory discovery
go install github.com/jaeles-project/gospider@latest || true

# Misc
go install github.com/ffuf/ffuf@latest || true

# Node-based or python tools
echo "[+] Installing Node & npm tools (gau, waybackurls already installed)..."
npm install -g sox || true

# Install amass via apt fallback if go install failed
if ! command -v amass >/dev/null 2>&1; then
  echo "[i] amass not found via go install; attempting apt-get"
  sudo apt-get update && sudo apt-get install -y amass || true
fi

# Add some convenience scripts
mkdir -p /workspace/tools
cat > /workspace/tools/example-scan.sh <<'EOF'
#!/usr/bin/env bash
# Example: run a light discovery pipeline
set -e
if [ -z "${1:-}" ]; then
  echo "Usage: $0 domain.tld"
  exit 1
fi
DOMAIN=$1
subfinder -d "$DOMAIN" -silent > subs.txt || true
assetfinder --subs-only "$DOMAIN" >> subs.txt || true
sort -u subs.txt -o subs.txt
cat subs.txt | httpx -silent -ports 80,443 -o live.txt
EOF
chmod +x /workspace/tools/example-scan.sh

# Python helpers installed
python3 -m pip install --user virtualenv

# Final message
echo "[+] Installation complete. PATH includes: $GOPATH/bin and ~/.local/bin"
echo "Try: /workspace/tools/example-scan.sh example.com"