# Simple Connectivity-Loop-Scripts
This repro has simple loop scripts for PPSING, NC, Test-NetConnection and others for testing and common troubleshooting.
```bash
##NetCat

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

# Single line NC loop script without logging
while true; do nc -zv 8.8.8.8 53;sleep 1; date;done!

##Wget

for i in {0..100}; do wget --spider -S "YOURURI" 2>&1 | grep "HTTP/" | awk '{print $2}' ; done!

##Curl

while true; do curl -w "dns_resolution: %{time_namelookup}, tcp_established: %{time_connect}, ssl_handshake_done: %{time_appconnect}, TTFB: %{time_starttransfer}\n" -o /dev/null -s "YOURURI"; done
for i in {1..100}; do curl -k -o /dev/null -s -w "DNS-Lookup [%{time_namelookup}] Time-Connect [%{time_connect}] Time-PreTransfer [%{time_pretransfer}] Time-StartTransfer [%{time_starttransfer}] Total-Time [%{time_total}] Response-Code [%{http_code}]\n" YOURURI; done!

while true; do sudo  curl YOURURI -i --resolve cpa-api.walmart.com:443:10.33.93.237 -kIv -w "%{time_starttransfer}\n%{time_total}\n";sleep 1;done >>curl.log!

##TCPPING

tcpping -r 2 -d YOURURI!

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

##PSPING

#Run this in PowerShell. If you want the logging, assuming file already created at path!
psping -t YOURIP:YOURPort |Foreach{"{0} - {1}" -f (Get-Date),$_} | Out-File -FilePath c:\test.txt!




