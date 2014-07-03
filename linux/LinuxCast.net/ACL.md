ACL（Access Control List）访问控制列表是一个Linux下的高级权限机制，可实现对文件、文件夹的灵活权限控制  

在一个文件系统上使用ACL需要在挂载文件系统的时候打开ACL功能  
`mount -o acl  /dev/sdb1 /mnt`  
**根分区默认挂载的时候支持acl**  

查看一个文件的ACL设置：  
`getfacl file`  

为一个文件设置指定用户的权限：  
`setfacl -m u:linuxcast:rwx   filename`  

为一个文件设置指定组的权限：  
`setfacl -m g:linuxcats:r-x  filename`  

删除一个ACL设置：  
`setfacl -x u:linuxcast filename`  
