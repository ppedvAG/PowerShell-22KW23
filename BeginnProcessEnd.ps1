[cmdletBinding()]
param(
[Parameter(ValueFromPipeLine=$true,ValueFromPipeLineByPropertyName,Mandatory=$true)]
[string]$Name
)

Begin
{
    Write-Host -Object "Wird einmalig ausgeführt" -BackgroundColor White -ForegroundColor Blue
}
Process
{# Wird für jedes OBjekt ausgeführt
    Write-Host -ForegroundColor (Get-Random -Maximum 15 -Minimum 0) -Object $Name
}
End
{
     Write-Host -Object "Wird einmalig ausgeführt" -BackgroundColor White -ForegroundColor Blue
}



