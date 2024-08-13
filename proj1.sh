# Monitoring Free RAM Space of a directory
# The script monitors the available free RAM space by using the `free` command and filtering the output with `grep` and `awk` to extract the available memory in megabytes. It then compares the free space against a predefined limit (400 MB). If the available space is below the limit, it prompts a warning message to free up space; otherwise, it displays the current free RAM.

#!/bin/bash
space=$(free -mt | grep "Total" | awk '{print$4}')
limit=400
if [[ $space -lt $limit ]]
then
	echo "Need to free up the disk reached the limit"
else
	echo "disk space is $space"
fi
