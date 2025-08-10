\# Bug Bounty Codespace Template



Open this repo in GitHub Codespaces (or add these files to an existing repo and create a codespace). The container will install a curated set of tools for initial bug bounty work.



\## Quick start



1\. Open in Codespaces

2\. Let the devcontainer build and execute `postCreateCommand` (runs the tool installer)

3\. Run `/workspace/tools/example-scan.sh domain.tld`



\## Customization

\- Edit `.devcontainer/Dockerfile` to add system packages.

\- Edit `scripts/install-tools.sh` to add or remove tools.



\## Security \& legal

\- Only target assets you have explicit permission to test.

\- Use safe scanning parameters and follow program scope and rules.

