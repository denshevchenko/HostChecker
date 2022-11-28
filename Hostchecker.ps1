
# Получаем конфиг, парсим его и формируем переменные

param(
    [string]$paramFile = '.\Config.json'
)
# For each object in the JSON, create a powershell variable
$params = Get-Content $paramFile | ConvertFrom-Json
$params.PSObject.Properties | ForEach-Object {
    New-Variable -Name $_.Name -Value $_.Value -Force
}

 $servicename = $serverParameters.serviceName


 #Фунцкия для записи логов

$logFile = "$env:Temp\LogFile.json"
function WriteLog
{
Param ([string]$logString)
$timeStamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
$logMessage = "$timeStamp $logString"
Add-content $LogFile -value $logMessage
}

#Устанавливаем SSH-сессию

$session = New-PSSession -HostName $servers.hostName1 -UserName Administrator -SSHTransport

Invoke-Command -Session $session  -ScriptBlock {

if (Get-Service $servicename -computername $servers.hostName1 | Where-Object {$_.status -eq "running"}  )
{

Write-Host "$servicename exists and is running on server"

WriteLog "servicename exists and is running on server"


}


else{write-host "No service $servicename found on server or it is stopped."} 

WriteLog "No service $servicename found on server or it is stopped"

}

Invoke-Command -Session $session  -ScriptBlock  {


get-date | Select-Object DisplayName

if ($timeZone -like '(GMT+3)*' )
{

Write-Host "Timezone is correct"

WriteLog "Timezone is correct"


}

else {write-host "Timezone is incorrect. Current timezone is $timeZone"}

WriteLog "Timezone is incorrect. Current timezone is $timeZone"

}

Invoke-Command -Session $session  -ScriptBlock  {

if((Get-ADUser -Identity svcAcc  | Where-Object{ $_.accountExpires -eq "false"}) -and  (Get-ADUser -Identity svcAcc  | Where-Object{ $_.PasswordNeverExpires -eq "DisablePasswordExpiration"}))

{

Write-Host "Service Account is set up correctly"

WriteLog "Service Account is set up correctly"


}

else {write-host "Service Account is set up incorrectly or doesn't exist"}

WriteLog "Service Account is set up incorrectly or doesn't exist"


}
