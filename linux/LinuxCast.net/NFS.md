NFS(Network File System）是Linux、类Unix系统之间共享文件最常用的协议  

不同于FTP、HTTP等方式，NFS是直接共享文件系统，所以不需要预先下载，而是可以直接使用共享文件  

NFS主流使用三个版本：NFSv2、NFSv3、NFSv4  

CentOS 6/RHEL 6默认支持所有三个版本  

NFS服务默认需要使用RPC服务，所以使用NFS服务必须保证系统rpc服务打开：  
```
sudo service rpcbind start
sudo chkconfig rpcbind on

sudo service nfs start
sudo chkconfig nfs on
```

NFSv4不再需要RPC支持，并且是防火墙友好的  

默认NFS占用5个端口，1个NFS端口（2049），四个动态端口，我们可以通过NFS配置文件固定这些动态端口，以在有防火墙的环境下使用：  

配置文件：

`/etc/sysconfig/nfs`

配置：
```
mountd_port = "4001"     挂载使用端口

statd_port = "4002"        共享状态使用端口

lockd_tcpport= "4003"     TCP锁端口

lockd_udpport= "4004"     UDP锁端口
```

NFS共享配置文件为：

`/etc/exports`

共享配置格式为：  

共享路径     客户端列表（NFS共享参数）  

`/linuxcast-nfs     192.168.1.0/24(rw,sync)`

命令exportfs可以刷新或显示共享信息：  

`exportfs -r    刷新共享配置`

`exportfs -v   显示当前共享配置`

默认NFS共享参数：
```
ro							只读共享

sync						所有共享操作返回前已经写入磁盘

wdelay						延迟写操作，等待更多写操作一起执行

root_squash					防止root用户远程使用root权限对共享进行访问

常用选项：
rw							读写共享

async						操作可以延迟写入磁盘，立即响应，可以提高速度

no_wdelay					关闭写延迟，与async同时使用

no_root_squash				关闭root_squash
```



## DEMO
*本机I(NFS server)P:192.168.1.100*  
1. `vim /etc/sysconfig/nfs` 配置端口，默认不用配置    
2. `vim /etc/exports`   
	`/NFS	192.168.1.0/24`  
3. `service nfs start` or `exportfs -r`  
4. `exportfs -v`  
5. `sudo mkdir /mnt/NFS`  
6. `mount -t nfs 192.168.1.100:/NFS /mnt/NFS`  
  
TIPS:  
- PRC服务需要开  
- setenforce 0 关闭selinux  
- 启动时候自动挂载:echo " 192.168.1.100:/NFS	 /mnt/NFS	 nfs	defaults 0 0" >> /etc/fstab  









