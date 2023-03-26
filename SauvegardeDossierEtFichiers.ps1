# Spécifier les dossiers et fichiers à sauvegarder
$dossiers = @("C:\Dossier1", "C:\Dossier2")
$fichiers = @("C:\Fichier1.txt", "C:\Fichier2.txt")

# Spécifier le dossier de destination de la sauvegarde
$destination = "D:\Sauvegarde"

# Créer un nouveau dossier pour la sauvegarde
$date = Get-Date -Format "yyyyMMdd_HHmmss"
$dossierSauvegarde = Join-Path $destination "Sauvegarde_$date"
New-Item -ItemType Directory -Path $dossierSauvegarde

# Sauvegarder les dossiers
foreach ($dossier in $dossiers) {
    $nomDossier = Split-Path $dossier -Leaf
    $destinationDossier = Join-Path $dossierSauvegarde $nomDossier
    Copy-Item -Path $dossier -Destination $destinationDossier -Recurse
}

# Sauvegarder les fichiers
foreach ($fichier in $fichiers) {
    $nomFichier = Split-Path $fichier -Leaf
    $destinationFichier = Join-Path $dossierSauvegarde $nomFichier
    Copy-Item -Path $fichier -Destination $destinationFichier
}

# Afficher un message de confirmation
Write-Host "La sauvegarde a été effectuée avec succès dans le dossier $dossierSauvegarde." -ForegroundColor Green
