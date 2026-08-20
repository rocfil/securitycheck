# storing data into variables
$firewall = Get-NetFirewallProfile | Select-Object Name, Enabled
$users = Get-LocalUser | Where-Object { $_.Enabled -eq $true } | Select-Object Name, Enabled, LastLogon
$antivirus = Get-MpComputerStatus | Select-Object RealTimeProtectionEnabled, AntivirusSignatureAge

# Header Display
Write-Host "===============================" -ForegroundColor Cyan
Write-Host "    SECURITY AUDITING REPORT   " -ForegroundColor Cyan
Write-Host "===============================" -ForegroundColor Cyan

# Results display
Write-Host "`n[1. FIREWALL STATUS]" -ForegroundColor Yellow
$firewall | Format-Table -AutoSize

Write-Host "[2.ACTIVE LOCAL USERS]" -ForegroundColor Yellow
$users | Format-Table -AutoSize

Write-Host "[3. DEFENDER STATUS]" -ForegroundColor Yellow
$antivirus | Format-Table -AutoSize