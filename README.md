# 🖱️ Classic Right-Click Context Menu for Windows 11
**Brought to you by [Clansoft](https://dadoftheclan.com)**

> Restores the beloved Windows 10-style context menu in Windows 11  
> No bloat. No nonsense. Just right-click the way it used to be.

---

## 🚀 Features

- Brings back the **classic context menu** in Windows 11
- Safe, clean, and **reversible**
- Applies instantly with **no reboot required**
- Fully open-source, under **The Unlicense**

---

## 📸 Screenshot

> Windows 11 Default  
![Modern Context Menu](screenshots/windows11-modern-context-menu.png)

> With Clansoft Classic Fix Applied  
![Classic Context Menu](screenshots/windows10-classic-context-menu.png)

---

## 🛠️ How to Use

### 🔹 Option 1: Run the Script Manually

1. Open **PowerShell as Administrator**
2. Paste and run the contents of [`Context.ps1`](Context.ps1)

### 🔹 Option 2: Download & Execute

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/dadoftheclan/ContextReplacer/main/Context.ps1" -OutFile "Context.ps1"
Start-Process powershell -Verb runAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PWD\Context.ps1`""
