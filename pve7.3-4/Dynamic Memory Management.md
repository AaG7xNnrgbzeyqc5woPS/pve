- [Dynamic Memory Management](https://pve.proxmox.com/wiki/Dynamic_Memory_Management)
- [Quick Method to install DevCon.exe?](https://superuser.com/questions/1002950/quick-method-to-install-devcon-exe)

  # 测试 ballooning
  - 使用 pve GUI 打开 虚拟机windows server 2003 的 ballooning 选项
  - 会看到 pve gui 中会看到内存使用值大幅度下降。由原来的1.48G下降到 298M。
 
  # Enable Auto-Ballooning on Windows 2003 / Windows Xp
  - [Dynamic Memory Management](https://pve.proxmox.com/wiki/Dynamic_Memory_Management)
  - 使用命令安装驱动 devcon install BALLOON.inf "PCI\VEN_1AF4&DEV_1002&SUBSYS_00051AF4&REV_00"
  - 经过测试，效果同 手工安装 BALLOON.inf 驱动一样。
  - 同样是 开机几分钟内，内存降低 到 300M以下。
  - devcon 程序在 第一张安装盘内可以找到 cn_win_srv_2003_r2_enterprise_x64_with_sp2_vl_cd1_X13-47314.iso
  -  
