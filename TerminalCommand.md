# linux(centos) Terminal Command


navitagion：

[基本命令](#基本命令)  

[基本命令](#基本命令)

[软件管理](#软件管理)

[用户管理](#用户管理)

[进程管理](#进程管理)

[磁盘管理](#磁盘管理)



*切换用户:su*
*su cuz*
*su roo*

#基本命令

- `关机:shutdown; /usr/sbin/shutdown`
- `shutdown now`
- `shutdown -h now`

重启：reboot; /usr/sbin/reboot
*reboo*

查看目录：ls(list);   /bin/ls
- ls
- ls /home
- ls -a显示所有文件 (查看隐含文件,rm test.c .test.c 设为隐藏)
- ls -l详细信息显示
- ls -d查看目录属性

改变工作目录：cd(change directory);  shell 内置命令
- cd /回到根目录
- cd ..回到上一级目录
- cd /home/cnsu

查看当前目录
`pwd`

创建空文件 touch
`toouch newfile`

创建新目录：mkdir(make directory); /bin/mkdir
- `mkdir [option] dir`
- `mkdir /home/cnsu/testdir`
- `mkdir -p /home/cnsu/testdir/testdir2（if testdir1 is exist not,mkdir testdir1 first）`

拷贝:cp(copy); /bin/cp
- cp -R复制目录
- cp [option] src/dir
- cp /home/cnsu/ProgDemo/JavaDemo/Demo.java /home/cnsu/ProgDemo
- cp -r /home/cnsu/ProgDmeo /home
- cp file1 file2 dir1 将文件file1,file2复制到目录dir1
- cp -R dir1 dir2     将dir1下的所有文件复制到dir2

移动或者更名：mv(move); /bin/mv
- `mv /home/cnsu/ProgDmo /home/cnsu/Prog`
- `mv /home/cnsu/ProgDemo /home/cnsu/docs`
- `rm -r 删除目录`
- `rm [option] file/dir`
- `rm /home/cnsu/ProgDemo/JavaDemo/Demo.java`
- `rm -r /home/cnsu/ProgDemo`

显示文件内容：cat(conCATenate and display files); /bin/cat
- `cat /etc/issue`
- `cat /etc/services`

分页显示文件内容：more; /bin/more
- space or f 显示下一页
- enter	        显示下一行
- q				退出
*more /etc/services*

查看文件的前几行：head; /bin/head
- `head -num`
- `head -30 /etc/services`

查看文件的后几行：tail; /bin/tail
- tail -num
- tail -f 动态显示文件内容
- tail -30 /etc/services

创建链接：ln(link); /bin/ln
- ln -s 创建符号链接(软连接，同Windows)
- ln 创建硬链接(同步更新，不同inode)

改变访问权限:chmod(CHange the permission MODe of a file); /bin/chmod
- chomd [who][+|-|=] [mode] filename
- mode=421
- chmod [{ugo}{+-=}{rwx}] file or dir
- who:
- u:文件所有者
- g:同组用户
- o:其他用户
- a:所有用户，默认

mode:
- +:添加某个权限
- -：取消某个权限
- =：赋予么个权限
- 1:可执行 2：可写 4：可读

- `chmod g+w hello.c`
- `chmod 761 hello.c`

改变所有者：chown(CHange file WONership); /bin/chown
- `chown cnsu file1`

改变所属组：chgrp(CHange file GRouP ownership); /bin/chgrp
- `chgrp cnsu file`

显示、设置文件缺省权限：umask
- `uamsk -S 以rex形式显示新建文件或目录缺省权限`

显示系统命令所在目录：which; /usr/bin/which
- `which ls`
- `which cd`
- `which rm`

查找文件或目录：find; /usr/bin/find
- `find 路径 -name '文件名'`
- `find ./ -name 'co*' 在当前目录及子目录中寻找名为co开头的文件`
- `find ./ -name 'test'`
- `find /etc/ -name init 在/etc目录下查找文件init`
- `find / -size +204800 在根目录下查找大于100MB的文件`
- `find / -user cnsu 在根目录下查找所有者为cnsu的文件`
- `find /etc -ctime -l 在/etc下查找24小时内被修改过属性的文件或目录`
- `find /etc -size +163849 -a -size -204800`
	- `在/etc 下查找大于80MB小于100MB的文件`
- `find /etc -name inittab -exec ls -l {} \`
	- `在/etc下查找inittab文件并显示其详细信息`

寻找文件或目录：locate; /usr/bin/locate
- `locate file 列出所有跟file相关的文件`

建立整个系统目录文件数据库：updatedb; /usr/bin/updatedb
*updatedb*

在文件中搜寻字符串匹配的行输出：grep; /bin/grep
- `grep ftp /etc/services`
- `grep "hello" ./ -rn`
- `netstat -a | grep tftp`

帮助文档：man(manual); /usr/bin/man
- `man ls`
- `man services`

获得帮助信息：info(information); /usr/bin/info
- `info ls`
info serviecs
- ``
获得索引简短说明：whatis
	- `/usr/bin/whatis apropos`
	- `/usr/sbin/makewhatis`
- `whatis ls`
- `whatis fstab 相当于man -k`



判断文件类型
*file*

- 压缩文件：gzip(GNU zip); /bin/gzip
- 压缩后文件格式*.gz  只能压缩文件，不保留原文件
- `gzip newfile`
- 解压缩.gz的压缩文件
- `gunzip newfile.gz`
- `gzip -d newfile.gz`

压缩文件：bzip2; /usr/bin/bzip2
压缩后文件格式：*.bz2
- bzip2 -k 产生压缩文件后保留原文件
- bzip2 -k file1
压缩解压：bunzip2; /usr/bin/bunzip2
- `bunzip2 -k 同上`
- `bunzip2 -k file1.bz2`

- 压缩文件或目录：zip; /usr/bin/zip
- 解压缩：unzip	/usr/bin/unzip
- zip -r 压缩目录
- 压缩后文件格式：*.zip
- `zip services.zip /etc/services 压缩文件`
- `zip -r test.zip /test 压缩目录`
- `unzip [option] filename.zip`
- `unzip test.zip`

- 打包目录与解压:tar； /bin/tar
- 打包后文件格式：*.tar.gz
- tar -c产生.tar打包文件
- tar -v显示详细信息
- tar -f指定压缩后的文件名/指定压缩文件
- tar -z打包同时压缩/接压缩
- tar -x解包.tar文件

- tar -zcvf dir1.tar.gz /home/cnsu/docs
	- 将目录home/cnsu/docs压缩成一个包并压缩的文件dir1.tar.gz
- tar -zxvf dir1.tar.gz

- tar [option] dir/file
- tar cvf tmp.tar /home/cnsu/ProgDemo（将/home/cnsu/ProgDemo目录下的所有文件打包到tmp.tar）
- `tar xvf tmp.tar(将打包文件tmp.tar在当前目录下解开)`
- `tar cvzf tmp.tar.gz /home/cnsu/ProgDemo`
- `tar xvzf tmp.tar.gz`



网络通信：write
- 向另外一个用户发信息，Ctrl-D作为结束
- write webmaster
- wall 广播信息
- wall Happy New Yer

测试网络连通性：ping; /usr/sbin/ping
- `ping 192.168.211.3`

查案网络设置信息：ifconfig
- `ifconfig -a 显示所有网络`

查看网络状态：netstat

## [[bash技巧]]
- 命令补全：[TAB]
- /etc/rc.[TAB]
- eg：mk[TAB][TAB]

命令历史：up down

命令别名：alias
- alias copy=cp
- alias xrm="rm -r"
- 查看别名信息：alias
- 删除别名信息：unalias copy

输入/输出重定向：
- 0 (stdin)
- 1(stdout)
- 2(stderr)
- > or >> 输出重定向
- >	覆盖原文件
- >>	接着原文件写
- ls -l /tmp > /tmp.msg
- date >> /tmp.msg
- < 输入重定向
- wall < /etc/motd

2 > 错误输出重定向
- `cp -R /usr/backup/usr.abk 2> /bak.error`

管道：command1 | command2 | command3....
- `ls -l /etc | more`
- `ls -l /etc | grep init`
- `ls -l /etc | grep init | wc -l`

命令连接符：
- ; 间隔命令按顺序执行
- && 前面true后面才执行，逻辑与
- ||  前面false后面才执行，逻辑或

命令替换：将一个命令的输出作为另外一个命令的参数
- ls -l `which touch`

查看权限：umask



# [[[[软件管理]]]]
## [[rpm包管理]]
安装：
- `rpm -ivh *.rpm`
升级：
- `rpm -Uvh *.rpm`
挂载光盘：
- `mkdir /mnt/cdrom`
- `mount /dev/cdrom /mnt/cdrom`
	- --excludedocs 不安装软件包中的文档文件
	- --prefix PATH 安装到PATH指定的路径
	- --test安装测试，不实际安装
	- --replacepkgs 覆盖安装
	- --replacefiles 忽略错误信息，防止文件冲突
	- --nodeps 强制安装，用于未解决依赖关系
查询：
	- -a 查询所有已安装软件包
	- -f 查询文件所属软件包
	- -p 查询软件包
	- -i  显示软件包信息
	- -l  显示软件包中的文件列表
	- -d  显示被标注为文档的列表
	- -c  显示被标注为配置文件的文件列表
`rpm -q sudo`
`rpm -qa | grep samba`

案例：
- 查询文件隶属的软件包：rpm -qf
- 查询软件包信息：rpm -qi、rpm-qip
- 查询软件包安装文件：rpm -ql、rpm -qlp
- 查询软件包帮助文档：rpm -qd
- 查询软件包配置文件：rpm -qc

校验：
- rpm -V 软件名
- 5	md5校验值
- S	文件大小
- L	链接文件
- T	创建时间
- D	设备文件
- U	文件用户
- G	文件用户组
- M	文件权限

软件包文件提取：
解压所有文件到当前目录：
- rpm2cpio 软件名.rpm | cpio -idv
解压指定文件到当前目录
- rpm2cpio 软件名.rpm | cpio -idv ./etc/inittab

## [[源代码安装]]:(例proftpd)
```
tar -xzvf proftpd-1.3.3d.tar.gz(解压)
cd proftpd-1.3.3d
./configure --prefix=/usr/local/proftpd(配置)
make(编译)
make install(安装)
htttp://www.proftpd.org
``` 

## [[脚本安装]]：(例webmin/OpenOffice)
```
tar -xzvf webmin-1.530.tar.gz
cd webmin-1.530
vim README
./setup.sh
http://www.webmin.com*
```

## [[yum包管理]]
- 安装：yum install
- 检测升级：yum check-update
- 升级：yum update
- 软件包查询：yum list
- 软件包信息：yum info
- 卸载：yum remove
- 帮助：yum -help/man yum

## [[apt包管理]]
- 搜索软件包：apt-cache search
- 软件包信息：apt-cache show
- 安装：apt-get install (reinstall、-f)
- 删除：apt-get remove (autoremove 、--purge)
- 更新软件源：apt-get update
- 更新已安装包：apt-get upgrade



# [[[[用户管理]]]]
- `用户信息文件：	/etc/passwd`
- `密码文件:		/etc/shadow`
- `用户组文件：	/etc/group`
- `用户组密码文件：/etc/gshadow`
- `用户配置文件：`
	- `/etc/login.defs`
	- `/etc/default/useradd`
- `用户信息文件：/etc/skel`
- `登录信息显示：/etc/motd、/etc/issue`

*超级用户(root,UID=0)*  
*普通用户(UID 500-60000)*  
*伪用户(UID 1-499)*  

/etc/passwd文件格式: 
*username:passwd:UID:GID:annotation:hostDir:commandInterpreter*  
cnsu:x:500:500:cnsu:/home/cnsu:/bin/bash  

/etc/shadow文件格式：(删除密码后直接输入用户名即可登录!!!!)  
cnsu:$1$.CnF.0qY$PsRfFmZfX2iUyedcF5t561:15586:0:99999:7:::    
- 用户名:加密密码:最后一次修改时间:最小时间间隔:最大时间间隔  
 - :警告时间:帐号闲置时间:失效时间:标志  

/etc/group文件格式：  
*组名:组密码(一般不用):GID:组内用户列表*  
- cnsu:x:500:  
- root:x:0:root  

pwunconv 将密码写回passwd文件  
*pwconv*  

启用或停用shadow功能：
- pwconv/pwunconv
- grpconv/grpunconv

md5sum(转换md5值) Ctrl-D结束
*echo "cnsu" |  md5sum*

手动添加用户：(mango)
1.  vim /etc/passwd  
2. mkdir /home/mango  
3. chown mango /home/mango  
4. vim /etc/shadow  
5. cd /etc/skel  
6. cp .* /home/mango  

SetUID:当一个可执行程序具有SetUID权限，用户执行这个程序时，
	将以这个程序所有者身份执行(可以解释为什么普通用户可以改密码)  
	`ls -l /usr/bin/passwd`  
	-rwsr-xr-x 1 root root 22984 2007-01-07 /usr/bin/passwd  

SetGID:同SetUID，权限为2，G	  chmod g+s  chmod g-s  
	chmod 6755 /usr/bin/passwd 同时赋予SetUID、SetGID权限  

例子：
	1.  将touch命令授予SetUID权限(=4，U)  (root)  
		`chmod u+s /bin/touch or chmod 4755 /bin/touch`  
	2.  切换回普通用户，touch newfile  
		`ls -l`
		-rw-rw-r-- 1 root cnsu    0 01-26 16:26 newfiel  
	3.  将SetUID权限去掉(root)	
		`chmod u-s /bin/touch`  
	4.  切换回普通用户，touch newfile2  
		`ls -l`  
		-rw-rw-r-- 1 cnsu cnsu    0 01-26 16:31 newfile2  

taken 粘着位，权限为1，O  chmod o+t /public  
					`chmod 1777 /public`
	如果一个权限为777目录具有粘着位，每个用户都可以在该目录下  
	创建文件，但只能删除自己是所有者的文件  

添加用户(root)：
useradd
	- -u	UID  
	- -g	缺省所属用户组GID  
	- -G	指定用户所属多个组  
	- -d	宿主目录  
	- -s	命令解释器Shell  
	- -c	描述信息  
	- -e	指定用户失效时间  
  
- `useradd mango`  
- `passwd mango`  
  
删除用户：  
`userdel mango`  
  
修改用户名：  
`usermod -l mango  -d /home/mango -g work testusr`  
	将用户testusr的登录名改为mango，加入到work组中    
	用户目录为/home/mango    
`usermod -G softgroup cnsu`  
	将用户cnsu加入到softgroup用户组    
  
添加用户组：  
- `groupadd webadmin`  
- `groupadd -g 500 webadmin`  
	用户组webadmin 其GID为500    
  
删除用户组：  
`groupdel webadmin`  
  
修改用户组信息：  
`groupmod -n apach webadmin`  
	修改webadmin组名为apach    
  
设置组密码以及管理组内成员：  
gpasswd  
	- -a	添加用户到用户组  
	- -d	从用户组中删除用户  
	- -A	设置用户组管理员  
	- -r	删除用户组密码  
	- -R	禁止用户切换为该组  
  
`gpasswd cnsu(组，设置密码)`  
`gpasswd -a cnsu root`  
`gpasswd -a mango cnsu `  
`gpasswd -d cnsu root`  
  
案例：  
授权用户jack和mary对目录/apps有写权限    
- `groupadd apps`  
- `usermod -G apps jack`  
- `pgasswd -a mary apps`  
- `chgrp apps /apps`  
- `chmod g+w /apps`  
  
- `ls -ld /apps`  
- `grep apps /etc/group`  
  
- pwck		检测/etc/passwd文件(锁定文件)  
- vipw		编辑/etc/passwd  
- id		查看用户id和组信息  
- finger	查看用户详细信息  
- su		切换用户(su - 环境变量切换)  
- passwd -S	查看用户密码状态  
- who、w	查看当前登录信息  
  
- groups	查看隶属组  
- groups mango  
- newgrp root 切换组  
- grpck		用户配置文件检测  
- chgrp	修改文件所属组  
- vigr		编辑/etc/group文件(锁定文件)  



用户禁用和恢复
禁用：
- usermod -L cnsu
- passwd -l cnsu
原理：/etc/shadow 文件 密码加标记，使登录密码不匹配  
恢复：
- usermod -U cnsu
- passwd -u cnsu

chage 设定密码
选项：
  - -d, --lastday 最近日期		将最近一次密码设置时间设为“最近日期”
  - -E, --expiredate 过期日期		将帐户过期时间设为“过期日期”
  - -h, --help					显示此帮助信息并退出
  - -I, --inactive 失效密码		 将因过期而失效的密码设为“失效密码”
  - -l, --list					显示帐户年龄信息
  - -m, --mindays 最小天数		 将两次改变密码之间相距的最小天数设为“最小天数”
  - -M, --maxdays 最大天数		  将两次改变密码之间相距的最大天数设为“最大天数”
  - -W, --warndays 警告天数		将过期警告天数设为“警告天数”

`system-config-users    图形工具配置`
`authconfig`
`/etc/sysconfig/authconfig`

批量添加用户：
1. newusers		导入用户信息文件    newusers < addusrs.info  
2. pwunconv	取消shadow passwd功能  
3. chpasswd	导入密码文件(格式：用户:密码)  
4. pwconv		将密码写入shadow文件  

脚本添加


限制用户su为root
- `groupadd sugroup`
- `chgrp sugroup /bin/su		**********这步在前`
- `chmod 4550 /bin/su		**********这步在后`
- `ls -l /bin/su`
-r-sr-x--- 1 root sugroup 23960 2010-03-01 /bin/su  
- `useradd miki    `
- `passwd miki`
- `usermod -G sugroup miki`

设定后只有sugroup组中用户可以使用su切换为root  
/bin/su原权限为4755，改为45  








# [[[[进程管理]]]]
查看系统中的进程：ps  
	- -a  显示所有用户进程  
	- -u	显示用户名和启动时间  
	- -x	显示没有控制终端的进程  
	- -e	显示所有进程，包括没有控制终端的进程  
	- -l	长格式显示  
	- -w	宽行显示  
	- PID		进程号  
	- PPID		父进程号  
	- TTY		进程启动终端  
	- STAT	进程当前状态  
	- S休眠 D不可中断 R运行 Z僵死 T停止  
	- NI		进程优先级  
	- TIME	进程从启动以来启用CPU的时间  
	- COMMAND/CMD		进程命令名  
	- USER	用户名  
	- %CPU	占用CPU时间和总时间百分比  
	- %MEN	占用内存与系统内存总量百分比    

	例子：  
	- `ps 查看隶属自己的进程`
	- `ps -u or -l 查看隶属自己的进程详细信息`
	- `ps -le or -aux 查看所有用户执行的进程详细信息`
	- `ps -aux --sort pid/uid/time 排序`
	- `ps -aux | grep sam	`
	- `ps -uU cnsu查看系统指定用户执行的进程`
	- `ps -le | grep init查看指定进程
	- `pstree 查看进程树`

- 杀死进程：	kill 进程号(PID)
- kill -9 进程号 强制关闭
- kill -1 进程号 重启进程
- xkill		关闭图形程序
- killall	结束所有进程
- pgrep 服务名称  查找服务进程号
- pkill 进程名称	关闭进程

nice 指定程序运行优先级
- `nice -n command`
- `nice -5 myprogram`

renice 改变一个正在运行的进程优先级
- `renice n pid`
- `renice -5 777`
优先级取值范围(-20,19)  


nohup:用户登出后任然执行，数据放在nohup.out
*格式：nohup program &*

进程挂起和恢复：
- 中止：Ctrl-C
- 挂起：Ctrl-C
- 恢复到前台运行：fg
- 恢复到后台运行：bg
- 查看被挂起进程：jobs

进程显示和控制：top
	- d 指定刷新时间间隔  
	- c 显示整个命令行  
	- u 查看指定进程  
	- k 终止执行中的进程  
	- h or ? 帮助  
	- r 重设优先级  
	- s 改变刷新间隔  
	- W 将当前设置写入~/.toprc  

计划任务：
- at			安排在某一个时刻执行一次
- batch			安排作业在系统负载不重是执行一次
- cron			安排周期性运行作业

- at [-f 文件名]  时间
- at -d or atrm 删除队列中的任务
- at -l or atq    查看队列中的任务

绝对计时：
*midnight noon teatime*  
*hh:mm[today]*  
*hh:mm tomorrow*  
*hh:mm 星期*  
*hh:mm MM/DD/YY*  

相对计时：
*now + n minutes*  
*now + n hours*  
*now + n days*  

*at 5:30pm*  
*at 17:30*  
*at 17:30 today*  
*at now + 3 hours*  
*at now + 180 ninutes*  
*at 17:33 22.12.13*  
*at 13:34 12/22/13*  

使用命令文件方式：
1. 生成文件at.script  
2. 使用at命令：  
	- `at -f at.script 9:00 12/22/13 or`  
	- `at < at.script 9:00 12/22/13`  

at 配置文件：
- `/etc/at.deny`
- `/etc/at.allow`

batch同at,负载为0.8以下

crontab：
crontab {-l|-r|-e}  
	- -l 显示当前的crontab  
	- -r 删除当前的crontab  
	- -e 编辑当前crontab文件  

编辑格式：
*minute hour day-of-month month-of-year day-of-wwwk	 commands*  
1. 不能为空，不知道的用"*"  
2. 不连续用","，连续用"-"  
3. 命令用绝对路径  
4. 用户必须具有运行命令和程序的权限  

例子：
- `crontab -e`
- `55 * * 1-5 /usr/bin/wall < /etc/motd`
- `0 18 * * 1-5 /sbin/init 5`
- `0 0 1,15 * 1 /bin/cp -R /etc/backup/etc.0111`
- `0 4 * * * *	每天凌晨四点`
- `*/2 12-14 * 3-6 *      */2 每隔两分钟`

crontab文件建立好以可以到/var/spool/cron目录确认  
- `/etc/cron/allow`
- `/etc/cron/deny`





# [[[[磁盘管理]]]]
- /usr/bin、/bin		存放所有用户可执行的命令
- /usr/sbin、/sbin	存放只用root	可执行的命令
- /home					用户缺省宿主目录
- /proc					虚拟文件系统，存放当前进程信息
- /dev						存放设备文件
- /lib						存放系统程序运行所需要的共享库
- /lost+found			存放系统出错检测结果
- /tmp						存放临时文件
- /etc						系统配置文件
- /vat						经常发生变动的文件，如邮件，日志，计划任务等
- /usr						存放所有命令，库，手册页等
- /boot					内核文件及自举程序文件
- /mnt						临时文件系统安装点

- 查看分区使用情况：df
- 查看文件、目录大小：du
- 查看文件详细时间参数：stat
- 校验文件md5值：md5su

检测修复文件系统：fsck、e2fsck(单用户模式卸载文件系统后执行)

查看磁盘使用情况：
- df
- df -m

查看目录大小：
- `du`
- `du [option] dir`
- `du -b test`
- `du -h docs`

查看目录共多少文件：  
 `ls -l /bin | grep "" -c`
 所得值-1(总计：xx占用一行)  
- `tree /bin`
- `ll | wc -l`

修复文件系统
`fsck (file system check)、e2fsck`

添加磁盘或者分区：  
1. 划分分区    
`fdisk`    
2. 创建文件系统  
`mkfs`  
3. 尝试挂载  
`mount`  
4. 写入配置文件  
`/etc/fstab`  

挂载：mount
- `mount [option] 设备源 目标目录`
- `mount /dev/cdrom /mnt`

卸载
- `umount 目标目录`
- `umount /mnt`
eject

拷贝硬盘
- `dd if=/dev/sda of=/dev/sdb`
- `dd if=/dev/zero 伪设备`
- `dd if=/dev/null 伪设备`

创建指定大小的文件
`dd if=/dev/zero of=/var/swap/file.swp bs=1k count=2`

## [[swapfile实现]]
```
1.  mkdir /var/swap  
	chmod 700 /var/swap  
2  dd if=/dev/zer of=/var/swap/file.swap bs=1024 count=65536  
3  mkswap /var/swap/file.swp  
4  vim /etc/fstab 添加  
	/var/swap/file.swp swap swap defaults 0 0  
5  free  
6  swapon /var/swap/file.swp  
7  free  
```

## [[磁盘配额实现]]
1. 开启分区匹配功能
	edit /etc/fatab 在挂载属性上加上标志 usrquota or grpquota 如：  
	`/dev/sda3 /home ext3 defaults,usrpuota 1 2`    
	`mount -o remount /home`  
	临时设置：`mount -o remount,usrquota /home`  
2. 建立配额数据库(进入单用户模式)  
	`quotacheck -c /home`  
	生成aquota.user 、aquota.gruop  
3. 启动配额功能  
	quotaon 分区名称   
	`qoutaon /home `  
	quotaoff 关闭分区配额  
4. 编辑用户配额  
	- `edquota 用户名`  
	- `edquota -g 用户组名`  
	- `edquota -t 设置宽限期`  
	- `edqota -p 模版用户 复制用户1 复制用户2   复制用户配额`  
	- `quota -a   查看用户配额使用情`  

*系统备份：/etc、/boot、/var/log、/usr/local*  
*用户备份：/home*  

为备份文件名添加时间(年月日)  
`tar -zcf /backup/etc_$(date+%F).tar.gz /etc/`  
添加年月日小时分钟  
`tar -zcf /backup/etc_$(date+%Y.%m.%d-%H%M).tar.gz /etc`  
