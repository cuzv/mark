# How to setup VPN server (PPTP on CentOS, RedHat and Ubuntu)?

## Step 1. Install PPTPD

- If your OS is CentOS/RedHat 5:

```
yum install ppp
cd /usr/local/src
wget http://poptop.sourceforge.net/yum/stable/packages/pptpd-1.3.4-2.rhel5.x86_64.rpm
rpm -Uhv pptpd-1.3.4-2.rhel5.x86_64.rpm
```

- If your OS is CentOS/RedHat 6:

```
yum install ppp
cd /usr/local/src
wget http://poptop.sourceforge.net/yum/stable/packages/pptpd-1.3.4-2.el6.x86_64.rpm
rpm -Uhv pptpd-1.3.4-2.el6.x86_64.rpm
If you are using Ubuntu:
apt-get install pptpd
```

## Step 2. Edit IP setttings in /etc/pptpd.conf

```
vi /etc/pptpd.conf
localip 192.168.0.1
remoteip 192.168.0.101-200
```

## Step 3. Add user account in/etc/ppp/chap-secrets (assign username and password)

```
vi /etc/ppp/chap-secrets
usernameForuser1 *  setpassword1here  *
usernameForuser2 *  setpassword2here  *
```

## Step 4. Optional settings in /etc/ppp/options.pptpd

```
vi /etc/ppp/options.pptpd
ms-dns 8.8.8.8
ms-dns 4.4.4.4
```

## Step 5. Enable network forwarding in /etc/sysctl.conf

```
vi /etc/sysctl.conf
net.ipv4.ip_forward = 1
use the following command to apply the change:
sysctl -p
```

## Step 6. Configure firewall

```
iptables -A INPUT -i eth0 -p tcp --dport 1723 -j ACCEPT
iptables -A INPUT -i eth0 -p gre -j ACCEPT
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i ppp+ -o eth0 -j ACCEPT
iptables -A FORWARD -i eth0 -o ppp+ -j ACCEPT
service iptables save
service iptables restart
```
If you are using CSF firewall, you may refer to [this][configserver] post on firewall settings.

## Step 7. Start PPTP VPN server

- If your OS is CentOS or Redhat, using the following command:
`service pptpd restart`
To start PPTP Daemon automatically when rebooting next time, use command:
`chkconfig pptpd on`

- If your OS is Ubuntu, you just reboot your machine.

Now you can test the VPN server from any client: Windows PCs, Linux PCs, Android phones/tablets, or iPhone and iPad.
The log of the VPN server, by default, is combined with system log located at /var/log/messages.

***

[configserver]: http://forum.configserver.com/viewtopic.php?p=8449



## issue

### 解决Centos6系统下修改sysctl.conf报错

执行/sbin/sysctl -p老报错：
```
error: "net.bridge.bridge-nf-call-ip6tables" is an unknown key
error: "net.bridge.bridge-nf-call-iptables" is an unknown key
error: "net.bridge.bridge-nf-call-arptables" is an unknown key
error: permission denied on key 'net.ipv4.tcp_max_syn_backlog'
error: permission denied on key 'net.core.netdev_max_backlog'
error: permission denied on key 'net.core.wmem_default'
error: permission denied on key 'net.core.rmem_default'
error: permission denied on key 'net.core.rmem_max'
error: permission denied on key 'net.core.wmem_max'
error: permission denied on key 'net.ipv4.tcp_timestamps'
error: permission denied on key 'net.ipv4.tcp_synack_retries'
error: permission denied on key 'net.ipv4.tcp_syn_retries'
error: permission denied on key 'net.ipv4.tcp_tw_recycle'
error: permission denied on key 'net.ipv4.tcp_tw_reuse'
error: permission denied on key 'net.ipv4.tcp_mem'
error: permission denied on key 'net.ipv4.tcp_max_orphans'
error: permission denied on key 'net.ipv4.ip_local_port_range'
```

然后就去找资料解决，网络上说前三个错误执行：

```
modprobe bridge
lsmod|grep bridge
```

命令即可，但在执行第一个命令的时候又遇到新错误了~~~

`FATAL: Module bridge not found.`


**要进行修复操作**

- 修复modprobe

```
rm -f /sbin/modprobe
ln -s /bin/true /sbin/modprobe
```

- 修复sysctl

```
rm -f /sbin/sysctl
ln -s /bin/true /sbin/sysctl
```


# CentOS6.4下搭建PPTP VPN

1 背景

对于没有玩过博客的人来说，搭建自己的博客对我有着致命的诱惑，于是乎：

