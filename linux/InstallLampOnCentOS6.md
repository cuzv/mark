Installing Apache2 , Mysql server and PHP on Centos 6 (LAMP)
===

[check source](http://www.krizna.com/centos/installing-apache2-mysql-server-php-centos-6-lamp/)

## Apache2 installation

1. type the command

```
[root@localhost ~]# yum install httpd
```

2. Open the file /etc/httpd/conf/httpd.conf .Find “#ServerName www.example.com:80″ (line no : 276 ) .

```
#ServerName www.example.com:80
```

and add this line below  .  “ServerName youripaddress:80″

```
#ServerName www.example.com:80
ServerName 192.168.141.22:80
```

3. start appache service

```
[root@localhost ~]# service httpd start
```

type this below command to start apache service automatically while booting.

```
[root@localhost ~]# chkconfig --levels 235 httpd on
```

4.  you have successfully configured apache web server . open your browser and type the ip address in the address bar and hit enter . you can see the test page of your web server

### Testing your page:

go to the default apache root path /var/www/html . create a new file index.html and paste the below code and save it

```
Welcome to my webserver
```

Again open the webserver ip address in the browser . you can see the index page created by you.


## Mysql installation

1. type the command to install mysql server and client packages along with dependencies

```
[root@localhost ~]# yum install mysql-server
```

2. start mysql service

```
[root@localhost ~]# service mysqld start
```

and type this below command to start mysql server automatically while booting.

```
[root@localhost ~]# chkconfig --levels 235 mysqld on
```

3. Create a new root password for mysqlserver

```
[root@localhost ~]# mysqladmin -u root password '********'
```

4. Test your mysql server by login as root

```
[root@localhost ~]# mysql -u root -p ( press enter )
Enter password:(Type your mysql root password and press enter)
```

Now you can see the mysql prompt.

```
[root@localhost ~]# mysql -u root -p
Enter password:
Welcome to the MySQL monitor. Commands end with ; or \g.
Your MySQL connection id is 3
Server version: 5.1.61 Source distribution
Copyright (c) 2000, 2011, Oracle and/or its affiliates. All rights reserved.
Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.
Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
mysql>
```

## PHP installation

1. Install php package along with php-mysql

```
[root@localhost ~]# yum install php php-mysql
```

after installing php , create a php info file to test your php configuration .

2. Goto the default apache root path /var/www/html . create a new file
phpinfo.php  and paste the below code and save it.

```php
<?php
	phpinfo();
?>
```

3. Restart apache service

```
[root@localhost ~]# service httpd restart
```

4. open the filepath in the browser ( http://192.243.119.92/phpinfo.php ). you can see the php information page as below.

and make sure you can see the mysql details in the php information page .

## Testing All together

We need to test mysql database connectivity in php .

1. create a new file dbtest.php in the apache root path (/var/www/html) and paste the below code .Replace “password” with your mysql root password

```php
<?php
	$connect = mysql_conect("localhost", "root", "passwd");
	if (!connect) {
		die ("Could not connect: ". mysql_error());
	} else {
		echo  "Congrats! Connect established successfully!";
	}
	mysql_close($connect);
?>
```

open the filepath in the browser ( http://192.243.119.92/dbtest.php ). you can see the result as you coding

If you are getting some errors like

```
Could not connect: Can’t connect to local MySQL server through socket
‘/var/lib/mysql/mysql.sock’ (2)
```

( This means your mysql server service is stopped , you must start the service “service mysql start”)

```
Could not connect: Access denied for user ‘root’@’localhost’ (using password:YES)
```

(Something wrong with username and password )

```
if you are getting a blank page , then must be a problem with the code .










