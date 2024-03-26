### chocolatey
Write-Host "Installing chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
Write-Host "Installed chocolatey"

Write-Host "Installing Git..."
choco install -y git
Write-Host "Installed Git..."

Start-Process powershell.exe -ArgumentList "-Command", "& 'git clone https://github.com/Minh-s-org/setup-vps.git' " -PassThru