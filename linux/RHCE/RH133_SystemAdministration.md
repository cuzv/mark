Blick Devices  
- `/dev/hda` 		IDE drives   
- `/dev/hdb` 		SCSI drives   
- `/dev/fd0` 		standard floppy drives  

Character Devices  
- `/dev/tty[0-6]` 	virtual consoles   
- `/dev/st0` 		SCSI tape drive   

Symbolic links  
- `ls -l /usr | grep ^l | less`  

Sample Partition Sturcture  
MBR:  boot loader(446) partition table(64) magic(2)  
dos
 |  
swap
 |  
/boot  
 |  
Extended partition table  
|  
/root  
|  
/var  
|  
/tmp  
|  
/home  

- `RAID 0`  N
- `RAID 1`	N/2   
- `RAID 5`	N-1  
