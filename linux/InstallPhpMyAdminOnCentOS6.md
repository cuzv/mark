How to install phpmyadmin on centos 6
===

[check source](http://www.krizna.com/centos/)

Before you install phpMyAdmin confirm you got following things done:

1. [Apache2 installation an configuration][1]
2. [Mysql installation][2]
3. [PHP installation][3]
4. [Testing all together][4]

[1](http://www.krizna.com/centos/installing-apache2-mysql-server-php-centos-6-lamp/#apache)
[2](http://www.krizna.com/centos/installing-apache2-mysql-server-php-centos-6-lamp/#mysql)
[3](http://www.krizna.com/centos/installing-apache2-mysql-server-php-centos-6-lamp/#php)
[4](http://www.krizna.com/centos/installing-apache2-mysql-server-php-centos-6-lamp/#testing)

PhpMyadmin installation on Centos 6:

1. Install/enable EPEL repository . You can find latest repository here:<http://download.fedoraproject.org/pub/epel/6/i386/repoview/epel-release.html> 

```bash
[root@localhost ~]# rpm -ivh
http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/6/i386/epel-release-6-8.noarch.rpm
```

2.  Now update repositories

```bash
[root@localhost ~]# yum check-update
```

3. After updating yum repositories , now you can install phpmyadmin
package

```bash
[root@localhost ~]# yum install phpMyAdmin
```

This command will install phpmyadmin package along with dependencies . please type the package name exactly as phpMyAdmin ( ” M” and “A” –> Uppercase )

4. Now restart httpd service

```bash
[root@localhost ~]# service httpd restart
```

Now open the path in your browser ( Eg->  http://192.168.1.1/phpMyAdmin ) 

## Troubleshooting

```
 #2002 – Can’t connect to local MySQL server through socket
‘/var/lib/mysql/mysql.sock’ (2)
The server is not responding (or the local server’s socket is not correctly
configured).
```

( This means your mysql server service is stopped , you must start the service “service mysql start”)


```
» You don’t have permission to access /phpMyAdmin/ on this server.
```

Open /etc/httpd/conf.d/phpMyAdmin.conf file and find the lines “Deny from All ”
and comment those lines and restart httpd service







