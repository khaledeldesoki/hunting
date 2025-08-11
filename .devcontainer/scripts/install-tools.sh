#!/usr/bin/env bash
set -euo pipefail

# This runs as the 'vscode' user inside the devcontainer.
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:$HOME/.local/bin
mkdir -p "$GOPATH/bin" "$HOME/.local/bin" "$HOME/tools"

echo "[*] Updating pip and installing Python helpers..."
python3 -m pip install --user --upgrade pip setuptools wheel

echo "[*] Installing common utilities (may use sudo)..."
sudo apt-get update -y
sudo apt-get install -y --no-install-recommends unzip

# Install Go tools (subfinder, httpx, assetfinder, waybackurls, gau, ffuf, httprobe)
if command -v go >/dev/null 2>&1; then
  echo "[*] Installing Go-based tools..."
  GO111MODULE=on go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
  go install github.com/tomnomnom/assetfinder@latest
  go install github.com/projectdiscovery/httpx/cmd/httpx@latest
  go install github.com/tomnomnom/httprobe@latest
  go install github.com/tomnomnom/waybackurls@latest
  go install github.com/lc/gau/v2/cmd/gau@latest
  go install github.com/ffuf/ffuf@latest
else
  echo "[!] go not found - skipping go install steps. (golang-go should be in the image.)"
fi

# Install LinkFinder (python)
echo "[*] Installing LinkFinder..."
if [ ! -d "$HOME/tools/LinkFinder" ]; then
  git clone https://github.com/GerbenJavado/LinkFinder.git "$HOME/tools/LinkFinder"
fi
python3 -m pip install --user -r "$HOME/tools/LinkFinder/requirements.txt" || true
cat > "$HOME/.local/bin/linkfinder" <<'PY'
#!/usr/bin/env bash
python3 "$HOME/tools/LinkFinder/linkfinder.py" "$@"
PY
chmod +x "$HOME/.local/bin/linkfinder"

# Install sqlmap
echo "[*] Installing sqlmap..."
if [ ! -d "$HOME/tools/sqlmap" ]; then
  git clone --depth=1 https://github.com/sqlmapproject/sqlmap.git "$HOME/tools/sqlmap"
fi
cat > "$HOME/.local/bin/sqlmap" <<'PY'
#!/usr/bin/env bash
python3 "$HOME/tools/sqlmap/sqlmap.py" "$@"
PY
chmod +x "$HOME/.local/bin/sqlmap"

# small helper script
cat > /workspace/tools/example-scan.sh <<'EOF'
#!/usr/bin/env bash
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

# Add PATH persistence to .bashrc
if ! grep -q 'export GOPATH' "$HOME/.bashrc" 2>/dev/null; then
  cat >> "$HOME/.bashrc" <<'RC'
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:$HOME/.local/bin
RC
fi

echo "[+] Installation finished. Open a new terminal or run: source ~/.bashrc"
echo "Sample checks: subfinder, assetfinder, httpx, linkfinder, sqlmap"