申请Linode VPS： Dallas机房，Plan512，CentOS6.2 32位，启动后，使用"yum update"命令，升级到最新的6.4 Final版本，英文版
申请GoDaddy域名： www.caike.me ，配置域名解析
为了验证VPN搭建方法，本地VMware vSphere下，新建了两个虚拟机：CentOS6.2 32位中文版和英文版，并 升级到最新的6.4 Final版本

2 搭建说明及知识普及
2.1 VPN 
虚拟专用网络（Virtual Private Network），指的是在公用网络上建立专用网络的技术。从某种意义上说，VPN服务器可以理解为网络代理，其可以帮助用户访问原本无法访问的资源，如PC_1可以利用Server_1的VPN访问到"PC_1不能访问而Server_1可以访问的资源"。常用于异地办公的场景下，企业工作人员在异地办公时，可以无障碍地访问企业内部网络和资源。在当前特殊的网络环境下，VPN可以很好地解决当前网络无法访问的资源的问题。

2.2 VPN技术
VPN当前主要有如下几种技术：

- PPTP：点对点隧道协议，是一种实现虚拟专用网络的方法。PPTP使用用于封装PPP数据包的TCP及GRE隧道控制通道。 
- L2TP：第二层隧道协议，是一种工业标准的Internet隧道协议，功能大致和PPTP协议类似。此协议基于微软的点对点隧道协议(PPTP)和思科2层转发协议(L2F)之上。
- OpenVPN：以路由器或桥接配置和远程访问设备方式实现虚拟专用网络（VPN）创建安全的点对点或站对站连接的解决方案。它使用SSL / TLS安全加密，具有穿越网络地址转换（NATs）和防火墙的功能。

详情请参考：http://www.cnblogs.com/hfww/archive/2011/09/30/2223343.html

本文介绍最简单易用的PPTP，客户端不需要特殊软件即可连接到VPN服务器。 

3 步骤
3.1 准备工作
1） 查看VPS是否支持，即检查TUN/TAP/PPP功能
`cat /dev/ppp`
返回：`No such device or addresss`  （中文版：没有那个设备或地址）

`cat /dev/net/tun`
返回：`File descriptor in bad state`  （中文版：文件描述符出于错误状态）

上述两条必须都满足才行，如果没有启用，可以给VPS提供商提交开通请求，一般VPS默认开启此功能

2） 查看系统是否已经编译MPPE

- MPPE协议是微软点对点加密术协议，其规定了如何在数据链路层对通信机密性保护的机制，通过对PPP链接中PPP分组的加密及PPP封装处理，实现数据链路层的机密性保护。

- pptp需要MPPE的支持，不安装的话，就不能使用加密连接。如果已经具备了MPPE的支持，则可以跳过此步，否则，需要编译内核或安装dkms软件包，该软件能让你在不编译内核的基础上，外挂一些内核的模块。

CentOS早期版本4.x或5.x，网上的教程均使用一个命令来测试是否已经支持MPPE

`modprobe ppp-compress-18 && echo ok`
返回"ok"表明系统已经支持MPPE，但是，linode下VPS的CentOS6.4 Final的系统中，该命令总是返回"Module ppp_mppe not found"。而在本地VMware vSphere下虚拟机CentOS6.4 Final的系统中，该命令返回"OK"。

而网上查找到另一条检测命令对我linode下的CentOS6.4是有效的，却对VMware vSphere下的CentOS6.4无效

`zgrep MPPE /proc/config.gz`
返回 "CONFIG_PPP_MPPE=y"，则可以安装PPTP了。

注：目前不确定是不是因为VPS架构的问题（linode下是XEN，本地的是vSphere），导致了分别只支持上述其中一条检测命令。我们可以武断地认为，判断系统支持MPPE，只要符合其中一条即可。

如果不符合，则需要安装dkms和kernel_ppp_mppe，这两个软件包并没有被包含在CentOS的默认数据源中。
```
yum install dkms
wget https://acelnmp.googlecode.com/files/kernel_ppp_mppe-1.0.2-3dkms.noarch.rpm  
rpm -ivh kernel_ppp_mppe-1.0.2-3dkms.noarch.rpm
```

上述是软件包的下载和安装命令，实际过程中，系统会提示安装wget,gcc,make,kernel-devel等支撑包，这些软件包用户使用yum进行安装即可。安装完成后，重启下你的系统。

注：请将文件下载到/home下的某个目录，否则最终在进行VPN连接时，可能出现问题，详情参考第5章

3） 查看系统的版本
`uname -a`

查看系统是32位还是64位，方便后续选择软件包

`cat /etc/centos-release`

查看CentOS的系统版本

3.2 安装软件包

1. 安装ppp,pptp和iptables 

pptp需要iptables的支持，需要iptables对其ip数据包进行转发。
`yum install -y ppp pptp iptables`

