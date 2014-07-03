##### standard input and output
- `ls -l /dev/std*`    
- `find /etc -name passwd`    

##### redirecting output displayed on the terminal
##### redirecting input and output
- `>`    
- `>>`    
- `<`    
- `cal > cal.1`    
- `cat cal.1`    
- `cal >> cal.2`    
- `cat cal.2`    

##### overwriting or appending
##### redirecting standard output
##### redirecting standdard error
##### redirecting both standard output and error
- `su - user1`    
- `find /etc/ -name passwd 2> errs 1> output`    
- `cat errs`    
- `find /etc -name passwd > alloutput 2>&1`    
- `cat alloutput`    
- `find /etc -name pwsswd &> alloutput`    
- `cat alloutput`    
##### redirectin input  
- `.<` 		-input  
- `tr 'A-Z' 'a-z' < .bash_profile`    

##### cut  
- `cut -f4 result.dat`    

##### sort  
- `man sort`    
- `sort -fuf test`    

##### using pipes to connect processes  
##### using pipes for mail
- `mail -s "lst mail" mskv`    
- `cat /var/spool/mail/mskv`    
- `ls -l | mail -s "send mail to mango" mango`    

##### tee



































