## Service Management  
1. init  
	- `/etc/inittab`  
2. system v script  
	- `/etc/init.d/httpd start`  
3. direct command  
4. xinetd  
	- telnet  

## System V service manage  
- `/etc/init.d/httpd start`  
- `service httpd start`  

- `chkconfig telnet --list`  
- `service xinetd restart`  

## The /etc/sysconfig/ files  
- named  
- sendmail  
- dhcpd  
- asmba  
- init  
- syslog  

## SELinux  
- `sestatus`  

- `setenforce=0`  
- `service httpd restart`  
- `setenforce=1`  

setsebool
