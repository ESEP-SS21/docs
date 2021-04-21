Param(
    [switch]$p
)

$homeDir = Split-Path -Path $PSScriptRoot -Parent
$outDir = "$homeDir/out"
$diaDir = "$homeDir/out/diagrams"

Write-Output "Clearing $diaDir"
Remove-Item "$diaDir/*" -Recurse -Force
Copy-Item $PSScriptRoot $outDir -Force -Recurse
Set-Location $diaDir

Remove-Item "$diaDir/compile.*"
Write-Output " - - - Compiling .uxf files in '$homeDir' - - - "
$fileNames = Get-ChildItem -Path $diaDir -Recurse -Include *.uxf -Name
foreach ($file in $fileNames)
{
    Write-Output "converting '$file' to PDF, saving to '$diaDir"
    if ($p)
    {
        Start-Process -FilePath "Umlet.exe" -ArgumentList "-action=convert -format=pdf -filename=$file"
    }
    else
    {
        Start-Process -FilePath "Umlet.exe" -ArgumentList "-action=convert -format=pdf -filename=$file" -Wait
        Remove-Item $file
    }
}
