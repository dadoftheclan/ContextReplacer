<#
      ██████╗██╗      █████╗ ███╗   ██╗███████╗ ██████╗ ███████╗████████╗
     ██╔════╝██║      ██╔══██╗████╗  ██║██╔════╝██╔═══██╗██╔════╝╚══██╔══╝
     ██║     ██║      ███████║██╔██╗ ██║█████╗  ██║   ██║███████╗   ██║   
     ██║     ██║      ██╔══██║██║╚██╗██║██╔══╝  ██║   ██║╚════██║   ██║   
     ╚██████╗███████╗██║  ██║██║ ╚████║███████╗╚██████╔╝███████║   ██║   
      ╚═════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚══════╝   ╚═╝   

     Script Name : EnableClassicContextMenu.ps1
     Author      : Clansoft (https://dadoftheclan.com)
     Purpose     : Restores the classic Windows 10-style right-click context menu in Windows 11.
     License     : The Unlicense
#>

# Ensure script runs as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "This script must be run as Administrator!"
    exit 1
}

Write-Host "`n[+] Enabling Classic Right-Click Menu (Windows 10 style)..." -ForegroundColor Cyan

# Define the registry path
$regPath = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"

# === ERROR HANDLING LOGIC REPLACED ===
# This section creates the registry keys and checks for errors without using a try/catch block.

# Clear any previous error variable
$CmdError = $null

# Execute the commands and store any potential errors in the $CmdError variable.
New-Item -Path $regPath -Force -ErrorAction SilentlyContinue -ErrorVariable CmdError | Out-Null
Set-ItemProperty -Path $regPath -Name '(default)' -Value '' -Force -ErrorAction SilentlyContinue -ErrorVariable +CmdError

# Check if the $CmdError variable was populated.
if ($CmdError) {
    # If an error occurred, print it and exit.
    Write-Host "[✘] Registry modification failed: $($CmdError[0].Exception.Message)" -ForegroundColor Red
    exit 1
} else {
    # If no error occurred, print success.
    Write-Host "[✔] Registry key applied successfully." -ForegroundColor Green
}

# Restart Explorer
Write-Host "[~] Restarting Windows Explorer to apply changes..." -ForegroundColor Yellow
Stop-Process -Name explorer -Force
Start-Sleep -Seconds 2
Start-Process explorer

Write-Host "[✓] Classic context menu is now active!" -ForegroundColor Green
Write-Host "Brought to you by Clansoft - https://dadoftheclan.com" -ForegroundColor Magenta
