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
命令格式：find path -name filename
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
