# Windows Local Security Audit & Compliance Tool (v2.0)

A lightweight, native PowerShell tool designed to automate endpoint security baseline auditing on Windows systems. Built to accelerate IT Support troubleshooting, enforce compliance, and highlight potential exposures without requiring third-party agents.

## Key Features

* **Firewall Compliance Check:** Verifies status across Domain, Private, and Public network profiles.
* **Antivirus Health Check:** Validates Microsoft Defender real-time protection state and signature freshness.
* **Account Exposure Audit:** Identifies active local accounts and captures last logon timestamps.
* **Network Port Exposure Audit:** Scans for listening high-risk ports (RDP, WinRM, SMB, FTP, Telnet).
* **Automated Audit Logging:** Exports clear, timestamped reports formatted for incident handling and documentation.

## Sample Output

See the full example in [`samples/SecurityAuditReport_Sample.txt`](./samples/SecurityAuditReport_Sample.txt).

```text
==================================================
        LOCAL SECURITY AUDIT REPORT v2.0
        Timestamp: 2026-10-01 14:30:00
==================================================

[1. FIREWALL STATUS]
 [OK] Profile 'Domain': Enabled
 [CRITICAL ALERT] Profile 'Private': DISABLED!
 [OK] Profile 'Public': Enabled

[2. ANTIVIRUS STATUS]
 [OK] Real-time protection is ACTIVE.
 [OK] Virus definitions are up to date (0 days old).

[3. ACTIVE LOCAL ACCOUNTS]
 - Account: Administrator | Last Logon: 2026-09-28 09:12:33
 - Account: LocalAdmin | Last Logon: 2026-10-01 11:04:12

[4. NETWORK PORT EXPOSURE AUDIT]
 [WARNING] Sensitive Port 3389 is OPEN and LISTENING!
 [OK] Port 5985 is closed/not listening.
 [OK] Port 445 is closed/not listening.
```
To use it, you can download or clone this repo, open Powershell and run the script:
.\SecurityAudit.ps1

## Value and Use Case
* IT Support Operations: Rapidly assess workstation hygiene during maintenance, onboarding, or offboarding.
* Junior Security Operations: Acts as a lightweight triage script for first-line endpoint incident response.
