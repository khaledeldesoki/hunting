#!/bin/bash
echo "🚀 Setting up bug bounty environment..."

# Ensure directories exist
mkdir -p /workspace/{results,targets,reports,configs}

# Set permissions for all scripts
chmod +x /workspace/scripts/*.sh

# Add scripts to PATH if not already there
if ! grep -q "/workspace/scripts" ~/.bashrc; then
    echo 'export PATH=$PATH:/workspace/scripts:/workspace/tools' >> ~/.bashrc
fi

# Create useful aliases
if ! grep -q "alias hunt=" ~/.bashrc; then
    echo 'alias hunt="cd /workspace"' >> ~/.bashrc
    echo 'alias results="cd /workspace/results"' >> ~/.bashrc
    echo 'alias tools="ls /workspace/tools"' >> ~/.bashrc
    echo 'alias ll="ls -la"' >> ~/.bashrc
fi

# Update nuclei templates
echo "[+] Updating Nuclei templates..."
nuclei -update-templates 2>/dev/null || echo "Nuclei templates will update on first run"

echo "✅ Environment setup completed!"
echo "🎯 Run 'bb_toolkit.sh' to start hunting!"
