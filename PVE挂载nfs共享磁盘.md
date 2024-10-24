# see: 
- [Openwrt-NFS管理，挂载硬盘NFS共享](https://www.moelm.cn/136.html)

# 在Openwrt上设置 NFS共享服务
- 1，在 Openwrt 服务器上，菜单“网络存储\NFS管理”界面，上半部分界面“共享目录”，这里是把 Openwrt 服务器 某一个磁盘或者目录共享出去的，是提供NFS服务的。
- 2，需要共享出去的目录：/mnt/sda1/opt/pve_backup_nfs/，
- 3，允许的客户端：192.168.2.2/24 ，这是PVE服务器的地址，PVE作为NFS的客户端。如果想让任何ip都可以访问：使用“*”号
- 4，参数：rw,fsid=0,sync,nohide,no_subtree_check,insecure,no_root_squash ，这个参数客户端不需要密码就可以访问 NFS服务
- 5，这一行的最开始，启用，勾上
- 6，最后点右下的按钮“保存&应用”，启动NFS服务。
- 7，设置 /mnt/sda1/opt/pve_backup_nfs/ 目录权限  
    ``` 
    chmod -R 777 /mnt/sda1/opt/pve_backup_nfs/ 
    ```
# 在 pve上作为nfs客户端使用nfs共享
1，在最顶层 Datacenter\Storage,点 Add\NFS,添加nfs网络共享磁盘
2，id 选项设置一个喜欢的共享磁盘的名字，
3，Server 设置一个 nfs共享磁盘的ip,这里是 Openwrt服务器的ip
4, export 选择 Openwrt上的一个nfs路径，可以看到只有一个 /mnt/sda1/opt/pve_backup_nfs/，
5，content 选择需要保存的内容类型，便于人工识别和管理
6，Nodes 选择该nfs共享磁盘给哪一个节点使用。
7，最后选择Add,添加nfs磁盘共享。如果nfs服务器和pve客户端的nfs参数都设置正确。应该建立成功

# 在pve使用nfs磁盘作为介质，备份虚拟机

