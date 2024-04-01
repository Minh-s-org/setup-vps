$BASE_PATH="C:\Users\Administrator"

Set-Location $BASE_PATH

Write-Host "Removing old node on VPS"
Remove-Item -Path .\.mysterium-node,.\.myst_node_launcher,.\.mysterium-bin -Force -Recurse -ErrorAction SilentlyContinue

Write-Host "Starting Myst Launcher on VPS"
Start-Process -FilePath "C:\Program Files\Mysterium Launcher\myst-launcher-amd64.exe"