<#
     ██████╗██╗      █████╗ ███╗   ██╗███████╗ ██████╗ ███████╗████████╗
    ██╔════╝██║     ██╔══██╗████╗  ██║██╔════╝██╔═══██╗██╔════╝╚══██╔══╝
    ██║     ██║     ███████║██╔██╗ ██║█████╗  ██║   ██║███████╗   ██║   
    ██║     ██║     ██╔══██║██║╚██╗██║██╔══╝  ██║   ██║╚════██║   ██║   
    ╚██████╗███████╗██║  ██║██║ ╚████║███████╗╚██████╔╝███████║   ██║   
     ╚═════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚══════╝   ╚═╝   

    Script Name : EnableClassicContextMenu.ps1
    Author      : Clansoft (https://dadoftheclan.com)
    Purpose     : Restores the classic Windows 10-style right-click context menu in Windows 11.
    Version     : 1.0
    Created     : 2025-06-22

    Requirements:
        - Administrator privileges
        - Windows 11
        - No reboot required (Explorer will be restarted)

    Reversible:
        - Yes. Use the provided revert script to restore default Windows 11 context menu.
#>

# Ensure script runs as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "This script must be run as Administrator!"
    Exit 1
}

Write-Host "`n[+] Enabling Classic Right-Click Menu (Windows 10 style)..." -ForegroundColor Cyan

# Define the registry path
$regPath = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"

# Apply the registry tweak
Try {
    New-Item -Path $regPath -Force -ErrorAction Stop | Out-Null
    Set-ItemProperty -Path $regPath -Name '(default)' -Value '' -Force
    Write-Host "[✔] Registry key applied successfully." -ForegroundColor Green
} Catch {
    Write-Host "[✘] Registry modification failed: $_" -ForegroundColor Red
    Exit 1
}

# Restart Explorer
Write-Host "[~] Restarting Windows Explorer to apply changes..." -ForegroundColor Yellow
Stop-Process -Name explorer -Force
Start-Sleep -Seconds 2
Start-Process explorer

Write-Host "[✓] Classic context menu is now active!" -ForegroundColor Green
Write-Host "`nBrought to you by Clansoft – https://dadoftheclan.com" -ForegroundColor Magenta
