SMB（Server Message Block）是windows系统共享文件主要使用的协议

在Linux系统或类Unix系统中，我们可以使用samba程序实现SMB协议，为windows设备提供共享服务

samba服务是SMB协议的一个开源实现，具有以下主要功能：

**通过SMB协议进行文件共享**  

**通过SMB协议进行打印共享**  

**加入一个windows 2000/2003/2008域环境**  

**通过windows 域环境进行认证**  

SMB协议又称之为CIFS（Comman Internet File System）协议

samba包含三个服务：

**smbd**

**nmbd**

**winbindd**

一般文件共享只使用到smbd服务

samba配置文件保存在：

`/etc/samba/smb.conf`

配置文件分为三个部分：

**[global]     samba全局配置**

**[homes]    用户家目录共享**

**[printers]   打印共享**

samba有两种安全模式：

**user-level   任何共享都需要一个用户名、密码进行认证**

**share-level  只需要密码（或者匿名）就可以访问共享，但与一些windows客户端有兼容性问题**

samba使用系统用户，但是使用独立密码，所以任何需要使用samba服务的用户都需要单独创建samba密码：

`smbpasswd -a mskv`


setenforce 0 关闭selinux
通过以下配置可创建一个独立samba共享：

**[smb-share]**  
**comment = This is a LinuxCast.net samba share**  
**path = /smb-share           			共享路径**  
**valid users = mskv 					可用用户**  
**public = no                           是否为开放共享**  
**browsable = yes                     	是否可浏览**  
**writable = yes                        是否可写**  
**create mask = 0765                    默认创建文件权限**  

**命令testparm可用来检测samba配置文件语法**  
**命令smbclient可以用来访问一个SMB共享：**  
**smbclient //192.168.1.100/smb-share -U mskv**  
**smbclient -L 192.168.1.100**  

## DEMO
```
- yum install -y samba  
- Optional: yum install -y samba-winbind   
- vim /etc/samba/smb.conf  
	workgroup = MYGROUP  
	server string = smb share  
- smbpasswd -a mskv   
- service smb start  
- iptables -L  
- setenforce 0  
- smbclient //192.168.1.100/mskv -U mskv    //默认共享的是用户家目录
- or mount -t clfs //192.168.1.100/SMB /mnt/SMB -o username=mskv password='chinou'    
```
or vim /etc/samba/smb.conf 
```
[SMB]
comment = this is mskv SMB share test
path = /SMB
valid users = mskv
public = no
browsable = yes
writable = yes
create mask = 0765
```
then :
`smbclient //192.168.1.100/SMB -U **mskv**   `  
`mount -B /SMB /mnt/SMB `  
