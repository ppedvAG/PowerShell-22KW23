function New-TestFilesDir
{
[cmdletBinding()]
param(
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path -Path $PSItem -PathType Container})]
    [string]$Path,

    [ValidateRange(1,100)]
    [int]$DirCount = 3,

    [ValidateRange(1,100)]
    [int]$FileCount = 9,

    [ValidateLength(3,20)]
    [string]$Name = "Testfiles",

    [switch]$Force
)

if($Path.EndsWith("\"))
{
    $TestDirPath = $Path + $Name
}
else
{
    $TestDirPath = $Path + "\" + $Name
}

if(Test-Path -Path $TestDirPath)
{
    if($Force)
    {
        Remove-Item -Path $TestDirPath -Force -Recurse
    }
    else
    {
        throw "Ordner bereits vorhanden"
    }
}

$TestDir = New-Item -Path $Path -Name $Name -ItemType Directory
Write-Debug -Message "Vor Schleife Root Files"

New-TestFiles -Path $TestDir.FullName -FileCount $FileCount 
<# Ersetzt durch Funtion New-TestFiles
for($i = 1; $i -le $FileCount; $i++)
{
    $FileNumber = "{0:D3}" -f $i
    $FileName = "File" + $FileNumber + ".txt"

    New-Item -Path $TestDir.FullName -Name $FileName -ItemType File
}#>

for($i = 1; $i -le $DirCount; $i++)
{
    $DirNumber = "{0:D3}" -f $i
    $DirName = "Dir" + $DirNumber

    $SubDir = New-Item -Path $TestDir.FullName -Name $DirName -ItemType Directory
    
    New-TestFiles -Path $SubDir.FullName -FileCount $FileCount -Prefix ($SubDir.Name + "File")
    <# ersetzt durch Funktion New-TestFiles
    for($j = 1; $j -le $FileCount; $j++)
    {
        $FileNumber = "{0:D3}" -f $j
        $FileName = $SubDir.Name +"File" + $FileNumber + ".txt"

        New-Item -Path $SubDir.FullName -Name $FileName -ItemType File
    }
    #>
}
}

function New-TestFiles
{
[cmdletBinding()]
param(
[Parameter(Mandatory=$true)]
[ValidateScript({Test-Path -Path $PSItem -PathType Container})]
[string]$Path,

[ValidateRange(1,100)]
[int]$FileCount = 9,

[ValidateLength(3,20)]
[string]$Prefix = "File"
)

for($i = 1; $i -le $FileCount; $i++)
{
    $FileNumber = "{0:D3}" -f $i
    $FileName = "$Prefix" + $FileNumber + ".txt"

    New-Item -Path $Path -Name $FileName -ItemType File
}

}