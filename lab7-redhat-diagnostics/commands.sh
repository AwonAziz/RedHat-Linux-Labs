echo "===== TASK 1: INSTALL SOSREPORT ====="

sudo dnf install sos -y

echo "If dependency issues occur, running cache cleanup..."
sudo dnf clean all
sudo dnf makecache


echo "===== GENERATING SOS REPORT ====="

sudo sosreport --batch --name=$(hostname)

echo "Diagnostic archive generated in /var/tmp"


echo "===== TASK 2: INSTALL INSIGHTS CLIENT ====="

sudo dnf install insights-client -y


echo "===== REGISTER SYSTEM TO RED HAT INSIGHTS ====="

sudo insights-client --register


echo "===== PERFORM INITIAL DATA UPLOAD ====="

sudo insights-client


echo "===== VERIFY SUBSCRIPTION STATUS ====="

sudo subscription-manager status


echo "===== TEST CONNECTION TO RED HAT INSIGHTS ====="

sudo insights-client --test-connection


echo "===== SCHEDULE DAILY AUTOMATED UPLOAD ====="

echo "0 0 * * * root /usr/bin/insights-client" | sudo tee /etc/cron.d/insights
