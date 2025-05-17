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
