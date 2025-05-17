# See：
 - [Linux (DEB/RPM)](https://www.zerotier.com/download/#linux)

# install

If you have GPG installed, a more secure option is available:
```
curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/main/doc/contact%40zerotier.com.gpg' | gpg --import &amp;&amp; \
if z=$(curl -s 'https://install.zerotier.com/' | gpg); then echo "$z" | sudo bash; fi
```
After using the script, use apt or yum to manage future updates to zerotier-one.

# Test
- 上面的一键脚本不好调试，我们可以分开实验

## 1. 测试下载 gpg文件
```
  curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/main/doc/contact%40zerotier.com.gpg'
```
测试成功，屏幕可以看到 gpg 数据，最后以 ```-----END PGP PUBLIC KEY BLOCK-----```结束  
不需要翻墙就可以下载数据

## 2. 安装gpg
```
  curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/main/doc/contact%40zerotier.com.gpg' | gpg --import
```
导入成功！
```
root@pve2-ct-base:~# curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/main/doc/contact%40zerotier.com.gpg' | gpg --import
gpg: /root/.gnupg/trustdb.gpg: trustdb created
gpg: key 1657198823E52A61: public key "ZeroTier, Inc. (ZeroTier Support and Release Signing Key) <contact@zerotier.com>" imported
gpg: Total number processed: 1
gpg:               imported: 1

```

## 3. 安装 zerotier
```
  if z=$(curl -s 'https://install.zerotier.com/' | gpg); then echo "$z" | sudo bash; fi
```
经过测试安装成功！  
注释：pve8.4主机上使用这个命令，提示 sudo命令不存在，把sudo去掉就行，因为我们是用 root用户。

## 4. 使用命令 zerotier-cli info
验证zerotier 安装成功！

## 5. 更新
```
 apt update
 apt upgrade
```
使用上面的命令测试zerotier更新也是也可以的

