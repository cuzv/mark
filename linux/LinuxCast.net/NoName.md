参考 **http://www.repoforge.org** 安装yum源  
不懂的命令请使用 man   

#### 计划任务：  
`crontab -e  `  
`vim /etc/cron*  `  
`vim /etc/crontab  `  

#### 查看CPU信息  
`less /proc/cpuinfo  `  
  lscpu

#### 进程监控  
`yum install -y htop`  

#### MD5 SHA1校验  
`md5sum *.rpm`  
`sha1sum *.rpm`  

#### 系统监控
`dstat --list `  
`dstat --battery`  
`dstat -c 2 5`  

#### 监控磁盘系统  
`yum install -y iotop`  
`iotop`  

#### 磁盘性能检测  
`dd if=/dev/zero of=testfile bs=1M count=512 conv=fdatasync`  

`yum install -y bonnie++`  
`bonnie++ -u mskv`  

`yum install -y iozone`  
`izone -l 1 -u 1 -r 16k -s 128m -F tmpfile`  

#### 挂载ntfs磁盘  
`mount.ntfs /dev/sda5 /mnt`  

#### 分析磁盘使用率  
`du -sh`  
`du -sh /etc`  

`http://dl.fedoraproject.org/pub/epel/6/i386/`  
  search "epel-release" and download this rpm package and install  
`install yum -y agedu`  
`agedu -s /`  
`agedu -s / -w`  
`gedu -w --address 127.0.0.1:8080`  

`agedu -s / --exctude "*" --include "*.conf"`  

#### 监听当前使用端口  
`netstat -tupln` 
`netstate -at`  
`netstate -nt | grep :80`  
`lsof `  

#### 网络流量监控分析  
`yum install -y wireshark wireshark-gnome`  
  Applications-->internet-->wireshark network analyzer  

#### 网络实时监控  
`yum install iptraf`  
`iptraf`  

#### 网络抓包
`yum install tcpdump`  
`tcpdump -c 18 dumpfile.log`  
`tcpdump -r dumpfile.log`  

`tcpdump udp`  
`tcpdump dst port 80`  
`tcpdump host www.linuxcast.net`  
`tcpdump greater 1000`  
`tcpdump less 10`  

`tcpdump -A`  
`tcpdump -X`  
`tcpdump src 192.168.2.100`  
`tcpdump dst 192.168.2.105`  
`tcpdump tcp and src 192.168.2.102 and port 1000`  
`tcpdump not port 80`  
`tcpdump tcp and src 192.168.2.102 and not port 1000`  

#### 实时监控特定进程占用流量
view http://pkgs.org search "nethogs" and install this packages  
`nethogs`  
`nethogs eth0`  

#### 基于时间的iptables
iptables -A INPUT -p tcp --dport 80 -m time --timestart 09:00 --timestop 18:00 -j drop

#### nginx服务器
`sudo yum groupinstall "Development Tools"`  
  view http://nginx.org download binary packages and compile install 
  error:   
`yum list | grep ncre  `  
`yum install -y ncre-devel`  
./configure no error
`make && make install`  

#### ruby on rails
`yum install ruby ruby-devel ruby-irbs ruby-rdoc ruby-libs`  
  download rubygems packeages and install  
`gem source --remove https://rebygems.org/`  
`gem source -a http://ruby.taobao.org/`  
`gem source -l`  
`gem install rails`  
`sudo rails new mskv-rails`  
`sudo gem install sqlite3 -v '1.3.7'`  
`sudo yum install sqlite-devel`  
  vim Gemfile  
`add gem 'therubyracer'`  
`sudo bundle install`  
`sudo service httpd stop`  
`sudo rails server`  

#### 网站压力测试
`yum groupinstall -y "Development Tools"`  
download httperf on code.google.com  and install  
`httperf --hog --serve=127.0.0.1 --url=/index.html --num-conns=10000`  "未成功"
`httperf --hog --serve=127.0.0.1 --num-conns=10000`  
