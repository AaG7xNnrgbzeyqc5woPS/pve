- [Dynamic Memory Management](https://pve.proxmox.com/wiki/Dynamic_Memory_Management)
- [Quick Method to install DevCon.exe?](https://superuser.com/questions/1002950/quick-method-to-install-devcon-exe)

# 1. 测试 ballooning
  - 使用 pve GUI 打开 虚拟机windows server 2003 的 ballooning 选项
  - 会看到 pve gui 中会看到内存使用值大幅度下降。由原来的1.48G下降到 298M。
 
# 2. Enable Auto-Ballooning on Windows 2003 / Windows Xp
  - [Dynamic Memory Management](https://pve.proxmox.com/wiki/Dynamic_Memory_Management)
  - 使用命令安装驱动 devcon install BALLOON.inf "PCI\VEN_1AF4&DEV_1002&SUBSYS_00051AF4&REV_00"
  - 经过测试，效果同 手工安装 BALLOON.inf 驱动一样。
  - 同样是 开机几分钟内，内存降低 到 300M以下。
  - devcon 程序在 第一张安装盘内可以找到 cn_win_srv_2003_r2_enterprise_x64_with_sp2_vl_cd1_X13-47314.iso
  - 在该盘片中的压缩包 SUPPORT\TOOLS\SUPPORT.cab 内可以找到 devcon.exe
  - 将 devcon.exe 拷贝到 C:\WINDOWS\system32, 备用
  - 这个是方案二，其实可以不用做的。
 
# 3. 内存 调整 windows 2003无法启动 bug
- 原来内存为 2G，调整为4G,无法启动。
- 后来又调整为 3G，可以启动
- 经过学习，虚拟机使用的的芯片组为 pc-i440fx-7.2，这个是PCI总线，是老的芯片组，适合老的操作系统和轻便型VM。
- 另一种 是 Q35，总线是 pcie,现在芯片组。
- 下次可以尝试安装 windows 2003 x64 ,在 q35上，看能否支持 4G以上的内存。
- 仅仅进行测试，实际并不需要这么大的内存。

# 4. 内存 1G/3G, ballooning = 1
- 经过实验，windows 2003 支持  最小1G 内存，最大 3G 内存的方案。启动 ballooning = 1选项
- 这个方案目前看来，运行良好！
