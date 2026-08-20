# Windows Local Security Audit & Compliance Tool

A lightweight, native PowerShell script designed to automate basic security posture and compliance checks on Windows endpoints. Built to streamline IT Support workflows, accelerate endpoint auditing, and identify system vulnerabilities without third-party dependencies.

## Key Features

* **Firewall Compliance Check:** Evaluates domain, private, and public profile statuses to catch unauthorized exposure.
* **Antivirus Health Verification:** Confirms Windows Defender real-time protection state and flags outdated signature definitions.
* **Account Exposure Audit:** Enumerates active local accounts and last logon timestamps to highlight potential stale or unauthorized access.
* **Automated Incident Logging:** Generates clean, timestamped text reports for audit trails and ticketing support.

## Output Example

```text
==================================================
        LOCAL SECURITY AUDIT REPORT
        Timestamp: 2026-08-20 14:30:00
==================================================

[1. FIREWALL STATUS]
 [OK] Profile 'Domain': Enabled
 [OK] Profile 'Private': Enabled
 [OK] Profile 'Public': Enabled

[2. ANTIVIRUS STATUS]
 [OK] Real-time protection is ACTIVE.
 [OK] Virus definitions are up to date (0 days old).

[3. ACTIVE LOCAL ACCOUNTS]
 - Account: Administrator | Last Logon: 2026-08-15 09:12:33
 - Account: LocalAdmin | Last Logon: 2026-08-20 11:04:12
