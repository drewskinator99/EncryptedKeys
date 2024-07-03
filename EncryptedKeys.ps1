# Created by: drewskinator99

###########################################################
# Working with Keys and Encrypted Text Files for Passwords 
###########################################################

# Name the key file
$KeyFile = "C:\Path\ToYour\key.key"
# Create key file
$Key = New-Object Byte[] 32   # You can use 16, 24, or 32 for AES
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($Key)
$Key | out-file $KeyFile

# Create encrypted password file
$PasswordFile = "C\Path\ToPassword\File.txt"
$Key = Get-Content $KeyFile
$Password = '' | ConvertTo-SecureString -AsPlainText -Force
$Password | ConvertFrom-SecureString -key $Key | Out-File $PasswordFile

########################################
# Working with Encrypted Password File
# Example - SFTP Credentials
########################################

$username = "username"    
$creds =  New-Object -TypeName System.Management.Automation.PSCredential `
 -ArgumentList $username, (Get-Content $PasswordFile | ConvertTo-SecureString -Key $key)
$sftppass = $creds.Password

######################################
# Working with CliXML Encrypted Files
######################################

# How to create a CliXML File
$credential = ''
$credential | Export-Clixml "C:\Path\XML_PAK.xml"

# How to load encrypted credential XML File:
$credential = Import-Clixml -Path "C:\Path\XML_PAK.xml"