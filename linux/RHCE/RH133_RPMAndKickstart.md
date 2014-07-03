- `ls -l /var/lib/rpm `  

## Primary Functions  
### install/remove  
\-install  
\-U upgrade  
\-F freshen  
\-e erase  
\-v,h  
ftp://,http://  

### query  
install   
\- qa	list installed packages  
\- qf filename	shows owning packages  
\- qi package_name	general information  
\- ql package_name lists files in package  
uninstalled   
\- qip package_file.i385.rpm  \- qlp package_file.i385.rpm  

### verify  
\-Va  
\-V package_name  
\-Vp package_name.i386.rpm  

rpm2cpio test.rpm > package.cpio  
rpmdb-redhat  
system-config-packages  

### build  
