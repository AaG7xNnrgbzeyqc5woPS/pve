- [PVE8修改软件仓库源和 CT模板（LXC）源为国内源](https://www.dgpyy.com/archives/174/)

# 替换 apt 软件源
1. 更新证书  
替换前建议先更新下证书，否则可能由于证书不可用导致 https 无法使用，进而无法下载所有软件  
```
sudo apt install apt-transport-https ca-certificates
```
2. 替换通用软件源  
首先替换通用软件源， Debian 的软件源配置文件是 /etc/apt/sources.list    
备份后输入以下命令直接填充  
```
# mirrors.utsc.edu.cn
# Downlaod and Install debian 12 sourcelist
curl -fsSL https://mirrors.ustc.edu.cn/repogen/conf/debian-https-4-bookworm -o  /etc/apt/sources.list
```
3. 替换pve软件源  
之后替换 pve 软件源  
pve 镜像默认的 pve 软件源配置文件是 /etc/apt/sources.list.d/pve-enterprise.list  
备份后将其中内容替换为以下即可：  
```
nano /etc/apt/sources.list.d/pve-enterprise.list
#修改成以下内容
deb https://mirrors.ustc.edu.cn/proxmox/debian bookworm pve-no-subscription
```
4. 安装软件源密钥  
完成之后运行以下指令把软件源的密钥安装一下  
```
#Downlaod and install gpg key
wget https://mirrors.ustc.edu.cn/proxmox/debian/proxmox-release-bookworm.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg
```

5. PVE ceph源  
编辑 PVE ceph 源 配置文件是 /etc/apt/sources.list.d/ceph.list

```
nano /etc/apt/sources.list.d/ceph.list
# 改成如下内容
deb https://mirrors.ustc.edu.cn/proxmox/debian/ceph-quincy bookworm no-subscription

```

然后就可以愉快的更新软件源了  
```
apt update
```


# 修改 CT Templates (LXC 容器) 源  

将 /usr/share/perl5/PVE/APLInfo.pm 文件中  
默认的源地址 http://download.proxmox.com   
替换为 https://mirrors.tuna.tsinghua.edu.cn/proxmox即可  
```
cp /usr/share/perl5/PVE/APLInfo.pm /usr/share/perl5/PVE/APLInfo.pm_back
sed -i 's|http://download.proxmox.com|https://mirrors.ustc.edu.cn/proxmox|g' /usr/share/perl5/PVE/APLInfo.pm
```
针对 /usr/share/perl5/PVE/APLInfo.pm 文件的修改，重启后生效
```
systemctl restart pvedaemon.service
```

之后在 pve 网页端下载 CT Templates 速度就很快了。

Enjoy!
