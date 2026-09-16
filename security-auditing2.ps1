# ---------------------------------------------------------
# Local System Security & Compliance Audit Script
# Target: Windows Systems
# ---------------------------------------------------------

# Setting log output location
$logFile = "$PSScriptRoot\SecurityAuditReport.txt"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Fetch system configurations
$firewallProfiles = Get-NetFirewallProfile | Select-Object Name, Enabled
$activeUsers      = Get-LocalUser | Where-Object { $_.Enabled -eq $true } | Select-Object Name, Enabled, LastLogon
$antivirusStatus  = Get-MpComputerStatus | Select-Object RealTimeProtectionEnabled, AntivirusSignatureAge

# Monitoring high-risk ports
$monitoredPorts = @(3389, 5985, 5986, 21, 23, 445)
$openTCPConnections = Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue

# Printing Report Header
$reportContent = @"
==================================================
        LOCAL SECURITY AUDIT REPORT
        Timestamp: $timestamp
==================================================

"@

# [SECTION 1] Firewall Verification
$reportContent += "`n[1. FIREWALL STATUS]`n"
foreach ($profile in $firewallProfiles) {
    if ($profile.Enabled -eq $true) {
        $reportContent += " [OK] Profile '$($profile.Name)': Enabled`n"
    } else {
        $reportContent += " [CRITICAL ALERT] Profile '$($profile.Name)': DISABLED!`n"
    }
}

# [SECTION 2] Antivirus Health Check
$reportContent += "`n[2. ANTIVIRUS STATUS]`n"
if ($antivirusStatus.RealTimeProtectionEnabled -eq $true) {
    $reportContent += "`n[OK] Real-time protection is ACTIVE.`n"
} else {
    $reportContent += "`n[CRITICAL ALERT] Real-time protection is DISABLED.`n"
}

if ($antivirusStatus.AntivirusSignatureAge -le 2) {
    $reportContent += "`n[OK] Virus definitions are up to date ($($antivirusStatus.AntivirusSignatureAge) days old)`n"
} else {
    $reportContent += "`n[WARNING] Virus definitions are out of date ($($antivirusStatus.AntivirusSignatureAge) days old)!`n"
}

# [SECTION 3] Active Local Accounts
$reportContent += "`n[3. ACTIVE LOCAL ACCOUNTS]`n"
foreach ($user in $activeUsers) {
    $reportContent += " - Account: $($user.Name) | Last Logon: $($user.LastLogon)`n"
}

# [SECTION 4] Exposed Sensitive Network Ports
$reportContent += "`n[4. NETWORK PORT EXPOSURE AUDIT]`n"
foreach ($port in $monitoredPorts) {
    $isListening = $openTCPConnections | Where-Object { $_.LocalPort -eq $port }
    if ($isListening) {
        $reportContent += "[WARNING] Sensitive Port $port is open and listening!`n"
    } else {
        $reportContent += "[OK] Port $port is closed and not listening.`n"
    }
}

#Display Report on Screen and save to file .txt
Write-Host $reportContent -ForegroundColor Cyan
$reportContent | Out-File -FilePath $logFile -Encoding utf8

Write-Host "`n Report successfully saved to: $logFile`n" -ForegroundColor Green