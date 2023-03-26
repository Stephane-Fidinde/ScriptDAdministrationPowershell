#Définition des variables
$apiUrl = "https://api.example.com/exemple"
$apiKey = "Cle_api"
$headers = @{
    "Authorization" = "Bearer $apiKey"
    "Content-Type" = "application/json"
}

#Définition des données à envoyer
$data = @{
    "name" = "Jacques Pierre"
    "email" = "jpierre@example.com"
    "phone" = "1234567890"
} | ConvertTo-Json

#Appel de l'API
$response = Invoke-RestMethod -Uri $apiUrl -Method Post -Headers $headers -Body $data

#Affichage de la réponse
Write-Host "Code de réponse : $($response.StatusCode)"
Write-Host "Réponse : $($response.Content)"
