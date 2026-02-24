echo "===== TASK 1: CPU MONITORING ====="

# Real-time CPU monitoring
top

# Install sysstat if needed
sudo dnf install sysstat -y

# CPU usage per core (1 second interval, 5 times)
mpstat -P ALL 1 5



echo "===== TASK 2: MEMORY MONITORING ====="

# Display RAM and swap usage
free -h

# Sort processes by memory usage
top -o %MEM



echo "===== TASK 3: DISK MONITORING ====="

# Check disk space usage
df -h

# Check directory size usage
du -sh /var/log/*

# Install iotop (if needed)
sudo dnf install iotop -y

# Monitor disk I/O (requires root)
sudo iotop -o



echo "===== TASK 4: NETWORK MONITORING ====="

# Show active TCP/UDP connections
ss -tulnp

# Install nload if needed
sudo dnf install nload -y

# Monitor real-time network traffic
nload



echo "===== TASK 5: PROCESS ANALYSIS ====="

# Top 5 CPU-consuming processes
ps aux --sort=-%cpu | head -n 5

# Top 5 memory-consuming processes
ps aux --sort=-%mem | head -n 5

# Monitor container stats (Podman)
podman stats



echo "===== TASK 6: RESOURCE EXHAUSTION CHECK ====="

# View error logs since last boot
journalctl -p err -b

# Install stress-ng if needed
sudo dnf install stress-ng -y

# Simulate high CPU and memory load
stress-ng --cpu 4 --vm 2 --timeout 30s


echo "===== LAB COMPLETED ====="
