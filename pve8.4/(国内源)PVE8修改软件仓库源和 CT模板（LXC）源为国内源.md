# See：
- [PVE8修改软件仓库源和 CT模板（LXC）源为国内源](https://www.dgpyy.com/archives/174/)
- [Proxmox VE 8 换源 ](https://blog.fallenbreath.me/zh-CN/2023/pve8-change-sourceslist/)
- [中科大TurnKey Linux源](https://mirrors.ustc.edu.cn/help/turnkeylinux.html)
- ❤️[TurnKey Linux](https://mirrors.ustc.edu.cn/help/turnkeylinux.html)

# 一、 替换 apt 软件源
1. 更新证书
```
sudo apt install apt-transport-https ca-certificates
```

2. 更换通用源
```
# mirrors.utsc.edu.cn
# Downlaod and Install debian 12 sourcelist
curl -fsSL https://mirrors.ustc.edu.cn/repogen/conf/debian-https-4-bookworm -o  /etc/apt/sources.list
```

3. 替换 pve 软件源
```
nano /etc/apt/sources.list.d/pve-enterprise.list
#修改成以下内容
deb https://mirrors.ustc.edu.cn/proxmox/debian bookworm pve-no-subscription
```

4. 软件源的密钥安装
```
#Downlaod and install gpg key
wget https://mirrors.ustc.edu.cn/proxmox/debian/proxmox-release-bookworm.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg
```

5. 编辑 PVE ceph 源 配置文件是 /etc/apt/sources.list.d/ceph.list
```
nano /etc/apt/sources.list.d/ceph.list
# 改成如下内容
deb https://mirrors.ustc.edu.cn/proxmox/debian/ceph-quincy bookworm no-subscription
```
6. 然后就可以愉快的更新软件源了

# 二、修改 CT Templates (LXC 容器) 源
1. 将 /usr/share/perl5/PVE/APLInfo.pm 文件中默认的源地址 http://download.proxmox.com 替换为 https://mirrors.tuna.tsinghua.edu.cn/proxmox 即可。
```
cp /usr/share/perl5/PVE/APLInfo.pm /usr/share/perl5/PVE/APLInfo.pm_back
sed -i 's|http://download.proxmox.com|https://mirrors.ustc.edu.cn/proxmox|g' /usr/share/perl5/PVE/APLInfo.pm
```
2. 重启后生效
```
systemctl restart pvedaemon.service
```
之后在 pve 网页端下载 CT Templates 速度就很快了。

# 三、实验
- 1. 替换 apt 源都成功了。包括：通用源，pve源，ceph源
- 2. 修改 CT Templates (LXC 容器) 源第一次失败，经过研究后成功。需要注意以下两点
- 3. 手动修改时候， host 属性是不能修改的，只改 url
- 4. 需要整个服务器重启才行，只是 ```systemctl restart pvedaemon.service```不够的。


# 四、APLInfo.pm具体变更的内容如下所示
```
--- a/usr/share/perl5/PVE/APLInfo.pm.bak
+++ b/usr/share/perl5/PVE/APLInfo.pm
@@ -197,7 +197,7 @@ sub get_apl_sources {
     my $sources = [
        {
            host => "download.proxmox.com",
-           url => "http://download.proxmox.com/images",
+           url => "https://mirrors.ustc.edu.cn/proxmox/images",
            file => 'aplinfo-pve-8.dat',
        },
        {
```
注意这里的 host 属性是不能修改的，只改 url 就好

# 五、TurnKey Linux 源
- [中科大TurnKey Linux源帮助](https://mirrors.ustc.edu.cn/help/turnkeylinux.html)
- 看了帮助，非常麻烦，暂时不需要就不实验了。
- [PVE更换其他turnkeylinux源](http://zkeeer.space/?p=1020),这个方法比较简单，可以试试。经过测试，这个方案不行。
