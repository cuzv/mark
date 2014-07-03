## Software RAID Configuration  
RAID 0 N  
RAID 1 N/2  
RAID 5 N-1  

## Software RAID Recovery  
- `man mdadm`  
- `mdadm /dev/md0 -s /dev/sdb2`  

## Converting LVM1 to LVM2  
## Creating Logical Volumes  
## Resizing Logical Volumes  
## The Linux Quota System  
- `su root`  
- `vim /etc/fstabvim /etc/fstab`  
   `/dev/sda3 /home ext3 defaults,usrpuota 1 2`  
- `mount -o remount /home`  
- `quotacheck -c /home`  
- `ls -l /home`  
- `quotaon /home`  
- `su - mskv`  
- `ls -l`  
- `dd if=/dev/zero of=big bs=1M count=6`  
- `ls -lh`  
- `exit`  
- `edquota mskv`  
- `quota`  
- `ls -lh`  
- `dd if=/dev/zero of=big1 bs=1M count=3`  
- `ls -lh`  
- `dd if=/dev/zero of=big2 bs=1M count=3`  
- `ls -lh`  
- `useradd user2`  
- `edquota -p mskv user2`  
- `requota -a`  
