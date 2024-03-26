Write-Host "Installing chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1

Write-Host "Installing git..."
choco install git.install -y

Write-Host "Installing python..."
choco install python312 --pre

Write-Host "Installing tesseract..."
choco install tesseract -y
refreshenv

Write-Host "Installing MysteriumVPN..."
curl https://github.com/mysteriumnetwork/mysterium-vpn-release/releases/download/v1.5.5/MysteriumVPN.msix -OutFile ./MysteriumVPN.msix
Add-AppPackage -Path ./MysteriumVPN.msix


Write-Host "VPS already. Please clone sourcecode & install requirements.txt"
