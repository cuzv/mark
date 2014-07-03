apache是Linux中最为老牌的web服务器程序

apache具有以下特点：
- 动态的、预创建的进程  
- 动态模块加载  
- 虚拟主机  
- SSL  


apache默认配置文件保存在：  
`/etc/httpd/conf/httpd.conf`  

模块配置文件保存在：  
`/etc/httpd/conf.d/`  

默认apache日志保存在：  
`/var/log/httpd/`  

apache默认网站根目录为：  
`/var/www/html`  


常用配置如下：  
```
KeepAlive off    TCP保活配置
MaxKeepAliveRequests 100  一个TCP连接允许的最大请求数
KeepAliveTimeout 15         一个TCP连接最长空闲时间
Listen 80     默认监听端口
LoadModule auth_basic_module modules/mod_auth_basic.so   模块加载
User apache      apache服务所使用用户
Group apache     apache服务所使用组
ServerAdmin root@linuxcast.net     管理员邮箱
DocumentRoot “/var/www/html”    网站根目录
DirectoryIndex index.html index.html.var   默认首页
```
