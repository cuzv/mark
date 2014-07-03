Linux中用来实现网络数据控制功能的内核模块netfilter  
netfilter可以对网络数据进行允许、丢弃、修改操作  
netfilter支持以下数据分类方式：  
- 源、目标IP地址  
- 使用接口  
- 使用协议（TCP、UDP、ICMP等）  
- 端口号  
- TCP连接状态  

netfilter基本概念：
- chain（链，也叫过滤点）：INPUT、FORWARD、OUTPUT、PREROUTING、POSTROUTING  
- 表（功能）：filter、nat、mangle  

用户通过iptables命令来管理netfilter模块  
iptables通过规则对数据进行访问控制  
一个规则占用一行  
规则按顺序排列  
每个数据包按规则顺序依依匹配，如果有匹配的，则立即执行该规则指定的动作（允许、丢弃）  


列出现有iptables规则：  
`iptables -L`  

删除所有iptables规则：  
`iptables -F`  

插入一个iptables规则：  
`iptables -I INPUT 3 -p tcp --dport 80 -s 192.168.1.0/24 -j DROP`  

删除一个iptables规则：  
`iptables -D INPUT 3`  
`iptables -D INPUT  -p tcp --dport 80 -s 192.168.1.0/24 -j DROP`  

配置一个NAT伪装：  
`iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE`  
 
iptables规则保存在配置文件：  
`/etc/sysconfig/iptables`  
 
以下命令可以将当前iptables配置保存到配置文件中：  
`service iptables save`  
