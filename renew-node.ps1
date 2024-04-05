param (
    [Parameter(Mandatory=$true)]
    [string]$user,
    [Parameter(Mandatory=$true)]
    [string]$vpsIp,
    [Parameter(Mandatory=$true)]
    [string]$pass
)

$BASE_PATH="C:\\Users\\$user"

$secpasswd = ConvertTo-SecureString $pass -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($user, $secpasswd)

Write-Host "Packaging node on VPS"
$session = New-SSHSession -ComputerName $vpsIp -Credential $credential -AcceptKey
$sessionId = $session.SessionId 
Invoke-SSHCommand -Command "powershell -ExecutionPolicy Bypass -File $BASE_PATH\\setup-vps\\utils\\package-node.ps1" -SessionId $sessionId
Remove-SSHSession -Session $sessionId

Write-Host "Copying VPS node to local"
Remove-Item "$env:USERPROFILE\node.zip" -Force
Get-SCPItem -ComputerName $vpsIp -Credential $credential -Path "C:\Users\$user\node.zip" -PathType File -Destination ./

Write-Host "Stoping Myst Launcher"
Stop-Process -Name *myst* -Force

Write-Host "Removing old node"
Remove-Item -Path $env:USERPROFILE\.mysterium-node,$env:USERPROFILE\.myst_node_launcher,$env:USERPROFILE\.mysterium-bin -Force -Recurse

Write-Host "Extract new node"
Expand-Archive -Path node.zip -DestinationPath $env:USERPROFILE

Write-Host "Starting Myst Launcher"
Start-Process -FilePath "C:\Program Files\Mysterium Launcher\myst-launcher-amd64.exe"

Write-Host "Init new node on VPS"
$session = New-SSHSession -ComputerName $vpsIp -Credential $credential -AcceptKey
$sessionId = $session.SessionId 
Invoke-SSHCommand -Command "powershell -ExecutionPolicy Bypass -File $BASE_PATH\\setup-vps\\utils\\init-node.ps1" -SessionId $sessionId
Remove-SSHSession -Session $sessionId

Write-Host "Done"
$hostname="$vpsIp"
Write-Host "Config new node on VPS at: http://$hostname :4449"