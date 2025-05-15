<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# pve 上如何启动 ipv6

在Proxmox VE（PVE）上启动和配置IPv6，主要有以下几种方法，适用于动态获取和静态配置IPv6地址：

## 1. 通过PVE Web界面配置IPv6

- 进入PVE的Web UI，路径为“系统 -> 网络”。
- 选择对应的网络接口（如vmbr0），可以直接设置静态IPv6地址和网关。
- 修改后点击“应用配置”，等待几分钟后即可生效。
- 使用命令 `ip -6 a show vmbr0` 查看IPv6地址是否获取成功[^1][^3]。


## 2. 动态获取IPv6（适合家宽动态前缀）

### 方式一：修改内核参数启用SLAAC自动配置

- 查看当前内核参数：

```
cat /proc/sys/net/ipv6/conf/vmbr0/accept_ra
cat /proc/sys/net/ipv6/conf/vmbr0/autoconf
cat /proc/sys/net/ipv6/conf/vmbr0/forwarding
```

- 将accept_ra设置为2以启用SLAAC：

编辑 `/etc/sysctl.conf`，添加：

```
net.ipv6.conf.all.accept_ra=2
net.ipv6.conf.default.accept_ra=2
net.ipv6.conf.vmbr0.accept_ra=2
net.ipv6.conf.all.autoconf=1
net.ipv6.conf.default.autoconf=1
net.ipv6.conf.vmbr0.autoconf=1
```

- 运行 `sysctl -p` 或重启主机使配置生效[^1][^5]。


### 方式二：修改网络接口配置文件启用DHCPv6和SLAAC

- 复制网络配置文件：

```
cp /etc/network/interfaces /etc/network/interfaces.new
```

- 编辑 `/etc/network/interfaces.new`，在对应网桥接口（如vmbr0）添加：

```
iface vmbr0 inet6 dhcp
request_prefix 1
accept_ra 2
```

- 在PVE Web UI“系统 -> 网络”刷新并应用配置，等待几分钟后获取IPv6地址[^1][^2]。


## 3. 静态IPv6配置示例

- 在PVE Web UI或 `/etc/network/interfaces` 中为网桥接口添加类似：

```
iface vmbr0 inet6 static
address 1:2:3:4::a/64
gateway 1:2:3:4::1
```

- 保存并应用配置后，验证IPv6连通性：

```
ping6 2001:4860:4860::8888
```

- 也可以配置IPv6转发和NDP代理以支持虚拟机IPv6访问[^3]。


## 4. 其他注意事项

- PVE默认不支持通过DHCPv6/SLAAC获取IPv6地址，需要手动配置。
- 修改后建议重启网络或主机，确保配置生效。
- 配置过程中建议保留物理访问（键盘和显示器），以防网络配置错误导致无法远程访问[^2]。
- 对于虚拟机，直接桥接到vmbr0后，虚拟机可配置独立IPv6地址实现公网访问[^3]。

综上，启动PVE上的IPv6主要是通过启用内核的accept_ra参数为2，配置网桥接口支持DHCPv6/SLAAC获取IPv6地址，或直接静态配置IPv6地址，并在PVE Web UI中应用网络配置即可生效[^1][^2][^3][^5]。

<div style="text-align: center">⁂</div>

[^1]: https://www.icn.ink/pve/57.html

[^2]: https://cokebar.info/archives/2738

[^3]: https://dallas.lu/zh-CN/pve-network-manual-config-and-ipv6/

[^4]: https://pve.sqlsec.com/8/3/

[^5]: https://www.cnblogs.com/jackadam/p/16143068.html

[^6]: https://www.mbrjun.cn/archives/418/

[^7]: https://blog.csdn.net/qq_36154886/article/details/136383646

[^8]: https://blog.skyju.cc/post/proxmox-ipv4-nat-ipv6/

