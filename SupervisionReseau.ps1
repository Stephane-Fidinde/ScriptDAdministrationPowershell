#Définition des variables
$hostname = "localhost"
$timeout = 1000
$pingcount = 5

# Vérification de la connectivité Ping
Write-Host "Vérification de la connectivité avec $hostname..."
$ping = Test-Connection -ComputerName $hostname -Count $pingcount -BufferSize 16 -Timeout $timeout
If ($ping.ResponseTime -ne $null){
    Write-Host "Ping réussi en" $ping.ResponseTime "ms."
}
Else{
    Write-Host "Le ping a échoué."
}

# Vérification de la bande passante
Write-Host "Vérification de la bande passante..."
$bandwidth = Get-NetTCPConnection | Measure-Object -Property 'ReceiveBytesPerSecond','SendBytesPerSecond' -Sum
Write-Host "La bande passante entrante est de $($bandwidth.Sum.ReceiveBytesPerSecond/1MB) MB/s."
Write-Host "La bande passante sortante est de $($bandwidth.Sum.SendBytesPerSecond/1MB) MB/s."
