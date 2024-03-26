param (
    [Parameter(Mandatory=$true)]
    [string]$pass
)

Write-Host "Enabling Windows developer mode..."
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

Write-Host "Installing MysteriumVPN..."
curl https://github.com/mysteriumnetwork/mysterium-vpn-release/releases/download/v1.5.5/MysteriumVPN.msix -OutFile ./MysteriumVPN.msix
Add-AppPackage -Path .\MysteriumVPN.msix
Write-Host "Try to login and start VPN while installing other packages"

Write-Host "Installing chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1

Write-Host "Installing git..."
choco install git.install -y --force
refreshenv

Write-Host "Installing python..."
choco install python312 --pre -y
refreshenv

Write-Host "Installing tesseract..."
choco install tesseract -y
refreshenv

Write-Host "Installing 7z..."
choco install 7zip.install -y --force
refreshenv

git clone https://github.com/Minh-s-org/setup-vps.git
cp ".\setup-vps\Mysterium VPN.lnk" ~\Desktop
cp ".\setup-vps\ssh.zip" ~\
7z e -p"$pass" "ssh.zip" -o".\.ssh"

Write-Host "Installing SSH..."
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Set-Service ssh-agent -StartupType Manual
Start-Service ssh-agent
Set-Service ssh-agent -StartupType Automatic
ssh-add .\.ssh\.id_rsa

Set-Location .\Desktop
git clone git@github.com:Minh-s-org/mysterium-tool.git

Set-Location .\mysterium-tool
pip install -r requirements.txt

Write-Host "VPS already"
