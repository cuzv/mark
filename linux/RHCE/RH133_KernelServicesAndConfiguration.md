## Kernel Modules  
`/lib/modules`  
- `lsmod`  
- `modprobe mod-name`  

## Kernel Modules Configuration  
- `/sbin/modinfo mod-name`  
- `/etc/modprobe.conf`  
- `/lib/modules/$(uname -r)/modules.dep`  
- `depmod -a`  
- `insmod mod-name
- `rmmod mod-name`  `  

## The /proc filesystem  
/proc is a virtual filesystem  
- `cat /proc/cpuinfo`  
/proc subdirectories   
- `/proc/scsi/`  
- `/proc/sys/`  
- `/proc/<PID>/`  

## /proc/sys configuration with sysctl  
- `/etc/sysctl.conf`  

## Genernal Hardware Resources  
`kudzu`  
- `/etc/sysconfig/hwconf`  
- `/usr/share/hwdata/`  
- `/proc filesystem`  
- `hwbrowser`  

## System Bus Support  
`PCI Bus`  
- `/sbin/lspci`  
- `/proc/bus/pci`  
`ISA Bus`  
- `/proc/isapnp`  

## Hostwappable Bus Support  
`USB and IEEE 1934 Buses`  
- `/sbin/hotplug,(/etc/hotplug)`  
- `/proc/bus`  
- `/sbin/lsusb`  
- `/dev/usb`  
PCMCIA Bus
- `/sbin/cardmgr,(/etc/pcmcia)`  
- `/proc/bus/pccard`  
- `/sbin/cardctl utility`  

## System Monitoring and Process Control  
- `top,gnome-system-monitor`  
- `vmstat`  
- `free`  
- `nice -n <priority> <app>`  
- `renice <priority> <PID>`  
- `kill`  
- `kill -l`  
- `kill -9 <PID>`  
