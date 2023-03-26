#Définition des variables
$dataFolderPath = "C:\Data"
$logFilePath = "C:\Logs\datamanagement.log"
$daysToKeep = 30

#Vérification de l'existence du dossier de données
if (-not (Test-Path -Path $dataFolderPath -PathType Container)) {
    Write-Error "Le dossier de données $dataFolderPath n'existe pas."
    exit
}

#Nettoyage des fichiers vieux de plus de X jours
Write-Host "Nettoyage des fichiers vieux de plus de $daysToKeep jours dans le dossier $dataFolderPath..."
$oldFiles = Get-ChildItem -Path $dataFolderPath -Recurse -File | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$daysToKeep) }
foreach ($file in $oldFiles) {
    Remove-Item -Path $file.FullName -Force
}

#Sauvegarde des données
Write-Host "Sauvegarde des données dans le dossier $dataFolderPath..."
$backupFileName = "data_backup_$(Get-Date -Format yyyy-MM-dd_HH-mm-ss).zip"
$backupFilePath = Join-Path -Path $dataFolderPath -ChildPath $backupFileName
Compress-Archive -Path $dataFolderPath\* -DestinationPath $backupFilePath -CompressionLevel Optimal -Verbose

#Enregistrement d'un journal
Write-Host "Enregistrement d'un journal dans le fichier $logFilePath..."
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$logEntry = "$timestamp : La sauvegarde des données a été effectuée avec succès."
Add-Content -Path $logFilePath -Value $logEntry