2. 安装pptpd
```
wget http://li.nux.ro/download/nux/misc/el6/i386/pptpd-1.3.4-1.el6.nux.i686.rpm
rpm -ivh pptpd-1.3.4-1.el6.nux.i686.rpm
```

上述命令执行过程中，可能会提示安装perl，使用yum命令进行安装即可。

3.3 配置

1. 配置/etc/pptpd.conf

vi /etc/pptpd.conf
在该文件的最后几行中，将

```
#localip 192.168.0.1 
#remoteip 192.168.0.234-238,192.168.0.245
```

中的"#"注释符去除，修改为

```
localip 192.168.0.1 
remoteip 192.168.0.234-238,192.168.0.245
```

注意：此处的remoteip指定的IP范围是用来给远程连接使用的。如果您远程访问VPN，VPN就会在remoteip范围内分配一个ip地址给你。
localip的值直接影响到后面要说的iptables转发规则的编写，所以建议不要随意改动。

2.  编辑/etc/ppp/options.pptpd

`vi /etc/ppp/options.pptpd`

找到被注释掉的DNS配置

```
#ms-dns 10.0.0.1 
#ms-dns 10.0.0.2
```

去掉注释符"#"，修改DNS

```
ms-dns 8.8.8.8 
ms-dns 8.8.4.4
```

注意：此处的DNS修改成了Google的DNS，用户也可以将其修改为VPS服务提供商提供的DNS

3） 设置pptp的用户名和密码

`vi /etc/ppp/chap-secrets`
会显示如下的内容
```
# Secrets for authentication using CHAP 
# client        server  secret                  IP addresses
```
添加一条记录，该记录表示允许拥有secret的client在server上使用ipaddress，修改后如下：

```
# Secrets for authentication using CHAP 
# client        server  secret                  IP addresses
    test         pptpd    test                             *
```

其中，client和secret为用户连接VPN服务器时使用的"用户名"和"密码"。

4. 修改内核设置，使其支持转发

`vi /etc/sysctl.conf`

找到如下高亮显示的两行代码

```
net.ipv4.ip_forward=0
...
net.ipv4.tcp_syncookies=1
```

将其中一行的值进行修改，另一行进行注释  

```
net.ipv4.ip_forward=1
...
#net.ipv4.tcp_syncookies=1
```

修改完内核设置后，需要执行以下命令使修改后的内核生效

`sysctl -p`

5. 添加iptables转发规则

`iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o eth0 -j MASQUERADE`
注：该命令适用于XEN架构的VPS，而Linode采用的是XEN架构，故此适用。而如果VPS是采用OpenVZ架构，那么可能需要使用如下的命令

`iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -j SNAT --to-source 12.34.56.78`
其中"12.34.56.78"是该VPS的公网的IP。

3.4 重启

1. 设置pptp和iptables随系统启动

```
chkconfig pptpd on 
chkconfig iptables on
```

2. 保存并重启iptables服务

```
/etc/init.d/iptables save 
/etc/init.d/iptables restart
```

注：执行第二条语句时，系统可能会出现如下错误提示，详情见第5章。

3. 重启pptp服务

`/etc/init.d/pptpd restart`
注：执行该语句，系统可能会出现错误提示，详情见第5章。

4 客户端设置（Windows XP）

- 右击"网络邻居"，选择"属性"
- 点击"创建一个新的连接"，并选择"下一步"
- 选择"连接到我的工作场所的网络"，点击"下一步"
- 选择"虚拟专用网络连接"，点击"下一步"
- “公司名"中任选一个名字输入，点击"下一步"，该名字只是用来标识连接，最后桌面上出现的图标以该名字命名
- “主机名"中输入VPN服务器的IP地址或域名，点击"下一步"
- 勾选"在我的桌面上….."，点击"完成"
- 桌面上，双击新出现的图标，输入VPN连接的用户名和密码（如上例中的"test"和"test"）进行VPN连接

注：连接中可能会出现错误，详情见第五章

5 出现的问题

5.1 重启pptp服务时，错误
`Shutting down pptp [FAILED]`
可以忽略该问题，由于之前pptp并没有启动，故使用restart进行重启时，会出现关闭错误的提示，如果直接使用start就不会有错误提示。

5.2 重启iptables时，错误
`Iptables error – Setting chains to policy ACCEPT: security raw nat mangle filter [FAILED]`
需要通过编辑iptables的文件进行处理

`vi /etc/init.d/iptables`

```
echo -n $”${IPTABLES}: Setting chains to policy $policy: “
ret=0
for i in $tables; do
echo -n “$i “
case “$i” in
+ security)
+ $IPTABLES -t filter -P INPUT $policy \
+ &amp;&amp; $IPTABLES -t filter -P OUTPUT $policy \
+ &amp;&amp; $IPTABLES -t filter -P FORWARD $policy \
+ || let ret+=1
+ ;;
raw)
$IPTABLES -t raw -P PREROUTING $policy \
&amp;&amp; $IPTABLES -t raw -P OUTPUT $policy \
|| let ret+=1
;;
```

