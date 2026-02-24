This lab focused on installing, configuring, and securing the OpenSSH server on a Linux system. The objective was to enhance remote access security by modifying SSH configuration settings, implementing key-based authentication, and restricting access via firewall rules.

This lab reflects foundational Linux hardening practices used in production environments.

Here i learned to:
- Install and manage the OpenSSH server
- Harden SSH configuration using sshd_config
- Disable insecure authentication mechanisms
- Implement key-based authentication
- Restrict SSH access via firewall rules
- Troubleshoot SSH service issues

Environment

- Linux system (Ubuntu / CentOS / RHEL)
- sudo privileges
- OpenSSH Server
- UFW or firewalld

Task 1 – Install and Verify OpenSSH Server

## Check Existing SSH Installation

bash:
ssh -V

If not installed:

Debian/Ubuntu:
sudo apt update && sudo apt install openssh-server -y

RHEL/CentOS:
sudo dnf install openssh-server -y

Verify SSH Service Status:
sudo systemctl status ssh

If inactive:
sudo systemctl start ssh

Task 2 – Harden SSH Configuration

Backup Configuration File:
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

Secure Configuration Changes:
Edit:
sudo nano /etc/ssh/sshd_config

Recommended security changes:
Port 2222
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
AllowUsers your_username

//Security Improvements Explained:
Changing default port reduces automated scanning exposure.
Disabling root login prevents direct privileged access.
Disabling password authentication mitigates brute-force attacks.
Enforcing key-based authentication increases security.
Restricting allowed users reduces attack surface.

Restart SSH Service:
sudo systemctl restart ssh

Verify listening port:
ss -tulnp | grep ssh

Expected:
tcp LISTEN 0 128 0.0.0.0:2222 ...

If issues occur:
sudo journalctl -xe

#Task 3 – Configure Key-Based Authentication:
Generate SSH Key Pair (Client Side):
ssh-keygen -t ed25519 -C "your_email@example.com"

Default path:
~/.ssh/id_ed25519

Copy Public Key to Server:
ssh-copy-id -p 2222 username@server_ip

Test Secure Login:
ssh -p 2222 username@server_ip

#Task 4 – Configure Firewall Rules:
Ubuntu (UFW):
sudo ufw allow 2222/tcp
sudo ufw enable
sudo ufw status

RHEL/CentOS (firewalld):
sudo firewall-cmd --permanent --add-port=2222/tcp
sudo firewall-cmd --reload
sudo firewall-cmd --list-ports

Expected output:
2222/tcp

//In real-world DevOps and AI Ops environments:
SSH access is restricted via bastion hosts
Password authentication is always disabled
Multi-factor authentication (MFA) may be enforced
Logs are monitored for suspicious login attempts
Access is managed using centralized identity systems

Cleanup / Rollback (If Needed)

Restore original configuration:
sudo cp /etc/ssh/sshd_config.bak /etc/ssh/sshd_config
sudo systemctl restart ssh
