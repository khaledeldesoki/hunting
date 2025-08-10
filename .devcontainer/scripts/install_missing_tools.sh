#!/bin/bash
echo "🔧 Installing any missing tools..."

# Ensure Go is in PATH
export PATH=$PATH:/usr/local/go/bin

# Install essential Go tools if missing
echo "[+] Checking Go tools..."
go install -v github.com/tomnomnom/assetfinder@latest 2>/dev/null || echo "assetfinder install failed"
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest 2>/dev/null || echo "subfinder install failed"
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest 2>/dev/null || echo "httpx install failed"
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest 2>/dev/null || echo "nuclei install failed"
go install -v github.com/ffuf/ffuf/v2@latest 2>/dev/null || echo "ffuf install failed"

# Update nuclei templates
echo "[+] Updating Nuclei templates..."
nuclei -update-templates 2>/dev/null || echo "Nuclei template update failed"

echo "✅ Tool installation check completed!"
