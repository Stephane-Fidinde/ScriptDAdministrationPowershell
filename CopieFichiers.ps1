#Copie des fichiers source vers la destination
#Archivage des fichiers copiés
#Suppression des fichiers source.



#Définition des variables
$sourcePath = "C:\Data\Source"
$destinationPath = "C:\Data\Destination"
$fileExtension = "*.txt"
$archivePath = "C:\Data\Archive"

#Copie des fichiers source vers la destination
Write-Host "Copie des fichiers source vers la destination..."
Get-ChildItem $sourcePath -Recurse -Include $fileExtension | Copy-Item -Destination $destinationPath -Force

#Archivage des fichiers copiés
Write-Host "Archivage des fichiers copiés..."
Get-ChildItem $destinationPath -Recurse -Include $fileExtension | ForEach-Object {
    $archiveFileName = $_.Name + "_" + (Get-Date).ToString("yyyyMMddHHmmss") + ".txt"
    $archiveFilePath = Join-Path $archivePath $archiveFileName
    Move-Item $_.FullName $archiveFilePath
}

#Suppression des fichiers source
Write-Host "Suppression des fichiers source..."
Get-ChildItem $sourcePath -Recurse -Include $fileExtension | Remove-Item -Force
