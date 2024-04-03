param (
    [Parameter(Mandatory=$true)]
    [string]$pass
)

Write-Host "Enabling Windows developer mode..."
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

Write-Host "Installing chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1

Write-Host "Installing git..."
choco install git.install -y --force
refreshenv

Write-Host "Installing 7z..."
choco install 7zip.install -y --force
refreshenv

git clone https://github.com/Minh-s-org/setup-vps.git

Write-Host "Preparing VPS..."
Set-Location .\setup-vps
.\utils\setup-ssh-server.ps1

.\utils\setup-vps-pass.ps1

Write-Host "Installing Myst Launcher-x64..."
Set-Location ~
curl https://github.com/mysteriumnetwork/myst-launcher/releases/latest/download/myst-launcher-x64.msi  -OutFile ./myst-launcher-x64.msi
Start-Process msiexec.exe -Wait -ArgumentList "/I $env:USERPROFILE\myst-launcher-x64.msi"

Write-Host "Node raiser already. Onboarding now at http://localhost:4449"
