## Troubleshooting  
## Things to Check:X  
## Things to Check:Networking  
## Order of the Boot Process  
## Filesystem Corruption  
## Recovery Run-levels  
## Rescue Mode  
`dd if=/dev/zero of=/dev/sda bs=446 count=1` #ÆÆ»µmbr  
¹âÅÌ¿ª»ú  
input:`linux rescue`   
`grub-install /dev/sda`  
`chroot /mnt/sysimage/`  
`grub-install /dev/sda`  
`exit`  
