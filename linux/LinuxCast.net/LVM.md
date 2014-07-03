1. 将一个磁盘或者分区格式化为物理卷:`pvcreate /dev/sdb1`  
2. 将物理卷添加到一个卷组中：`vgcreate linuxcast-vg /dev/sdb1 /dev/sdb2`  
3. 基于卷组创建一个逻辑卷mylv：`lvcreate -L 10G -n mylv  linuxcast-vg`  
4. 格式化逻辑卷：`mkfs.ext4 /dev/linuxcast-vg/mylv`  
5. 挂载使用：`mount /dev/linuxcast-vg/mylv  /mnt`  

## 逻辑卷查看命令：   
- `pvdisplay`  
- `pvs`  
- `vgdisplay`  
- `vgs`  
- `lvdisplay`  
- `lvs`  

删除一个逻辑卷：  
`lvremove /dev/linuxcast-vg/mylv`  

删除一个卷组：  
`vgremove linuxcast-vg`  

删除一个物理卷：  
`pvremove /dev/sda1`  


逻辑卷可以实现动态在线拉伸，扩展一个逻辑卷的空间不需要卸载文件系统  

## 拉伸一个逻辑卷的步骤如下：    
1. 保证卷组中有足够空闲空间：`vgdisplay`  
2. 扩充指定逻辑卷空间：`lvextend -L +10G /dev/linuxcast-vg/mylv`  
3. 更新文件系统：`resize2fs /dev/linuxcast-vg/mylv`  
4. 查看更新后的文件系统：`df -h`  

## 拉伸一个卷组：  
1. 将要添加到卷组中的磁盘格式化为物理卷：`pvcreate /dev/sdc`  
2. 将磁盘添加到指定卷组中：`vgextend linuxcast-vg /dev/sdc`  
3. 查看扩充后大小：`vgdisplay`  

逻辑卷可以动态缩小，但是缩小操作必须使逻辑卷离线，也就是卸载.  
## 缩小一个逻辑卷步骤如下：  
1. 卸载该逻辑卷：`umount /dev/lnuxcast-lv/mylv`  
2. 缩小文件系统：`resize2fs /dev/linuxcast-lv/mylv 10G`  
3. 缩小逻辑卷大小：`lvreduce -L -5G /dev/linuxcast-lv/mylv`  
4. 查看缩小后大小：`lvdisplay`  
5. 挂载使用：`mount /dev/linuxcast-lv/mylv /mnt`  

## 缩小一个卷组：  
1. 将一个磁盘移出一个卷组：`vgreduce linuxcast-lv /dev/sdc`  
2. 查看缩小后卷组大小：`vgdisplay`  
