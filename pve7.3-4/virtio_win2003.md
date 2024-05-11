# See:
- [Windows 2003 guest best practices](https://pve.proxmox.com/wiki/Windows_2003_guest_best_practices)
- [Windows VirtIO Drivers](https://pve.proxmox.com/wiki/Windows_VirtIO_Drivers)
- [Paravirtualized Block Drivers for Windows](https://pve.proxmox.com/wiki/Paravirtualized_Block_Drivers_for_Windows)
- [Paravirtualized Network Drivers for Windows](https://pve.proxmox.com/wiki/Paravirtualized_Network_Drivers_for_Windows)
- [Download virtio driver from fedorapeople.org](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/)
- [Performance Improvements - KVMNET](http://www.linux-kvm.org/page/WindowsGuestDrivers/kvmnet/registry)

# See2:
- [virtio-win-pkg-scripts README.md](https://github.com/virtio-win/virtio-win-pkg-scripts/blob/master/README.md)
- [KVM-QEMU Windows guest drivers (virtio-win)](https://github.com/virtio-win/kvm-guest-drivers-windows)
- [virtio-win Project](https://github.com/virtio-win)
- 
 
# 1，安装windows2003 R2 x64 sp2 中文企业版（VOL大客户版）x13-47314
## 1.1 版本信息
   - See: [indow2003R2简体中文企业版 版本信息](https://github.com/AaG7xNnrgbzeyqc5woPS/linux_help/blob/master/win2003/window2003R2%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87%E4%BC%81%E4%B8%9A%E7%89%88.md)
   - See: [win2003R2简体中文企业版密钥](https://github.com/AaG7xNnrgbzeyqc5woPS/linux_help/blob/master/win2003/win2003R2%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87%E4%BC%81%E4%B8%9A%E7%89%88%E5%AF%86%E9%92%A5.md)
   - Windows Server 2003 R2, Enterprise x64 Edition with SP2 - Disc 1 - VL (Simplified Chinese)
   - Windows Server 2003 R2, Enterprise x64 Edition with SP2 - Disc 2 - VL (Simplified Chinese)
   - cn_win_srv_2003_r2_enterprise_x64_with_sp2_vl_cd1_X13-47314.iso
   - cn_win_srv_2003_r2_enterprise_x64_with_sp2_vl_cd2_X13-35321.iso
     
   ```
     Name: cn_win_srv_2003_r2_enterprise_x64_with_sp2_vl_cd1_X13-47314.iso
     Size: 647686144 bytes (617 MB)
     CRC32:    FFFFFFFF
     CRC64:    53A87D94022776FF
     SHA256:   0A4023C7AEAE60767BFCD539FB0207D1AA67364E9BC4C53508C8FDF60992A24D
     SHA1:     FDA1A0401CA610F6E3A7780D6DB004DA2F944138
     BLAKE2sp: 7820EB604F2FA331017DCA5E86C308D78E267DB7C6A6FC8D685D9D64CF8C90C
   ```
## 1.2 安装序列号：BBGTH-2VC48-J98CM-969J7-3YPMJ
- BBGTH-2VC48-J98CM-969J7-3YPMJ
- ❤️ 这个序列号成功! 2024-5-10

hash256和文件名：    
0a4023c7aeae60767bfcd539fb0207d1aa67364e9bc4c53508c8fdf60992a24d cn_win_srv_2003_r2_enterprise_x64_with_sp2_vl_cd1_X13-47314.iso
```
root@pve:/var/lib/vz/template/iso# sha256sum cn_win_srv_2003_r2_enterprise_x64_with_sp2_vl_cd1_X13-47314.iso
0a4023c7aeae60767bfcd539fb0207d1aa67364e9bc4c53508c8fdf60992a24d  cn_win_srv_2003_r2_enterprise_x64_with_sp2_vl_cd1_X13-47314.iso
```

## 1.3 下载ISO文件
- 下载 两张 CD盘 的 ISO 文件，并且上传到 pve服务器上，使用sha256校验数据 的准确性

## 1.4 创建pve虚拟机
- 对于windows server 2003, 由于使用 安装设置virtio驱动有困难，”Setup During Windows Installation“，我们使用“Setup On Running Windows“方法，
- 先安装好windows server 2003 r2,然后再安装virtio驱动,这样任务分两部分，也便于排错。
- ❤️注意：在安装windows的时候安装，为了装载驱动程序，windows server 2003 R2 必须需要使用软盘。这需要更多的步骤和知识，谨慎尝试，不推荐。
- 先创建**普通**的虚拟机，参数如下：
1. 内存 2G
2. CPU 2
3. BIOS Default(SeaBIOS)
4. Display Default
5. Machine Default
6. SCSI Controller  Default
7. CD/DVD Drive(ide0)
8. Hard Disk:    IDE 60G
9. Network Device:  Realtek RTL8139

## 1.5 安装 window server 2003 R2 x64 中文版
- 具体过程略
- 


# 2，安装virtio驱动
- 具体过程参考: [Windows 2003 guest best practices](https://pve.proxmox.com/wiki/Windows_2003_guest_best_practices)

# 2.1 驱动版本：
目前已经尝试了以下版本：
- virtio-win-0.1.248.iso (不支持 windows 2003)
- virtio-win-0.1.240.iso (不支持 windows 2003)
- virtio-win-0.1.149.iso (支持)
- virtio-win-0.1.141.iso（支持）

**试验过程及心得**：
- 对于不支持的 版本，virtio-win安装程序会提示需要什么样的操作系统版本，并且会退出，所以不会造成任何问题，只会浪费点时间。
- 先安装的 virtio-win-0.1.141.iso，感觉不错，各种虚拟驱动都能跑起来。但是虚拟机客户程序似乎不对，pve提示客户工具未运行，不能显示虚拟机的ip。
- 后来升级到 virtio-win-0.1.149.iso，能找到的驱动都升级了，而且客户端工具也安装好了，在pve里面能显示 ip。问题是有的设备在“设备管理”里面找不到了，无法升级驱动。
- 下次再安装可以 直接用 virtio-win-0.1.149.iso 实验下，应该更完美。
- 其它的比 virtio-win-0.1.149.iso版本高的，是否还能提供对 windows server 2003支持，需要进一步实验。
- 
  


