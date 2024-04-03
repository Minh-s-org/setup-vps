Write-Host "Enter new password for VPS"
$password=Read-Host -AsSecureString
Set-LocalUser -Name $Env:UserName -Password $password