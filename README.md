# Simple Loop Scripts

![Bash](https://img.shields.io/badge/Bash-4EAA25?logo=gnu-bash&logoColor=white) ![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?logo=powershell&logoColor=white) ![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

A toolkit of small connectivity-loop scripts for testing TCP/UDP reachability with NetCat, Curl, Wget, TCPPing, Test-NetConnection, and PSPing.

## Table of Contents

- [🎯 When To Use](#-when-to-use)
- [📜 Script Catalog](#-script-catalog)
- [🚀 Quick Start](#-quick-start)
- [📋 Original One-liners](#-original-one-liners)
- [📄 License](#-license)

## 🎯 When To Use

Use these scripts for ad-hoc network troubleshooting, intermittent reachability checks, and simple log-to-file probes when you need lightweight loops around common connectivity tools.

## 📜 Script Catalog

| Script | Language | Purpose | Example |
| --- | --- | --- | --- |
| `scripts/bash/nc-loop.sh` | Bash | NetCat TCP reachability loop with failure logging to `test.log`. | `./scripts/bash/nc-loop.sh 8.8.8.8 53` |
| `scripts/bash/nc-oneliner.sh` | Bash | NetCat TCP reachability loop with date output. | `./scripts/bash/nc-oneliner.sh 8.8.8.8 53` |
| `scripts/bash/wget-status.sh` | Bash | Repeatedly fetch HTTP status codes with Wget. | `./scripts/bash/wget-status.sh https://example.com 100` |
| `scripts/bash/curl-timing.sh` | Bash | Continuously print Curl DNS, TCP, TLS, and TTFB timings. | `./scripts/bash/curl-timing.sh https://example.com` |
| `scripts/bash/curl-status-loop.sh` | Bash | Run fixed-count Curl status and timing checks. | `./scripts/bash/curl-status-loop.sh https://example.com 100` |
| `scripts/bash/curl-trace.sh` | Bash | Continuously print Curl status, timing, and endpoint details. | `./scripts/bash/curl-trace.sh https://example.com` |
| `scripts/bash/tcpping.sh` | Bash | Wrap `tcpping -r 2 -d` for a target URI or endpoint. | `./scripts/bash/tcpping.sh example.com:443` |
| `scripts/powershell/Test-NetConnectionLoop.ps1` | PowerShell | Loop `Test-NetConnection` checks and log timestamped results. | `.\scripts\powershell\Test-NetConnectionLoop.ps1 -ComputerName 8.8.8.8 -Port 53` |
| `scripts/powershell/Psping-Loop.ps1` | PowerShell | Run continuous PSPing with timestamped log output. | `.\scripts\powershell\Psping-Loop.ps1 -IpPort 8.8.8.8:53` |

## 🚀 Quick Start

```bash
chmod +x scripts/bash/nc-loop.sh
./scripts/bash/nc-loop.sh 8.8.8.8 53
```

```powershell
New-Item -ItemType Directory -Force C:\Temp | Out-Null
.\scripts\powershell\Test-NetConnectionLoop.ps1 -ComputerName 8.8.8.8 -Port 53
```

## 📋 Original One-liners

<details>
<summary>Show original combined snippets</summary>

```bash
##NetCat
-----------------------------------------------------------------------------
# In Linux open text editor such a Vi and entering the following. Once done, in Vi type wq!. Change the IP and TCP/UDP port you want to test against
port="YOURTCPPORT"
ip="YOURIP"
timeoutSecs=5
while true ; do
if $(nc -z -v -w $timeoutSecs $ip $port &>/dev/null); then
        echo "Server is up,"`date +"%d/%m/%Y %H:%M:%S"`
        else
        echo "Server is DOWN-check logs!,"`date +"%d/%m/%Y %H:%M:%S"` >> test.log
        fi
sleep 1

# To make the file executable
chmod +x filename.sh!
# To execute
./filename.sh
------------------------------------------------------------------------------
# Single line NC loop script without logging
while true; do nc -zv 8.8.8.8 53;sleep 1; date;done!
------------------------------------------------------------------------------
##Wget

for i in {0..100}; do wget --spider -S "YOURURI" 2>&1 | grep "HTTP/" | awk '{print $2}' ; done!
----------------------------------------------------------------------------------
##Curl

while true; do curl -w "dns_resolution: %{time_namelookup}, tcp_established: %{time_connect}, ssl_handshake_done: %{time_appconnect}, TTFB: %{time_starttransfer}\n" -o /dev/null -s "YOURURI"; done
for i in {1..100}; do curl -k -o /dev/null -s -w "DNS-Lookup [%{time_namelookup}] Time-Connect [%{time_connect}] Time-PreTransfer [%{time_pretransfer}] Time-StartTransfer [%{time_starttransfer}] Total-Time [%{time_total}] Response-Code [%{http_code}]\n" YOURURI; done!
---------------------------------------------------------------------------------------------------------------------------------------
while true; do curl -w "%{http_code},%{time_total},%{local_ip},%{local_port},%{remote_ip},%{remote_port}," YOURURI; date -u;sleep 1; done
----------------------------------------------------------------------------------------------------------------------------------------
for i in {1..100}; do curl -k -o /dev/null -s -w "DNS-Lookup [%{time_namelookup}] Time-Connect [%{time_connect}] Time-PreTransfer [%{time_pretransfer}] Time-StartTransfer [%{time_starttransfer}] Total-Time [%{time_total}] Response-Code [%{http_code}]\n" YOURURI; done!
-----------------------------------------------------------------------------------------------------------------------------------------
##TCPPING

tcpping -r 2 -d YOURURI!
-----------------------------------------------------------------------------------------------------------------------------------------
##PowerShell

#This assumes log file already created in path
$logfile="C:\Temp\"+$env:COMPUTERNAME+".log"
while($true) { 
$wr =(Test-NetConnection -ComputerName YOURIP -Port YOURPORT -InformationLevel Quiet -ErrorAction Continue)
$result = ((get-date).ToUniversalTime()).ToString("yyyy-MM-dd HH:mm:ss.fff")+",$env:COMPUTERNAME,"+$wr
Write-Host $result 
$result >> $logfile
# Add sleep if you want a large interval
Start-Sleep -Seconds 2
}
------------------------------------------------------------------------------------------------------------------------------------------
##PSPING

#Run this in PowerShell. If you want the logging, assuming file already created at path!
psping -t YOURIP:YOURPort |Foreach{"{0} - {1}" -f (Get-Date),$_} | Out-File -FilePath c:\test.txt!
```

</details>

## 📄 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
