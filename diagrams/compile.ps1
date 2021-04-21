Write-Output $PSScriptRoot
$homeDir = Split-Path -Path $PSScriptRoot -Parent
Copy-Item $PSScriptRoot $homeDir/out -Force -Recurse
Set-Location $homeDir/out/diagrams

Remove-Item "$(Get-Location)/compile.*"
Write-Output " - - - Compiling .uxf files in '$homeDir' - - - "
$fileNames = Get-ChildItem -Path $(Get-Location) -Recurse -Include *.uxf -Name
foreach ($file in $fileNames){

    Write-Output "converting '$file' to PDF"
    Start-Process -FilePath "Umlet.exe" -ArgumentList "-action=convert -format=pdf -filename=$file"
    Remove-Item $file
}
