#************************************************************************************************************************************
# PERFMON COUNTERS
#
# This script checks all installed instances, verify if the data collector exists and create, update or delete as necessary
# .blg files are saved on a subfolder on backup directory
#************************************************************************************************************************************

#set-executionpolicy unrestricted

[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | out-null
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.ConnectionInfo') | out-null
Set-ExecutionPolicy Unrestricted -Force | out-null
Import-Module -Name SQLPS -DisableNameChecking | out-null



#ask for a directory to save blg files
$target = $null


while ($target -eq $null){
$target = read-host "Enter a directory name"
if (-not(test-path $target)){
    Write-host "Invalid directory path, re-enter."
    $target = $null
    }
elseif (-not (get-item $target).psiscontainer){
    Write-host "Target must be a directory, re-enter."
    $target = $null
    }
}


#verify all installed instances
$Instances = (get-itemproperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server').InstalledInstances 
foreach ($i in $Instances)
{
write-host ''
write-host '***** PERFMON COUNTERS - Create / Update / Delete *****'
write-host ''
    $InstanceName = $i
    #create the instance and service names
	$server = [System.Net.Dns]::GetHostName()
    if ($InstanceName -eq "MSSQLSERVER")
        {$service = 'MSSQLSERVER'
         $sqlcntr = 'SQLServer'}
    else {$service = ('MSSQL$'+$InstanceName)
          $sqlcntr = $service}
    $SQLPerf = "SQLPerf_$InstanceName"
    write-host "InstanceName:$InstanceName | ServiceName:$service"
    write-host "DataColletorName:$SQLPerf"
	
	#Check if the service is running
    $status = (Get-Service $service).Status
	if ($status -eq "Running")
		{write-host "Status: Running"
  
        # Create the evaluation results directory if it doesn't exist
        if (!(Test-Path -path "$target\SQLPerf\"))
	        {
	        New-Item "$target\SQLPerf\" -type directory | out-null
	        }
        write-host "BlgPath:$target\SQLPerf\"

$cfg = @"
\LogicalDisk(_Total)\Avg. Disk sec/Read
\LogicalDisk(*)\Avg. Disk sec/Read
\LogicalDisk(_Total)\Avg. Disk sec/Transfer
\LogicalDisk(*)\Avg. Disk sec/Transfer
\LogicalDisk(_Total)\Avg. Disk sec/Write
\LogicalDisk(*)\Avg. Disk sec/Write
\LogicalDisk(_Total)\Current Disk Queue Length
\LogicalDisk(*)\Current Disk Queue Length
\LogicalDisk(_Total)\Disk Bytes/sec
\LogicalDisk(*)\Disk Bytes/sec
\LogicalDisk(_Total)\Disk Read Bytes/sec
\LogicalDisk(*)\Disk Read Bytes/sec
\LogicalDisk(_Total)\Disk Write Bytes/sec
\LogicalDisk(*)\Disk Write Bytes/sec
\LogicalDisk(_Total)\Disk Reads/sec
\LogicalDisk(*)\Disk Transfers/sec
\LogicalDisk(*)\Disk Writes/sec
\LogicalDisk(_Total)\Disk Writes/sec
\LogicalDisk(_Total)\Disk Transfers/sec
\LogicalDisk(*)\Disk Reads/sec
\Network Interface(*)\Bytes Received/sec
\Network Interface(*)\Bytes Sent/sec
\Network Interface(*)\Bytes Total/sec
\Memory\% Committed Bytes In Use
\Memory\Available MBytes
\Memory\Committed Bytes
\Memory\Free System Page Table Entries
\Memory\Pool Nonpaged Bytes
\Memory\Pool Paged Bytes
\Processor(*)\% Processor Time
\Processor(_Total)\% Processor Time
\Processor(_Total)\% Privileged Time
\Processor(*)\% Privileged Time
\System\Context Switches/sec
\System\Exception Dispatches/sec
\System\Processor Queue Length
\System\System Calls/sec
\$($sqlcntr):Buffer Manager\Database pages
\$($sqlcntr):Buffer Manager\Free list stalls/sec
\$($sqlcntr):Buffer Manager\Free pages
\$($sqlcntr):Buffer Manager\Lazy writes/sec
\$($sqlcntr):Buffer Manager\Page life expectancy
\$($sqlcntr):Buffer Manager\Page lookups/sec
\$($sqlcntr):Buffer Manager\Page reads/sec
\$($sqlcntr):Buffer Manager\Readahead pages/sec
\$($sqlcntr):Buffer Manager\Stolen pages
\$($sqlcntr):Buffer Manager\Target pages
\$($sqlcntr):Buffer Manager\Total pages
\$($sqlcntr):General Statistics\Connection Reset/sec
\$($sqlcntr):General Statistics\Logins/sec
\$($sqlcntr):General Statistics\Logouts/sec
\$($sqlcntr):General Statistics\User Connections
\$($sqlcntr):SQL Statistics\Batch Requests/sec
\$($sqlcntr):SQL Statistics\Forced Parameterizations/sec
\$($sqlcntr):SQL Statistics\Safe Auto-Params/sec
\$($sqlcntr):SQL Statistics\SQL Compilations/sec
\$($sqlcntr):SQL Statistics\SQL Re-Compilations/sec
\$($sqlcntr):Buffer Manager\*
\$($sqlcntr):General Statistics\*
\$($sqlcntr):SQL Statistics\*
\Process(*)\% Privileged Time
\Process(*)\% Processor Time
\Process(*)\% User Time
"@
$cfg | out-file "$target\SQLPerf\$server-$InstanceName.config" -encoding ASCII
write-host 'Config File Created at BlgPath'


        # Check if the data collector already exists and update it, else create a new data colletor
        $CheckDataColletor = logman query $SQLPerf
        if ($CheckDataColletor -contains 'Data Collector Set was not found.')
             {$dt = "_$(get-date -f _yyyy_MM_dd)"
            logman create counter $SQLPerf -f bin -a -max 100 -cnf 24:00:00 -si 10 -v nnnnnn  -o "$target\SQLPerf\$server-$InstanceName$dt" -cf "$target\SQLPerf\$server-$InstanceName.config"  | out-null
            logman start $SQLPerf | out-null
            write-host "Data Collector $SQLPerf Created"}
        else
            {logman update counter $SQLPerf -f bin  -max 100 -cnf 24:00:00 -si 10  -o "$target\SQLPerf\$server-$InstanceName$dt" -cf "$target\SQLPerf\$server-$InstanceName.config" | out-null
            logman stop $SQLPerf | out-null
            logman start $SQLPerf | out-null
            Write-host "Data Collector $SQLPerf updated"}
            

        # Delete files older than the $limit.
        $limit = (Get-Date).AddDays(-1000)
        $path = "$target\SQLPerf\"

        $items = Get-ChildItem -Path $path -Recurse -include *.blg, *.rpt  -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit }
        foreach ($i in $items)
            {
            $item = $i
            $item | Remove-Item -Force
            write-host 'Old files deleted'
            }
            write-host 'Old files not found'
        }
else
    {
        write-host 'Service is not running'
        # Stop and delete Perfmon Counter log if exists
        $CheckDataColletor = logman query $SQLPerf
                if ($CheckDataColletor -notcontains 'Data Collector Set was not found.')
                    {logman stop $SQLPerf | out-null
                    Logman delete $SQLPerf | out-null
                    write-host "Data Collector $SQLPerf deleted"}
                else 
                {write-host 'DataColector not found'}
                
    }
}