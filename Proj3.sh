# Archive Older Logs by compressing into the zip file,so that system performance can be enhanced, 
# as fewer files need to be processed or indexed.

#!/bin/bash

#vairables
BASE=/home/ec2-user/temp
#maximum depth to search 
DEPTH=1

#check if the directory is +int or not 
if [ ! -d $BASE ]
then
	echo "directory does not exist: $BASE"
	exit 1
fi

#create 'archive' folder if not +nt
if [ ! -d $BASE/archive ]
then 
	mkdir $BASE/archive
fi

#find the list of files larger than 20M
for i in `find $BASE -maxdepth $DEPTH -type f -size +20M`
do 
	gzip $i || exit 1
	mv $i.gz $BASE/archive || exit 1
done
