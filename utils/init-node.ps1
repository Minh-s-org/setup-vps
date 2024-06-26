$BASE_PATH="$env:USERPROFILE"

Set-Location $BASE_PATH

Write-Host "Removing old node on VPS"
Remove-Item -Path $BASE_PATH\.mysterium-node,$BASE_PATH\.myst_node_launcher,$BASE_PATH\.mysterium-bin -Force -Recurse -ErrorAction SilentlyContinue

Write-Host "Starting Myst Launcher on VPS"
Start-Process -FilePath "C:\Program Files\Mysterium Launcher\myst-launcher-amd64.exe"