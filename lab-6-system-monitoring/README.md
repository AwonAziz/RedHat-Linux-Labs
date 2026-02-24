This lab demonstrates how to monitor and analyze system resource usage including CPU, memory, disk, and network performance using open-source Linux tools.

 Linux Distribution: RHEL / CentOS / Fedora
- Container Runtime: Podman
- Tools Used:
  - top
  - mpstat
  - free
  - df
  - du
  - iotop
  - ss
  - nload
  - ps
  - podman stats
  - journalctl
  - stress-ng

 ## Task 1: Monitor CPU Usage

Real-Time CPU Monitoring

bash:
top

-Observed %CPU column

-Identified high CPU-consuming processes

CPU Snapshot Per Core:
sudo dnf install sysstat -y
mpstat -P ALL 1 5

## Task 2: Monitor Memory Usage
  
Check RAM and Swap:
free -h

-Analyzed total, used, and available memory

Identify Memory-Heavy Processes:
top -o %MEM

-Sorted processes by memory usage

## Task 3: Monitor Disk Usage

Check Filesystem Space:
df -h

-Reviewed mounted filesystems

Analyze Directory Sizes:
du -sh /var/log/*

-Checked log directory usage

Monitor Disk I/O:
sudo dnf install iotop -y
sudo iotop -o

-Monitored active disk I/O processes

## Task 4: Monitor Network Usage

Active Network Connections:
ss -tulnp

-Listed active TCP/UDP ports

Real-Time Bandwidth Monitoring:
sudo dnf install nload -y
nload

-Observed incoming/outgoing traffic

## Task 5: Analyze Process Resource Impact

Top CPU Processes:
ps aux --sort=-%cpu | head -n 5

Top Memory Processes:
ps aux --sort=-%mem | head -n 5

Container Resource Monitoring (Podman):
podman stats

-Observed container-level CPU, memory, and network usage

## Task 6: Detect Resource Exhaustion

Check System Errors:
journalctl -p err -b

-Reviewed system error logs

Simulate High Load:
sudo dnf install stress-ng -y
stress-ng --cpu 4 --vm 2 --timeout 30s

-Monitored system behavior under stress
-Observed impact using top

//Important Takeaways:
Real-time and snapshot-based CPU monitoring
Memory and swap usage analysis
Disk space and I/O monitoring
Network connection and traffic inspection
Process-level resource impact analysis
Resource exhaustion detection and simulation
