#Définition des variables
$apiKey = "votre_clé_API"
$apiUrl = "https://api.example.com"
$newUser = @{
    name = "Jacques Pierre"
    email = "jpierre@example.com"
}

#Authentification à l'API
$headers = @{
    "Authorization" = "Bearer $apiKey"
    "Content-Type" = "application/json"
}

#Création d'un nouvel utilisateur
$response = Invoke-RestMethod -Method Post -Uri "$apiUrl/users" -Headers $headers -Body ($newUser | ConvertTo-Json)
$newUserId = $response.id

#Récupération des informations de l'utilisateur créé
$user = Invoke-RestMethod -Method Get -Uri "$apiUrl/users/$newUserId" -Headers $headers

#Mise à jour des informations de l'utilisateur
$user.name = "Jean Pierre"
Invoke-RestMethod -Method Put -Uri "$apiUrl/users/$newUserId" -Headers $headers -Body ($user | ConvertTo-Json)

#Suppression de l'utilisateur
Invoke-RestMethod -Method Delete -Uri "$apiUrl/users/$newUserId" -Headers $headers
