# cleanup ASSP Spam folder looking for phrases from text file (pattern)
$pattern = "D:\Batch\notspammers.txt"
$path_source = "D:\ASSP\spam"    
$path_target = "D:\Temp\spam_possible"
$counter = 0

$script_start = (Get-Date)

ForEach ($string in Get-Content $pattern)

{
echo $string
gci $path_source -filter *.eml | select-string $string -casesensitive -list | select path | move-item -dest $path_target
$counter++
}

$script_stop = (Get-Date)
$run_time = New-Timespan -Start $script_start -End $script_stop
"--------------------------------------------------------------------------------"
"Finished cleaning: " + $path_source
"Total search strings: " + $counter
"Start time: " + $script_start
"End time: " + $script_stop
"Elapsed Time: {0:hh}:{0:mm}:{0:ss}" -f $run_time
"--------------------------------------------------------------------------------"
