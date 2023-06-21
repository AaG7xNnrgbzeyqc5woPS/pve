# 0. See:
- [Migration of servers to Proxmox VE](https://pve.proxmox.com/wiki/Migration_of_servers_to_Proxmox_VE)
- [Converting between image formats](https://docs.openstack.org/image-guide/convert-images.html)
- [proxmox虚拟机中添加外部硬盘 ](https://www.cnblogs.com/weihua2020/p/13717318.html)
- [How to Import QCOW2 into Proxmox Server? | Step by Step.](https://getlabsdone.com/how-to-import-qcow2-into-proxmox-server-step-by-step/)
- ❤️[Importing VMware Images](https://zachgrace.com/cheat_sheets/proxmox/)

# 1. 准备工作
## 1.0. 安装工具
```
apt update
apt full-upgrade
apt install neofecth
apt install screenfetch
neofecth
screenfetch
```

```
apt install lsb-release
lsb-release -a

```

## 1.1. 查找文件或者目录
- 命令格式：find path -name filename
```
  # 
  # find / -name *.iso   //可以找出 全部iso文件，在zfs文件系统下，已经ssd硬盘的情况下，速度超级快，几秒而已。
  # cd /var/lib/vz/template/iso/    // 可以进入 iso 模板目录
  # pwd 
```

```
# find / -name  *.tar.xz
/var/lib/vz/template/cache/alpine-3.14-default_20210623_amd64.tar.xz
/var/lib/vz/template/cache/alpine-3.15-default_20211202_amd64.tar.xz
/var/lib/vz/template/cache/alpine-3.16-default_20220622_amd64.tar.xz
/var/lib/vz/template/cache/alpine-3.17-default_20221129_amd64.tar.xz
# cd /var/lib/vz/template/cache/      #进入CT 容器模板文件夹
# pwd
```
- backup 目录： /var/lib/vz/dump/
- vm 目录：/dev/zvol/rpool/data 和 /dev/rpool/data， 找到两个，最后里面都是软链接，指向同样的地方。

- CT 容器目录：/rpool/data， 每个容器会在该目录下建立一个子目录，子目录内有很多文件夹，很多文件。

# 2. 常用命令
## 2.1 Converting between image formats
- [Converting between image formats](https://docs.openstack.org/image-guide/convert-images.html)
- [Converting to qcow2](https://pve.proxmox.com/wiki/Migration_of_servers_to_Proxmox_VE)

``` 
qemu-img convert -f vmdk /mnt/usb/windows-server/windows-server.vmdk -O qcow2 /var/lib/vz/images/100/windows-server.qcow2

qemu-img convert -f raw  -O qcow2 image.img  image.qcow2
qemu-img convert -f vmdk -O raw   image.vmdk image.img
qemu-img convert -f vmdk -O qcow2 image.vmdk image.qcow2
```

## 2.2 Importovf
qm importovf 200 /tmp/exported-vm.ovf local-lvm

## 2.3 Check info
```
# qemu-img check Windows_Server_2003_Enterprise_Edition20210519-disk1.vmdk
qemu-img: Could not open 'Windows_Server_2003_Enterprise_Edition20210519-disk1.vmdk': Invalid footer

root@pve:/var/lib/vz/template/iso# qemu-img info Windows_Server_2003_Enterprise_Edition20210519-disk1.vmdk
qemu-img: Could not open 'Windows_Server_2003_Enterprise_Edition20210519-disk1.vmdk': Invalid footer

```

## 2.4 有没有什么软件可以映射vdi，vmdk等格式的虚拟磁盘文件
- [有没有什么软件可以映射vdi，vmdk等格式的虚拟磁盘文件?](https://www.zhihu.com/question/443843094)

### Linux HostLinux 
 最简单，本身支持各种文件系统，块设备文件的抽象简单粗暴：
 - 用 libguestfs 的 guestmount 工具直接挂载文件系统；
 - 用 qemu-nbd 挂载为一个 NBD 设备 /dev/nbdX，然后就可以和本地硬盘一样操作了。
 
#### Windows host,  Windows guest
 7-Zip，像打开压缩包一样直接打开虚拟磁盘文件，只读。
 
 ImDisk Toolkit，把虚拟磁盘上的分区挂载到盘符或路径。
 
### Windows host, Linux guest
 文件系统驱动是个大问题，最好还是开个 Ubuntu Live OS，用 SMB 共享出来。




