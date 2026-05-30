<#
.SYNOPSIS
Continuously tests TCP reachability with Test-NetConnection and logs results.

.PARAMETER ComputerName
Target host name or IP address to test.

.PARAMETER Port
Target TCP port to test.

.PARAMETER LogPath
Path to the output log file. Defaults to C:\Temp\<hostname>.log.

.PARAMETER IntervalSeconds
Seconds to wait between checks. Defaults to 2.

.EXAMPLE
.\scripts\powershell\Test-NetConnectionLoop.ps1 -ComputerName 8.8.8.8 -Port 53
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$ComputerName,

    [Parameter(Mandatory)]
    [int]$Port,

    [string]$LogPath = (Join-Path -Path 'C:\Temp' -ChildPath "$env:COMPUTERNAME.log"),

    [int]$IntervalSeconds = 2
)

while ($true) {
    $wr = Test-NetConnection -ComputerName $ComputerName -Port $Port -InformationLevel Quiet -ErrorAction Continue
    $result = ((Get-Date).ToUniversalTime()).ToString('yyyy-MM-dd HH:mm:ss.fff') + ",$env:COMPUTERNAME," + $wr
    Write-Host $result
    $result >> $LogPath
    Start-Sleep -Seconds $IntervalSeconds
}
