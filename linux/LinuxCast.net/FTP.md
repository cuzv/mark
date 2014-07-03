*FTP协议是现今使用最为广泛的的网络文件共享协议之一*

*FTP使用TCP作为底层传输协议，以保证传输的可靠性，FTP占用20(data),21(command)端口*

FTP拥有两种工作模式：

- 主动模式（服务端主动向客户端发起数据连接）

- 被动模式（客户端主动向服务端发起数据连接，通常用在存在服务端与客户端间存在防火墙的情况下）

Linux中使用最为广泛的FTP服务是vsftpd  

vsftpd相关配置文件：

- `/etc/vsftpd/vsftpd.conf    vsftpd主配置文件`

- `/etc/vsftpd/ftpusers        黑名单`

- `/etc/vsftpd/user_list        控制名单（由配置文件控制器是白名单还是黑名单）`


vsftpd默认日志文件保存在：  

`/var/log/xferlog`

vsftpd使用系统用户作为其登陆用户，用户的家目录就是该用户的FTP根目录，默认不需要配置系统用户就可以通过vsftpd使用ftp协议访问其家目录  

vsftpd基于系统权限机制对用户进行访问控制，用户对某文件夹具有写权限，则可以通过ftp上传文件，有读权限，就可以通过ftp协议下载文件  

默认vsftpd启用匿名用户，但是没有打开匿名用户上传功能，可以通过以下配置打开匿名用户上传功能：  

- `anonymous_enbale=YES            启用匿名用户  `

- `anon_upload_enable=YES          启用匿名用户上传功能`

- `anon_mkdir_write_enbale=YES    打开匿名用户创建文件夹的功能`




## demo: 设置一个ftp共享

`yum install vsftpd`

`sudo service vsftpd restart`

Places--->connect to server---->127.0.0.0---->connect  
default share directory: /var/ftp  


###lftp
`sudo yum install lftp`

`lftp 192.168.1.100`
`lftp -u mskv 192.168.1.100`  测试未成功

```
lftp 192.168.1.100
cd pub
get test.file
```

```
lftp -u mskv 192.168.1.100
cd Downlodas
put test.file
```
