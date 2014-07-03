IP地址，因为IP地址难于记忆，所以一般使用域名代替

一个域名代表一个IP地址

DNS（Domain Name System）服务负责域名与IP地址之间的转换

Linux下域名解析可以通过以下几种方式：

文件（/etc/hosts、/etc/networks）

DNS

NIS

可以通过配置文件/etc/nsswitch.conf控制查询顺序

DNS是一个树状结构，每一级由一个或多个服务器负责提供信息

DNS查询分为两种类型：

iterative   迭代查询

recursive  递归查询

实际使用中，一般使用迭代+递归方式进行查询

在DNS服务器上，信息以资源记录（resource record）格式保存

一条资源记录（resource record）保存一个信息，常见的资源记录类型有：

A        IPv4地址

AAAA   IPv6地址

MX      邮件记录

CNAME 别名 

PTR     指针（用于逆向解析）

SRV     服务资源

DNS服务器一般分为三种类型：

域主DNS服务器（master）

域从DNS服务器（slave）

缓存DNS服务器（Caching）

DNS服务器中，一个域的信息保存在该域的zone配置文件中
