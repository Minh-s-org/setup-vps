try {
    Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
} 
catch {
    curl https://zomro-static.s3.eu-central-1.amazonaws.com/uploads/posts/files/OpenSSH-Server-Package~31bf3856ad364e35~amd64~~.cab -OutFile OpenSSH-Server-Package~31bf3856ad364e35~amd64~~.cab

    cp OpenSSH-Server-Package~31bf3856ad364e35~amd64~~.cab C:\

    Dism /Online /Add-Package /PackagePath:"C:\OpenSSH-Server-Package~31bf3856ad364e35~amd64~~.cab"

    Remove-Item "C:\OpenSSH-Server-Package~31bf3856ad364e35~amd64~~.cab" -Force
}

New-NetFirewallRule -Protocol TCP -LocalPort 22 -Direction Inbound -Action Allow -DisplayName SSH

Start-Service -Name *sshd*

Set-Service -Name sshd -StartupType Automatic

New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force