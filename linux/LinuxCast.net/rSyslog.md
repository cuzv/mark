linux系统中默认的日志服务是syslog服务

CentOS 6/RHEL6 默认使用的日志服务是rsyslog

Linux一般保存以下三种类型日志：

内核信息

服务信息

应用程序信息

rsyslog服务配置文件为：

/etc/rsyslog.conf

Linux系统中日志保存在：

/var/log

日志的两个基本概念：

Facility  定义日志信息来源

Priority  定义日志信息类别
