Write-Host "Enabling Windows developer mode..."
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

Write-Host "Installing VPN client"
curl https://github.com/mysteriumnetwork/mysterium-vpn-release/releases/download/v1.5.5/MysteriumVPN.msix -OutFile ./MysteriumVPN.msix
Add-AppxPackage -Path ./MysteriumVPN.msix

Write-Host "Installing Python"
./setup/python-3.12.2-amd64.exe

Write-Host "Installing OCR"
./setup/tesseract-ocr-w64-setup-5.3.3.20231005.exe