查看网卡线缆状态：  
`mii-tool eth0`  

查看网卡底层信息：  
- `ethtool eth0`  
- `ethtool -i eth0`   查看网卡驱动信息  
- `ethtool -S eth0`   查看网卡状态统计信息  

Linux下可以通过IP别名（子接口）功能为一个物理网卡添加多个IP地址  

要使用IP别名（子接口）需要关闭NetworkManager服务：  
- `service NetworkManager stop`  
- `chkconfig NetworkManager off`  

使用ip命令为一个接口添加别名：  
`ip addr add 192.168.2.1/24 dev eth0 label eth0:0`  

永久添加别名，需要在/etc/sysconfig/network-scripts/中添加配置文件：  

文件名：  
`ifcfg-eth0:0`  

内容： 
``` 
DEVICE=eth0  
IPADDR=192.168.2.1  
PREFIX=24  
ONPARENT=yes  
``` 
Linux下可以通过多网卡绑定来提升网卡的稳定性及速度，多网卡缁????通过将多个物理网卡绑定为一个逻辑网卡的形式创建  

Linux支持的网卡绑定模式： 
- 模式0   平衡轮训（RR）  
- 模式1   主动备份  
- 模式3   广播  
