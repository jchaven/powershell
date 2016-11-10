# cleanup ASSP NotSpam folder looking for phrases from text file (pattern)
$pattern = "D:\Batch\spammers.txt"
$path_source = "D:\ASSP\notspam"    
$path_target = "D:\Temp\spam_possible"
$path_parked = "D:\Temp\notspam"
$counter = 0

$script_start = (Get-Date)

# move large files to temp location to speed-up search
gci $path_source | where {$_.Length -gt 1mb} | Move-Item -Destination $path_parked

# scan each message for matching spam pattern
ForEach ($string in Get-Content $pattern)
{
echo $string
gci $path_source -filter *.eml | select-string $string -casesensitive -list | select path | move-item -dest $path_target
$counter++
}

# move parked files back to NotSpam folder
gci $path_parked | Move-Item -Destination $path_source

$script_stop = (Get-Date)
$run_time = New-Timespan -Start $script_start -End $script_stop
"--------------------------------------------------------------------------------"
"Finished cleaning: " + $path_source
"Total search strings: " + $counter
"Start time: " + $script_start
"End time: " + $script_stop
"Elapsed Time: {0:hh}:{0:mm}:{0:ss}" -f $run_time
"--------------------------------------------------------------------------------"
