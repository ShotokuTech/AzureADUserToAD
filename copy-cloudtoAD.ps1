connect-azuread
#You will want to either come up with your own filter or perhaps loop through a list.
$users = get-azureaduser -all $true -filter "startswith(userprincipalname,'cloud.toadtest3')"
foreach($user in $users){
$user.MailNickName
$password = ConvertTo-SecureString "A`ni\R8)xl9Vu~ga8?Lg" -AsPlainText -Force
New-ADUser -Name $user.MailNickName -Path "OU=Sync,OU=UserObjects,DC=aaco,DC=local" `
-City $user.City -Company $user.CompanyName -Department $user.Department `
-DisplayName $user.DisplayName -EmailAddress $user.Mail `
-EmployeeID $user.ExtensionProperty.employeeId -Fax $user.FacsimileTelephoneNumber `
-GivenName $user.GivenName -MobilePhone $user.Mobile `
-Office $user.PhysicalDeliveryOfficeName -OfficePhone $user.TelephoneNumber `
-PostalCode $user.PostalCode -SamAccountName $user.MailNickName -State $user.State `
-StreetAddress $user.StreetAddress -Surname $user.Surname -Title $user.JobTitle `
-UserPrincipalName $user.UserPrincipalName `
-AccountPassword $password -Enabled $true
}


<# This caused and error, not sure why.'-Country $user.Country'. #>

<# Initially I tried '-Enabled $true'. But since there is nothing setting the password 
on the account in AD, it does not meet complexity requirements. 
If you have your cloud users set up to use passwordreset.microsoftonline.com then you
could set an artbitrary password and enable the account in AD and the users could 
reset their password in the cloud after migrating to AD. #>

