echo "===== DISPLAY ALL LOGS ====="
journalctl


echo "===== CHECK JOURNAL SERVICE STATUS ====="
sudo systemctl status systemd-journald


echo "===== FILTER LOGS (LAST HOUR) ====="
journalctl --since "1 hour ago"


echo "===== FILTER LOGS BETWEEN SPECIFIC TIMES ====="
journalctl --since "09:00:00" --until "10:00:00"


echo "===== FILTER LOGS BY SERVICE (sshd) ====="
journalctl -u sshd


echo "===== FILTER LOGS BY SERVICE AND TIME ====="
journalctl -u sshd --since "today"


echo "===== FILTER LOGS BY ERROR PRIORITY ====="
journalctl -p err


echo "===== FILTER LOGS (WARNING AND HIGHER) ====="
journalctl -p warning..emerg


echo "===== LIST BOOT SESSIONS ====="
journalctl --list-boots


echo "===== CURRENT BOOT LOGS ====="
journalctl -b


echo "===== PREVIOUS BOOT LOGS ====="
journalctl -b -1


echo "===== REAL-TIME LOG MONITORING ====="
journalctl -f


echo "===== EXPORT LOGS IN JSON FORMAT ====="
journalctl -u sshd --since "1 hour ago" -o json


echo "===== CHECK JOURNAL DISK USAGE ====="
journalctl --disk-usage


echo "===== VACUUM LOGS TO 100MB ====="
sudo journalctl --vacuum-size=100M

