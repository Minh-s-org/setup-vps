param (
    [Parameter(Mandatory=$true)]
    [string]$user,
    [Parameter(Mandatory=$true)]
    [string]$vpsIp
)

$SSH_INFO="$user@$vpsIp"
$BASE_PATH="C:\\Users\\$user"

Write-Host "Packaging node on VPS"
ssh $SSH_INFO "powershell -ExecutionPolicy Bypass -File $BASE_PATH\\setup-vps\\utils\\package-node.ps1"

Write-Host "Copying VPS node to local"
scp ${SSH_INFO}:$BASE_PATH\node.zip . 

Write-Host "Stoping Myst Launcher"
Stop-Process -Name *myst* -Force

Write-Host "Removing old node"
Remove-Item -Path $env:USERPROFILE\.mysterium-node,$env:USERPROFILE\.myst_node_launcher,$env:USERPROFILE\.mysterium-bin -Force -Recurse

Write-Host "Extract new node"
Expand-Archive -Path node.zip -DestinationPath $env:USERPROFILE

Write-Host "Starting Myst Launcher"
Start-Process -FilePath "C:\Program Files\Mysterium Launcher\myst-launcher-amd64.exe"

Write-Host "Init new node on VPS"
ssh $SSH_INFO "powershell -ExecutionPolicy Bypass -File $BASE_PATH\\setup-vps\\utils\\init-node.ps1"

Write-Host "Done"
$hostname="$vpsIp"
Write-Host "Config new node on VPS at: http://$hostname\:4449"