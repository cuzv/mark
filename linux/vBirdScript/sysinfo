#!/bin/sh
#auto send mail for system info

/bin/date +%F >> /tmp/sysinfo
echo "disk info:" >> /tmp/info
/bin/df -h >> /tmp/sysinfo
echo >> /tmp/sysinfo
echo "online users:" >> /tmp/sysinfo
/usr/bin/who | /bin/grep -v root >> /tmp/sysinfo
echo >> /tmp/sysinfo
echo "memory info:" >> /tmp/sysinfo
/usr/bin/free -m >> /tmp/sysinfo
echo >> /tmp/sysinfo

#write root
/usr/bin/write root < /tmp/sysinfo && /bin/rm /tmp/sysinfo

#crontab -e
#0 9 * * 1-5 script