IP地址的虚拟主机

SSL网站只能使用基于IP的虚拟主机

apache虚拟主机配置如下：
vim /etc/httpd/conf/httpd.conf
```
NameVirtualHost *:80  
<VirtualHost *:80>

     ServerName www1.linuxcast.net

     ServerAdmin root@linuxcast.net

     DocumentRoot /var/www/linuxcast-1

</VirtualHost>

<VirtualHost *:80>

     ServerName www2.linuxcast.net

     ServerAdmin root@linuxcast.net

     DocumentRoot /var/www/linuxcast-2

</VirtualHost> 
```
**确保apache用户对网页根目录具有访问权限**
