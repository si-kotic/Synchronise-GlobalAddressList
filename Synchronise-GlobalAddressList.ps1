$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential (Get-Credential) -Authentication Basic -AllowRedirection
Import-PSSession -Session $Session -DisableNameChecking

$olContactItem = 2 
$o = new-object -comobject outlook.application 

Get-Recipient | Where {$_.RecipientType -eq "UserMailbox" -and $_.Phone} | Foreach-Object {
    $c = $o.CreateItem($olContactItem)
    $c.FullName = $_.DisplayName
    $c.Email1Address = $_.PrimarySmtpAddress
    $c.MobileTelephoneNumber = $_.Phone

    $a = $c.Save()
}