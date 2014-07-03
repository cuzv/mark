***Partition Table Information***  
- partition id  
- starting cylinder for partition  
- number of cylinders for partition  

## fdisk  
- `fdisk -l /dev/sda`  
- `fisk /dev/sda`  
- `partprobe`  
- `mke2fs /dev/sdaX`  
- `dumpe2fs /dev/sdaX | less`  

## e2label  
- `e2albel /dev/sdaX data`  
- `e2label /dev/sdaX`  

## Mount  
- `mkdir /data`  
- `mount /dev/sdaX /data`  
- `mount`  
- `df -h`  
- `umount /data`  
- `e2label /dev/sdaX`  
- `mount -L /data /data`  L label  
- `df -h`  

## Mount Options  
mount [-t vfstype] [-o options] device mount_point  
\-t vfstype(vfat,ext2,ext3,iso9660,etc.)  
\-o options  
	suid  
	dev  
	exec  
	auto  
	nouser  
	async  
	loop  
	ro  
	rw  

## Umount Filesystem  
- `mount`  
- `umount /data`  
- `mount`  
- `umount /dev/sdaX`  

- `fuser -v /data`  
- `fuser -km /data`  
- `umount /data`  

- `mount -o remount,ro /data`  

## Mount Example  
- `mount /dev/sdaX /data`  
- `cp -a /usr/bin /data`  
- `cd /data/bin`  
- `./whami`  
- `mount -o noexec /dev/sdaX /data`  
- `ca /data/bin`  
- `./whami`  

- `midir /iso`  
- `mount -t iso9660 -o ro,loop boot.iso /iso`  

## Connecting Network Resources  
- `showmount -e 192.168.1.100`  
- `mkdir /mnt/nfs`  
- `mount 192.168.1.100:/var/ftp /mnt/nfs`  

- `smbclient -L 192.168.1.100 -N`  
- `mkdir /mnt/smb`  
- `mount //192.168.1.100/mskv /mnt/smb -o username=mskv%chinou`  

## Managing Data:/etc/fatab  
- `less /etc/fstab`  
format:`device	mount_point	FS_type	options	dump_freq fsck_order`  
dump_freq:  
    0:never
    2:daily  
    1:every other day,etc  
fsck_order:  
    0:ignore  
    1:first  
    2:second  
	...  
- `cp /etc/fstab /etc/fstab.bak`  
- `vim /etc/fstab`  
- `reboot`  

- `vim /etc/auto.master`  

- `lsattr`  
- `lsattr doc/`  

- `man chattr`  
- `echo "1 2 3 " > test`  
- `lsattr test`  
- `chattr +a test`  
- `echo "abc" > test`  
- `echo "abcd" >> test`  
- `chattr -a test`  
- `lsattr test`  

- `chattr =aAS test`  
- `chattr = test`  

## Virtual Memory  
SWAP:partion,file  
### Basic setup involves:  
1. crate swap partion  
`fdisk /dev/sda `  
`n`  
`enter`  
`+100M`  
`m`  
`t`  
`lastnumber`  
`L`  
`82`  
`p`  
`w`  
`partprobe`  

2. write special signature using mkswap  
`mkswap /dev/sdaX`  

3. add appropriate entries /etc/fstab  
`vim /etc/fatab`  
   `/dev/sdaX	swap	swap	defaults	0 0`  

4. active swap space with swapon -a
`swapon -s`  
`swapon -a`  
`swapon -s`  

check the swap partition status using swapon -s  

### using file for swap    
- `dd if=/dev/zero of=/swapfile bs=1M count=100`  
- `ls -lh /swapfile`  
- `mkswap /swapfile`  
- `vim /etc/fstab as up exapmle`  
- `swapon -s`  
- `swapon -a`  
- `swapon -s`  


- `umount /data`  
- `fsck -y /dev/sdaX`  
- `tune2fs -j /dev/sdaX`  
- `umount /data`  
- `mount /dev/sdaX /data`  
- `df -h`  
- `dumpe2fs -h /dev/sdaX`  

## Adding Drive  