注意，带+号的行是后添加的。

修改后重新启动ipstables服务即可。

5.3 客户端连接VPN时，提示800错误

800错误：不能建立VPN连接，VPN服务器可能不能到达，或者此连接的安全参数没有正确配置。

可能有两个原因：1）VPN服务器防火墙未设置准确， 2）安装rpm安装程序时，安装目录没有权限。
那么分别对这两种原因进行排除和分析

1. 防火墙的问题，可以通过关闭VPN服务器的防火墙进行验证

`service iptables stop`

防火墙关闭后，如果错误800不再出现，那么可以认为是防火墙的问题。防火墙的问题，可能是由于端口IP协议47（GRE）引起的，为彻底解决该问题，可以将如下脚本保存在临时文件iptables.sh中

```
echo 1 > /proc/sys/net/ipv4/ip_forward
/etc/init.d/iptables stop 
/sbin/iptables -A INPUT -p icmp -j DROP 
/sbin/iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -j MASQUERADE 
/sbin/iptables -F FORWARD 
/sbin/iptables -P FORWARD ACCEPT 
/sbin/iptables -t nat -A POSTROUTING -j MASQUERADE 
/sbin/iptables -F FORWARD 
/sbin/iptables -A FORWARD -p udp -s 192.168.0.0/24 --dport 47 -j ACCEPT 
/sbin/iptables -A FORWARD -p tcp -s 192.168.0.0/24 --dport 1723 -j ACCEPT 
/sbin/iptables -A FORWARD -p gre -s 192.168.0.0/24 -j ACCEPT 
/sbin/iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
/etc/init.d/iptables save
/etc/init.d/iptables start
/etc/init.d/pptpd restart
```

然后，修改iptables.sh的可执行权限，并运行它

```
chmod 777 iptables.sh
./iptables.sh
rm -f iptables.sh
```

注意：上述的"192.168.0.0"均是根据"/etc/pptpd.conf"中的localip设定的。

2. 对于第二种问题，我们可以通过查看pptp的日志（pptp的日志随系统日志一起，在/var/log/messages）
`vi /var/log/messages`

从文本最后往前翻，发现如下语句
`Warning: can't open options file /root/.ppprc: Permission denied`
经过验证，发现我们按照下载pptpd时，是直接下载在/root目录并安装的。假设如果是在/home目录下安装

```
mkdir /home/software
cp /root/pptp-release-current.noarch.rpm /home/software/pptp-release-current.noarch.rpm
cd /home/software
rpm -ivh pptp-release-current.noarch.rpm --replacepkg
yum reinstall pptp-release-current.noarch.rpm
service pptpd restart
```

重新连接，看是否解决。

5.4 客户端连接VPN时，提示619错误
网上多方查找，给出的解决方案为

```
rm /dev/ppp
mknod /dev/ppp c 108 0
```

尝试后，仍不能解决。后通过查看日志

`vi /var/log/messages`
从文本最后往前翻，发现如下语句

```
Plugin /usr/lib/pptpd/pptpd-logwtmp.so is for pppd version 2.4.3, this is 2.4.5
GRE: read(fd=6,buffer=8059660,len=8196) from PTY failed: status = -1 error = Input/output error, usually caused by unexpected termination of pppd, check option syntax and pppd logs
```

从日志可以看出，我们按照的ppp的版本高于pptp的版本太多了，使得pptp中的组件无法支持ppp，故解决方案有两个：1）升级pptp，2）按照2.4.3版本的ppp。降低ppp的版本不太可取，在后续的系统升级过程中，必然会带来问题。最后从网上找到如下的pptp的软件包

```
wget http://poptop.sourceforge.net/yum/stable/pptp-release-current.noarch.rpm
rpm -ivh pptp-release-current.noarch.rpm
yum update
```

安装该软件包后，重启pptp服务，客户端连接VPN服务器正常了。

6 总结
在linux下进行软件的配置，对于高手而言，可能极为轻松。但对菜鸟而言，则痛苦不堪，期间会遇到各种各样的问题。本文在三个环境中进行配置，每次均遇到了不同的问题，虽然在我们不懈地Google和Baidu之后，还是可以找到解决方案的，但其过程，不堪回首。当前网上众多的pptp VPN的配置，大多是基于CentOS 4.x和5.x，其遇到的问题往往和我们不同，此篇就是为CentOS6.4的用户准备的，望对大家有所帮助。

 

作者：菜鸟时刻 （hwins）
地址：http://www.caike.me/2013/03/centos-pptp-vpn/- 