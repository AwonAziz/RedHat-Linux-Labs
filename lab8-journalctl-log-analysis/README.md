In this lab, I explored structured log analysis using `journalctl`, the primary log management utility for systemd-based Linux systems.

Rather than simply viewing logs, the focus was on filtering, isolating, and interpreting relevant events using time constraints, service units, priority levels, and boot sessions.

Log analysis is a core skill in system administration, DevOps, and incident response workflows.

---

## Environment

- Linux distribution with systemd (RHEL / CentOS / Fedora / Ubuntu)
- systemd-journald active
- Sudo privileges available

---

# 1️ Querying Logs by Time and Service

## Viewing Complete System Logs

```bash
journalctl
```

This displays a paginated history of all system journal entries.

If logs appear empty:

```bash
sudo systemctl status systemd-journald
```

---

## Filtering Logs by Time

View logs from the last hour:

```bash
journalctl --since "1 hour ago"
```

View logs within a specific time window:

```bash
journalctl --since "09:00:00" --until "10:00:00"
```

Time filters accept both relative and absolute timestamps.

---

## Filtering by Service (Unit)

Example: SSH daemon logs

```bash
journalctl -u sshd
```

Combine service and time filtering:

```bash
journalctl -u sshd --since "today"
```

This isolates logs generated specifically by the sshd systemd unit.

---

# 2️ Filtering by Severity and Boot Session

## Filtering by Priority Level

Display only error-level messages:

```bash
journalctl -p err
```

Display warnings and higher severity:

```bash
journalctl -p warning..emerg
```

Priority hierarchy:
- emerg (0)
- alert (1)
- crit (2)
- err (3)
- warning (4)
- notice (5)
- info (6)
- debug (7)

---

## Viewing Logs by Boot Session

List all recorded boots:

```bash
journalctl --list-boots
```

View logs from current boot:

```bash
journalctl -b
```

View logs from previous boot:

```bash
journalctl -b -1
```

Boot filtering is especially useful for diagnosing startup issues.

---

# 3️ Advanced Log Analysis Techniques

## Real-Time Log Monitoring

```bash
journalctl -f
```

Similar to `tail -f`, this streams new log entries live.

---

## Export Logs in JSON Format

```bash
journalctl -u sshd --since "1 hour ago" -o json
```

This structured output format allows integration with parsing tools like `jq` or log pipelines.

---

## Managing Journal Disk Usage

Check journal storage consumption:

```bash
journalctl --disk-usage
```

Limit log retention size:

```bash
sudo journalctl --vacuum-size=100M
```

This prevents uncontrolled disk usage from system logs.

---

# Key Technical Takeaways

- Structured log querying using time-based filters
- Service-level log isolation
- Severity-based event filtering
- Boot session diagnostics
- Real-time log streaming
- JSON export for automation and scripting
- Log retention management

---

# Professional Reflection

Understanding `journalctl` enables efficient troubleshooting, incident investigation, and system health monitoring.

Effective log analysis reduces mean time to resolution (MTTR) and is foundational for both DevOps engineers and site reliability teams.
