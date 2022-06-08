<#
.SYNOPSIS
Kurz: Abfrage von User Logon bezogenen Events
.DESCRIPTION
Lang: Abfrage der Anmelde, Abmelde oder fehlgeschlagenen Anmelde Events des Systems
.PARAMETER Eventid
Folgende Werte sind mögliche
4624 : Anmeldung
4625 : fehlgeschlagene Anmeldung
4634 : Abmeldung
.EXAMPLE
Skriptbeispiel.ps1 -Eventid 4634 -Verbose
AUSFÜHRLICH: Der User hat angegeben: localhost | 4634 | 5

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
   54521 Jun 08 10:47  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
   54518 Jun 08 10:47  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
   54515 Jun 08 10:46  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
   54513 Jun 08 10:46  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
   54510 Jun 08 10:45  SuccessA... Microsoft-Windows...         4634 Ein Konto wurde abgemeldet....
.EXAMPLE
Skriptbeispiel.ps1 -Eventid 4624

   Index Time          EntryType   Source                 InstanceID Message
   ----- ----          ---------   ------                 ---------- -------
   54561 Jun 08 10:51  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
   54556 Jun 08 10:50  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
   54553 Jun 08 10:50  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
   54549 Jun 08 10:50  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
   54546 Jun 08 10:50  SuccessA... Microsoft-Windows...         4624 Ein Konto wurde erfolgreich angemeldet....
.LINK
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-7.2#syntax-for-comment-based-help-in-scripts
#>
[cmdletBinding()]
param(

[ValidateScript({Test-NetConnection -ComputerName $PSItem -CommonTCPPort WinRM -InformationLevel Quiet})]
[string]$ComputerName = "localhost",

[Parameter(Mandatory=$true)]
[ValidateSet(4624,4625,4634)]
[int]$Eventid,

[ValidateRange(5,10)]
[int]$Newest = 5
)

#Diese Ausgabe wird nur ausgegeben wenn das Skript mit -Verbose gestartet wird
Write-Verbose -Message "Der User hat angegeben: $ComputerName | $Eventid | $Newest"

Get-EventLog -LogName Security -ComputerName $ComputerName | Where-Object EventId -eq $Eventid | Select-Object -First $Newest
