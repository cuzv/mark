**Postfix是Linux下最为流行的邮件服务器，Postfix是MTA的一种实现，最初的开发目的是为了改良sendmail，现在逐渐成为的Linux下的主流的邮件服务器**  

postfix的优势有：  
- postfix速度比sendmail快三倍  
- 兼容sendmail  
- 更加稳定健壮  
- 配置更加简单灵活  
- 大多数postfix进程运行权限较低，所以安全性较高  

Linux系统一般会默认安装postfix服务，并且作为系统内用户之间使用的通信方式

postfix配置文件为：
`/etc/postfix/main.cf`  

一般我们不直接修改postfix配置文件，而是通过postconf命令进行配置：
`postconf -d    显示缺省配置 `  
`postconf -n    显示当前配置`  
`postconf -e  配置选项=配置参数   修改一个配置`  

常用配置参数：  
`postconf -e "inet_interfaces=all"     配置postfix监听所有接口`  
`postconf -e "myhostname=training.linuxcast.net"    配置本机主机名`  
`postconf -e "mydomain=linuxcast.net"    配置postfix所服务的域的域名`  
`postconf -e "mydestnation=$myhostname,$mydomain"   配置postfix允许接收的邮件的目标地址`  
`postconf -e "myorigin=$mydomain"    配置地址伪装（将发出邮件的发件人伪装为用户名@域名的形式）`  
`postconf -e "masquerade_exceptions=root"  配置哪些用户不进行地址伪装`  
`postconf -e "mynetworks=127.0.0.0/8"    配置那些网络地址可以不进行认证就可转发邮件`  

查看当前邮件发送队列：
`postqueue -p`  

刷新当前邮件发送队列：
`postqueue -f`  

邮件服务默认日志为：
`/var/log/maillog`  
