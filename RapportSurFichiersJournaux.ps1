$cheminJournal = "C:\Logs"
$cheminRapport = "C:\Reports"
$date = Get-Date -Format "yyyyMMdd"

# Créer le fichier de rapport
$fichierRapport = Join-Path -Path $cheminRapport -ChildPath "RapportJournal_$date.txt"
New-Item -Path $fichierRapport -ItemType "file" -Force | Out-Null

# Obtenir tous les fichiers journaux dans le chemin du journal
$fichiersJournal = Get-ChildItem -Path $cheminJournal -Filter "*.log" -Recurse

# Parcourir chaque fichier journal
foreach ($fichierJournal in $fichiersJournal) {
    Write-Host "Analyse du fichier journal $($fichierJournal.FullName)..." -ForegroundColor Yellow

    # Obtenir le contenu du fichier journal
    $contenuJournal = Get-Content $fichierJournal.FullName

    # Générer le rapport pour le fichier journal
    $rapport = "Rapport pour $($fichierJournal.Name)`n`n"

    # Compter le nombre de lignes dans le fichier journal
    $nbLignes = $contenuJournal.Count
    $rapport += "Nombre total de lignes : $nbLignes`n"

    # Compter le nombre d'erreurs et d'avertissements dans le fichier journal
    $erreurs = $contenuJournal | Select-String -Pattern "erreur" -IgnoreCase | Measure-Object | Select-Object -ExpandProperty Count
    $rapport += "Nombre d'erreurs : $erreurs`n"
    
    $avertissements = $contenuJournal | Select-String -Pattern "avertissement" -IgnoreCase | Measure-Object | Select-Object -ExpandProperty Count
    $rapport += "Nombre d'avertissements : $avertissements`n"

    # Trouver la ligne avec la plus grande quantité d'informations
    $ligneMax = $contenuJournal | Measure-Object -Property Length -Maximum | Select-Object -ExpandProperty Maximum
    $ligneMax = $contenuJournal | Where-Object { $_.Length -eq $ligneMax }

    # Ajouter la ligne avec la plus grande quantité d'informations au rapport
    $rapport += "Ligne avec la plus grande quantité d'informations : $ligneMax`n"

    # Écrire le rapport dans le fichier de rapport
    Add-Content -Path $fichierRapport -Value $rapport
}

Write-Host "Analyse terminée. Les rapports ont été générés dans $cheminRapport." -ForegroundColor Green
