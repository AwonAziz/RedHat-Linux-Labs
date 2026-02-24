```bash
#!/bin/bash

# -----------------------------------------
# Lab 10 – Configuring and Securing SSH
# -----------------------------------------

# Verify SSH version
ssh -V

# Install OpenSSH (Ubuntu/Debian example)
sudo apt update
sudo apt install openssh-server -y

# Verify service status
sudo systemctl status ssh

# Backup configuration
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Example hardened configuration (manual edit required)
echo "Please edit /etc/ssh/sshd_config and apply security settings"

# Restart SSH service
sudo systemctl restart ssh

# Verify listening port
ss -tulnp | grep ssh

# -----------------------------------------
# Key-Based Authentication
# -----------------------------------------

ssh-keygen -t ed25519 -C "your_email@example.com"

# Replace username and server_ip accordingly
# ssh-copy-id -p 2222 username@server_ip

# Test login
# ssh -p 2222 username@server_ip

# -----------------------------------------
# Firewall Configuration (Ubuntu UFW example)
# -----------------------------------------

sudo ufw allow 2222/tcp
sudo ufw enable
sudo ufw status

# -----------------------------------------
# Rollback (if needed)
# -----------------------------------------

# sudo cp /etc/ssh/sshd_config.bak /etc/ssh/sshd_config
# sudo systemctl restart ssh
