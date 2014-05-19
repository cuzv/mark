# lamp install (centos)

## 第一步：更新系统内核（如果不想更新可以跳过本步）。

首先更新系统内核到最新，因为最新版的CentOS 6.3的php版本为 5.3，早起版本的CentOS的php版本也比较低。

执行命令：

`yum -y update`

**注意：如果执行失败报错，可以执行修复命令：**

`rpm –import /etc/pki/rpm-gpg/RPM-GPG-KEY*`

## 第二步： 安装Apahce、Mysql、PHP 及其基础扩展。

执行命令：

`yum -y install httpd php php-mysql mysql mysql-server`

## 第三步：安装PHP的其他常用扩展

执行命名：

`yum -y install php-gd php-xml php-mbstring php-ldap php-pear php-xmlrpc`

## 第四步：安装Apache的扩展

执行命令：

`yum -y install httpd-manual mod_ssl mod_perl mod_auth_mysql`

执行完这四步软件就安装完成了，接下来要做一些常规的设置。

## 第五步：设置apache/mysql-server环境开机自动启动

执行命令：

- 设置apache为开机自启动
`/sbin/chkconfig httpd on`

- 添加mysql服务
`/sbin/chkconfig --add mysqld`

- 设置mysql为开机自启动
`/sbin/chkconfig mysqld on`

## 第六步：启动apache与msyql

分别执行命令：

`service httpd start`
`service mysqld start`

## 第七步：设置mysql数据库root帐号密码
`mysqladmin -u root password 'mysql的管理员密码’`

## 第八步：安装phpmyadmin

从phpmyadmin官方网站:http://www.phpmyadmin.net/home_page/downloads.php下载最新的phpmyadmin安装包，
下载到网站目录下默认在/var/www/html/下。解压phpmyadmin压缩包后，找到 config.sample.inc.php 重命名为 config.inc.php，
修改配置，就安装完成了。

* * *

# CentOS yum安装mcrypt详细图解教程

## 第一步：在扩展库中查找rpm包

打开网址： `http://mirrors.sohu.com/fedora-epel/6/i386/` 使用 Ctrl+F 搜索关键词“epel-release” 
找到当前最新的扩展包发现最新版本为：`epel-release-6-7.noarch.rpm`

`[root@ptr228 ~]# rpm -ivh http://mirrors.sohu.com/fedora-epel/6/i386/epel-release-6-7.noarch.rpm`

## 第二步：执行命令：yum update 更行系统 

`[root@ptr228 ~]# yum update`

## 第三步：执行命令 yum repolist 查看安装结果

`[root@ptr228 ~]# yum repolist`

 如果发现了epel 说明已经安装成功，可以继续执行了。

## 第四步：执行命令： yum install php-mcrypt 安装mcrypt扩展包

`[root@ptr228 ~]# yum install php-mcrypt`

## 第五步：重启apache是扩展生效

`[root@ptr228 ~]# service httpd restart`