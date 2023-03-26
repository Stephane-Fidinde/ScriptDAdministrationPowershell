#Définition des variables
$auditLogPath = "C:\Audit\audit.log"
$usersToMonitor = "user1", "user2"
$dateFormat = "yyyy/MM/dd HH:mm:ss"

#Fonction pour écrire dans le fichier journal
function Write-Log([string]$message) {
    $logMessage = "{0} - {1}" -f (Get-Date -Format $dateFormat), $message
    Add-Content $auditLogPath -Value $logMessage
}

#Surveillance des événements de connexion des utilisateurs
Write-Host "Surveillance des événements de connexion des utilisateurs..."
Get-WinEvent -FilterHashtable @{
    LogName = "Security"
    Id = 4624
    StartTime = (Get-Date).AddHours(-1)
} | ForEach-Object {
    $user = $_.Properties[5].Value
    if ($usersToMonitor -contains $user) {
        $message = "{0} s'est connecté à {1} depuis {2}" -f $user, $_.Properties[1].Value, $_.Properties[18].Value
        Write-Log $message
    }
}

#Surveillance des événements de déconnexion des utilisateurs
Write-Host "Surveillance des événements de déconnexion des utilisateurs..."
Get-WinEvent -FilterHashtable @{
    LogName = "Security"
    Id = 4634
    StartTime = (Get-Date).AddHours(-1)
} | ForEach-Object {
    $user = $_.Properties[5].Value
    if ($usersToMonitor -contains $user) {
        $message = "{0} s'est déconnecté à {1}" -f $user, $_.Properties[1].Value
        Write-Log $message
    }
}

#Surveillance des événements d'accès aux fichiers
Write-Host "Surveillance des événements d'accès aux fichiers..."
Get-WinEvent -FilterHashtable @{
    LogName = "Security"
    Id = 4663
    StartTime = (Get-Date).AddHours(-1)
} | ForEach-Object {
    $user = $_.Properties[1].Value
    if ($usersToMonitor -contains $user) {
        $message = "{0} a accédé à {1}" -f $user, $_.Properties[6].Value
        Write-Log $message
    }
}

#Surveillance des événements de modification des fichiers
Write-Host "Surveillance des événements de modification des fichiers..."
Get-WinEvent -FilterHashtable @{
    LogName = "Security"
    Id = 4670
    StartTime = (Get-Date).AddHours(-1)
} | ForEach-Object {
    $user = $_.Properties[1].Value
    if ($usersToMonitor -contains $user) {
        $message = "{0} a modifié {1}" -f $user, $_.Properties[6].Value
        Write-Log $message
    }
}
