$PATH="$env:USERPROFILE"
$ZIP_PATH="$PATH\node.zip"

Stop-Process -Name *myst* -Force

Remove-Item $ZIP_PATH -Force -ErrorAction SilentlyContinue

Compress-Archive -Path $PATH\.mysterium-bin,$PATH\.mysterium-node,$PATH\.myst_node_launcher -DestinationPath $ZIP_PATH

Write-Host "Packged node at $ZIP_PATH"

