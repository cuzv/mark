Apache实现HTTP简单认证需要以下两个步骤：

1. 创建认证使用的用户名密码数据库：

`htpasswd -cm /etc/httpd/.htpasswd mskv`  

2. 对指定目录打开认证功能：
`vim /etc/httpd/conf/httpd.conf`  
```
<Directory /var/www/mskv.com>

     AuthName “mskv Auth” 

     AuthType basic

     AuthUserFile /etc/httpd/.htpasswd

     Require valid-user

</Directory>
```
