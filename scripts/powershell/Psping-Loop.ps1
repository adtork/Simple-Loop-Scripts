<#
.SYNOPSIS
Runs PSPing continuously and writes timestamped results to a log file.

.PARAMETER IpPort
Target endpoint in IP:Port or host:port format.

.PARAMETER LogPath
Path to the output log file. Defaults to C:\test.txt.

.EXAMPLE
.\scripts\powershell\Psping-Loop.ps1 -IpPort 8.8.8.8:53
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$IpPort,

    [string]$LogPath = 'C:\test.txt'
)

psping -t $IpPort | ForEach-Object { "{0} - {1}" -f (Get-Date), $_ } | Out-File -FilePath $LogPath
