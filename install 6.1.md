
## 1. 下载 
    https://www.proxmox.com/en/downloads  
    下载 Proxmox VE 6.1 ISO Installer  
    或者: Proxmox VE 6.1 ISO Installer (BitTorrent)  
    推荐用 qBittorrent 下载,速度非常快.  
  
## 2,校验和  
    https://www.proxmox.com/en/downloads/item/proxmox-ve-6-1-iso-installer-bittorrent  
    https://www.proxmox.com/en/downloads/item/proxmox-ve-6-1-iso-installer  
    两种方法下载的 iso文件的校验和应该是一样的  
    SHA256SUMS for the ISO:  
       95434b81cf74fdb5f8ac3e341c55293e10dafd1a75d1be45668ccb25f7d3c93c  
     
## 3. 检查校验和
    https://pve.proxmox.com/wiki/Central_Web-based_Management  
    使用下面的命令计算proxmox-ve_6.1-1.iso的校验和   
    $ sha256sum proxmox-ve_6.1-1.iso   
    $ 95434b81cf74fdb5f8ac3e341c55293e10dafd1a75d1be45668ccb25f7d3c93c  proxmox-ve_6.1-1.iso  
    这个校验和 同上面的对比,一模一样.校验成功!  
    
    注释: 
      我在下载时候,第一次计算的,结果同官网上的不一样,
      最后 使用 qBittorrent 的 force recheck命令,
      再做 sha256sum计算,校验和就正确啦.   
      也是第一次使用 qBittorrent 工具, 下载没有完全成功也看不出来.   
      再一次强调了, 使用 sha256sum验证校验和是多么重要.  
      
## 4. 制作pve的安装U盘  
    参考:  
    https://pve.proxmox.com/wiki/Install_from_USB_Stick  
    
    a. use:  dd if=proxmox-ve_6.1-1.iso of=/dev/XYZ bs=1M  
       in my computer: XYZ=sdb  
    b.  other way:  
      use etcher flash proxmox-ve_6.1-1.iso to usb stick  
      please note: In arch and manjaro etcher is name:  
      balenaEtcher  
      balena-Etcher 
      balena Etcher    
    
    
## 5. 安装  
     参考:  
     https://pve.proxmox.com/wiki/Quick_installation  
   
## 6. 管理:
     Central Web-based Management  
     https://pve.proxmox.com/wiki/Central_Web-based_Management  
      

