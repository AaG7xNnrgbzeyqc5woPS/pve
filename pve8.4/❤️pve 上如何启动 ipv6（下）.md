# pve动态获取ipv6（适合家宽动态前缀）
方式一：修改内核参数启用SLAAC自动配置

1. **查看当前内核参数：**
```
cat /proc/sys/net/ipv6/conf/vmbr0/accept_ra
cat /proc/sys/net/ipv6/conf/vmbr0/autoconf
cat /proc/sys/net/ipv6/conf/vmbr0/forwarding
```
将accept_ra设置为2以启用SLAAC：

2. **编辑 /etc/sysctl.conf，添加：**
```
net.ipv6.conf.all.accept_ra=2
net.ipv6.conf.default.accept_ra=2
net.ipv6.conf.vmbr0.accept_ra=2
net.ipv6.conf.all.autoconf=1
net.ipv6.conf.default.autoconf=1
net.ipv6.conf.vmbr0.autoconf=1
```

3. **运行 sysctl -p 或重启主机使配置生效**

# 测试：
- pve2服务器测试成功！
- 经过研究，pve1服务器也是用这个技术，也能获取ipv6
- ❤️注释：一定要重启主机，才能使用 ip -6 a 命令查看到 有效的 ip6 地址。

