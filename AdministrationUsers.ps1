#Définition des variables
$computerName = "localhost"
$domainName = "example.com"
$localAdmin = "admin"
$localAdminPassword = "password"
$newUser = "jacques.pierre"
$newUserPassword = "password123"
$groupName = "Administrateurs du domaine"

#Ajout d'un utilisateur local
Write-Host "Ajout de l'utilisateur $newUser..."
$securePassword = ConvertTo-SecureString $newUserPassword -AsPlainText -Force
New-LocalUser -Name $newUser -Password $securePassword -FullName $newUser

#Ajout de l'utilisateur à un groupe local
Write-Host "Ajout de l'utilisateur $newUser au groupe Administrateurs..."
Add-LocalGroupMember -Group "Administrateurs" -Member $newUser

#Création d'un compte d'utilisateur dans le domaine
Write-Host "Création du compte d'utilisateur $newUser dans le domaine..."
$securePassword = ConvertTo-SecureString $newUserPassword -AsPlainText -Force
New-ADUser -Name $newUser -AccountPassword $securePassword -Enabled $true -PasswordNeverExpires $true -ChangePasswordAtLogon $false -UserPrincipalName "$newUser@$domainName" -DisplayName $newUser

#Ajout de l'utilisateur à un groupe dans le domaine
Write-Host "Ajout de l'utilisateur $newUser au groupe $groupName dans le domaine..."
Add-ADGroupMember -Identity $groupName -Members $newUser

#Réinitialisation du mot de passe de l'utilisateur local
Write-Host "Réinitialisation du mot de passe de l'utilisateur local $localAdmin..."
$securePassword = ConvertTo-SecureString $localAdminPassword -AsPlainText -Force
Set-LocalUser -Name $localAdmin -Password $securePassword

#Réinitialisation du mot de passe de l'utilisateur du domaine
Write-Host "Réinitialisation du mot de passe de l'utilisateur du domaine $newUser..."
Set-ADAccountPassword -Identity $newUser -Reset -NewPassword (ConvertTo-SecureString -AsPlainText $newUserPassword -Force) -PassThru

#Redémarrage du système
Write-Host "Redémarrage du système..."
Restart-Computer -Force
