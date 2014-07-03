- `cd vim /etc/sysconfig/network-scripts/`  
`ifcfg-ethX:N`  
- `vim ifcfg-eth0`  
- `vim ifcfg-eth0:0` binding more than one ip   

ifcfg-ethX-rangeX  
- `DEVICE=eth0-range0`  
- `IPADDR_START=192.168.1.100`  
- `IPADDR_END=192.168.1.104`  

global default define in:  
- `/etc/sysconfig/network`  

- `cd /etc/sysconfig/network-script/`  
- `route -n`  
vim route-eth0
    `10.0.0.0/24 via 192.168.1.144`  
    `10.0.1.0/24 via 192.168.1.144`  
    `10.0.2.0/24 via 192.168.1.144`  

- `/etc/resolv.conf`  
