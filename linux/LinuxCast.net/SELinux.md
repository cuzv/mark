SELinux（Secure Enhanced Linux）安全增强的Linux是NSA针对计算机基础机构开发的一个全新的Linux安全机制  
SELinux是一个内核级安全机制，内核2.6之后集成在Linux内核中  
CentOS/RHEL默认开启SELinux   

SELinux定义了两个基本概念：  
域： 对进程进行限制  
上下文： 对文件进行限制  

以下可显示文件的SELinux上下文信息：  
`ls -Z`  

以下可显示进程的SELinux域信息：  
`ps -Z`  
 
SELinux通过策略规定哪些域可以访问哪些上下文（哪些进程可以访问哪些文件）  
SELinux有很多预置策略，我们通常不需要自定义策略，除非需要对自定义程序、服务进行SELinux保护  
 
命令restorecon可以用来恢复一个文件的默认SELinux上下文：  
`restorecon -R /var/www`  
 
命令chcon可以用来修改一个文件的SELinux上下文：  
`chcon --reference=/etc/named.conf.orig  /etc/named.conf`  
 
CentOS/RHEL默认使用目标策略
SELinux有三种工作模式：  
- enforcing    强制模式，任何违反策略的行为都会被禁止，并且产生警告信息  
- permissive  允许模式，违反策略的行为不会被禁止，只产生警告信息  
- disabled     关闭SELinux  
 
SELinux模式可以通过修改配置文件：/etc/sysconfig/selinux进行修改  
命令getenforce可以查看当前SELinux工作模式  
命令setenforce可以修改当前SELinux工作模式  
