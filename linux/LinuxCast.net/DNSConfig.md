`yum install bind bind-chroot bind -utils`  

BIND（Berkeley Internet Named Deamon）是现今使用最为广泛的DNS服务程序

BIND默认使用TCP、UDP协议，使用端口 53（DNS）、953（rndc）

BIND配置文件保存在：

*`/etc/named.conf `*   主配置文件

*`/var/named/`*         域zone文件位置

如果使用了chroot，则配置文件位置为：

*`/var/named/chroot/etc/named.conf`*  

*`/var/named/chroot/var/named`*

bind配置文件示例保存在：

*`/usr/share/doc/bind-9.8.2/sample/`*

需要执行下面两步:

`cp -r /usr/share/doc/bind-9.8.2/sample/etc/* /var/named/chroot/etc/`  

`cp -r /usr/share/doc/bind-9.8.2/sample/var/* /var/named/chroot/var/`  



以下命令用以检查bind配置文件及zone文件语法：

*`named-checkconf /var/named/chroot/etc/named.conf`*

*`named-checkzone mskevn.com /var/named/chroot/var/named/mskven.com.zome`*  


## DEMO  
1. vim /var/named/chroot/etc/named.conf   add this zone define   
	`zone "mskven.com"`  
`{`  
    `type master;`  
    `file "mskven.com.zone";`  
`};`  


2. on /var/named/chroot/var/named	 carete zone file  
```
	cp /var/named/chroot/var/named/named.localhost /var/named/chroot/var/named/mskven.com.zone  
```

3. edit zone file, add needed infomations  
	`vim /var/named/chroot/var/named/mskven.com.zone  `  
```
    	    IN  mx  10  mail.mskven.com.
	append
	www     IN  A   192.168.1.100
	mail    IN  A   192.168.1.200
```

4. start bind service   
```
	setenforce 0
	service named start  
	service named reload  
```
5. use 'host' or 'dig' command test info is right?  
```
	vim /etc/resolv.conf
	nameserver 127.0.0.1
```
```
	dig www.mskven.com
	dig -t mx mskven.com
```
