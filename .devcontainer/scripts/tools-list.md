# Tools included / installed (template)

**Installed or bootstrapped by the devcontainer template**

- subfinder (Go) — passive subdomain discovery
- assetfinder (Go) — quick subdomain collection
- amass (Go) — passive + active enumeration (may be apt fallback)
- httpx (Go) — probe web services, screenshots
- httprobe (Go) — probe 80/443
- waybackurls (Go) / gau — gather historical URLs
- ffuf (Go) — fuzzing
- gospider (Go) — spidering
- linkfinder (Python) — extract JS endpoints
- masscan, nmap — network scanning (installed in image)
- jq, curl, wget, git, python3, node

**Notes on GUI apps**
- Burp Suite Professional: not installed. You can run Burp locally and point your browser to Codespace-hosted webapps via port-forwarding, or run Burp on your laptop and proxy through it. For automation and CI, consider using OWASP ZAP which can run headless in Codespaces.
- ZAP: can be installed manually if needed. For heavy GUI-based workflows, Codespaces is not a drop-in replacement for a full local pentesting VM.

**Heavy scans warning**
- masscan and wide port scans are noisy and resource-intensive. Consider running these from a dedicated remote VM or cloud instance (not Codespaces) and always respect program rules.