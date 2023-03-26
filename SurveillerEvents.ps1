#Définition des variables
$logName = "System"
$eventId = 4624
$maxEvents = 10

#Récupération des derniers événements du journal
Write-Host "Surveillance des événements du journal $logName..."
$events = Get-EventLog -LogName $logName -InstanceId $eventId -Newest $maxEvents

#Affichage des événements
foreach ($event in $events) {
    Write-Host "--------------------------------------------------"
    Write-Host "Date: $($event.TimeGenerated)"
    Write-Host "Source: $($event.Source)"
    Write-Host "ID: $($event.InstanceId)"
    Write-Host "Message: $($event.Message)"
}

#Surveillance en continu des événements
Write-Host "Surveillance en continu des événements..."
while ($true) {
    $event = Get-EventLog -LogName $logName -InstanceId $eventId -Newest 1
    if ($event) {
        Write-Host "--------------------------------------------------"
        Write-Host "Date: $($event.TimeGenerated)"
        Write-Host "Source: $($event.Source)"
        Write-Host "ID: $($event.InstanceId)"
        Write-Host "Message: $($event.Message)"
    }
    Start-Sleep -Seconds 5
}
