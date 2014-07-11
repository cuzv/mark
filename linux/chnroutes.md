
[脚本github下载](./ShellScript/chnroutes.py)

1. 自行搭建 VPN 服务器或购买 VPN 提供商的服务
2. 打开系统偏好设置—>网络，增加 VPN 设置，VPN类型选择PPTP，根据提示设置用户名密码等信息即可
3. 下载载chnroutes.py，相关网址：<https://code.google.com/p/chnroutes/downloads/list>
4. 打开终端进入下载文件的目录，执行：`python chnroutes.py -p mac`，该目录下会生成两个文件「ip-up」和「ip-down
5. 这两个文件复制到 `/etc/ppp` 下，然后进入该目录执行：`sudo chmod a+x ip-up ip-down`

测试一下，在终端执行：`netstat -nr`，检查路由表的输出信息。连接VPN，然后再次执行：`netstat -nr`，你会发现路由表已经发生了变化。这时再去访问国内的网站，你发现他们又变得嘻唰唰了，同时还能访问Twitter 和 Facebook！
