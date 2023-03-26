#Ce script effectue les tâches de maintenance système suivantes :
#Défragmentation des disques
#Nettoyage des fichiers temporaires
#Nettoyage du registre
#Nettoyage des journaux d'événements
#Vérification de l'intégrité du système de fichiers
#Redémarrage du système.


#Défragmentation des disques
Write-Host "Défragmentation des disques en cours..."
Get-Volume | Optimize-Volume -Defrag -Verbose

#Nettoyage des fichiers temporaires
Write-Host "Nettoyage des fichiers temporaires en cours..."
Remove-Item -Path "$env:TEMP\*" -Recurse -Force
Remove-Item -Path "$env:systemroot\temp\*" -Recurse -Force
Remove-Item -Path "$env:userprofile\AppData\Local\Temp\*" -Recurse -Force

#Nettoyage du registre
Write-Host "Nettoyage du registre en cours..."
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" -Recurse -Force
Remove-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths" -Recurse -Force
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\*" -Recurse -Force

#Nettoyage des journaux d'événements
Write-Host "Nettoyage des journaux d'événements en cours..."
wevtutil.exe cl Application
wevtutil.exe cl System

#Vérification de l'intégrité du système de fichiers
Write-Host "Vérification de l'intégrité du système de fichiers en cours..."
sfc.exe /scannow

#Redémarrage du système
Write-Host "Redémarrage du système en cours..."
Restart-Computer -Force
