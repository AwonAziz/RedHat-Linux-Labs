In this lab we demonstrate how to:

- Collect comprehensive system diagnostics using `sosreport`
- Install and register `insights-client`
- Analyze system health and recommendations via the Red Hat Insights portal
- Enable proactive system monitoring and remediation

---

## Environment

- OS: Red Hat Enterprise Linux 8/9
- Root Access: Required
- Active Red Hat Subscription
- Internet Connectivity

---

# Task 1: Install and Run sosreport

## Install sos Package

```bash
sudo dnf install sos -y
```

If dependency issues occur:

```bash
sudo dnf clean all
sudo dnf makecache
```

## Generate Diagnostic Report

```bash
sudo sosreport --batch --name=$(hostname)
```

### Key Concepts

- `--batch` → Runs non-interactively
- `--name` → Tags the report using the hostname

### Expected Outcome

A compressed `.tar.xz` diagnostic file is generated in:

```
/var/tmp/
```

This archive contains system configuration, logs, and diagnostic metadata.

---

# Task 2: Install and Register insights-client

## Install Client

```bash
sudo dnf install insights-client -y
```

## Register System with Red Hat Insights

```bash
sudo insights-client --register
```

Expected message:

```
Successfully registered host to Red Hat Insights
```

### Troubleshooting

Check subscription status:

```bash
sudo subscription-manager status
```

Ensure connectivity to:

```
https://cloud.redhat.com
```

## Perform Initial Upload

```bash
sudo insights-client
```

This uploads system data securely to the Red Hat Insights portal for analysis.

---

# Task 3: Analyze via Red Hat Insights Portal

## Access Portal

Navigate to:

https://cloud.redhat.com/insights

Log in using your Red Hat account.

## Review System Insights

Under the **Systems** tab, examine:

- Advisories → Recommended patches and updates
- Subscriptions → Compliance and entitlement status
- Performance → Resource utilization and health trends
- Risk Detection → Security and stability risks
- Remediation Guidance → Automated fix recommendations

---

# Automation: Schedule Daily Upload

Enable automatic data collection via cron:

```bash
echo "0 0 * * * root /usr/bin/insights-client" | sudo tee /etc/cron.d/insights
```

This schedules daily uploads at midnight.

---

# Verification

Confirm connectivity:

```bash
sudo insights-client --test-connection
```

Expected output:

```
Successfully connected to Red Hat Insights
```

---

# Key Learnings

- Enterprise-grade diagnostic collection using sosreport
- Subscription-aware system management
- Cloud-integrated monitoring with Red Hat Insights
- Proactive risk identification and remediation workflows
