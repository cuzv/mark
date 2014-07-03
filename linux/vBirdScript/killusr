#!/bin/sh
#the script to kill logined user

username="$1"

/bin/ps aux | /bin/grep $username | /bin/awk '{ print $2 }' > /tmp/killusr.pid

killpid=`cat /tmp/killusr.pid`

for PID in $killpid
do
	/bin/kill -9 $PID 2 > /dev/null
done
