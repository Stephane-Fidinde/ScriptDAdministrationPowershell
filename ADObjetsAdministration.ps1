# Importer le module Active Directory
Import-Module ActiveDirectory

# Définir les paramètres
$nomUtilisateur = "jpierre"
$nomComplet = "Jacques Pierre"
$motDePasse = ConvertTo-SecureString "MonMotDePasse" -AsPlainText -Force
$unitéOrganisationnelle = "OU=Ventes,OU=Utilisateurs,DC=MonEntreprise,DC=com"

# Créer un nouvel utilisateur
New-ADUser -Name $nomComplet -SamAccountName $nomUtilisateur -AccountPassword $motDePasse -Enabled $true -Path $unitéOrganisationnelle

# Modifier les propriétés d'un utilisateur existant
Set-ADUser -Identity $nomUtilisateur -GivenName "Jacques" -Surname "Pierre" -EmailAddress "jpierre@monentreprise.com" -OfficePhone "0147474747" -Mobile "0606060606"

# Désactiver un utilisateur
Disable-ADAccount -Identity $nomUtilisateur

# Activer un utilisateur
Enable-ADAccount -Identity $nomUtilisateur

# Réinitialiser le mot de passe d'un utilisateur
Set-ADAccountPassword -Identity $nomUtilisateur -NewPassword $motDePasse -Reset

# Supprimer un utilisateur
Remove-ADUser -Identity $nomUtilisateur
