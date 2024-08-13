# Monitoring Free Disk Space and Send Email Alert using postfix service.

#!/bin/bash
space=$(free -mt | grep "Total" | awk '{print$4}')
limit=600
TO="lakshmiprasannakusumanchi@gmail.com"
if [[ $space -lt $limit ]]
then
        echo "Free Space" | mail -s "ALERT!! your disk space is $space" $TO
else
        echo "disk space is $space"
fi 


