#!/bin/bash

d=`date +%F` # today
dow=`date +%u` # day of week as number (i.e. Monday = 1, Tuesday = 2 etc.)
dd=`date -d "-15 days" +%F` # files olther than 14 days
ddw=`date -d "-22 weeks" +%F` # files created 22 weeks ago

# Server 1
rsync -az --delete -e "ssh -p 1234" login@server.tld:/home /data/server-1/files/ # rsync files
tar -zcvf /data/server-1/backup-$d.tar.gz /data/server-1/files/ # tar.gz
/usr/local/bin/uplink cp /data/server-1/backup-$d.tar.gz sj://server-1 # send to storj
if [ $dow == '5' ] # if today is Friday
then
/usr/local/bin/uplink rm sj://server-1/backup-$ddw.tar.gz # delete file created 22 weeks ago from storj
else # if is not Friday
/usr/local/bin/uplink rm sj://server-1/backup-$dd.tar.gz # delete file created 15 days ago from storj
fi
rm /data/server-1/backup-$d.tar.gz # delete local tar.gz

# Server 2 etc.
