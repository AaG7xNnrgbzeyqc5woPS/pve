<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>
# 测试：
```
 ip -4 a
```
可以看到 zerotier 接口

# pve 的容器内如何安装zerotier

在 Proxmox VE (PVE) 的容器（尤其是 LXC 容器）内安装并运行 ZeroTier，步骤和注意事项如下：

## 1. ❤️容器类型和配置准备

- 建议使用 **非特权（unprivileged）** LXC 容器，且模板选择 Debian 11（bullseye）等主流 Linux 发行版，网卡名称最好保持为 `eth0`，方便后续配置[^4]。
- 由于 ZeroTier 需要访问 TUN 设备，必须确保宿主机和容器配置支持 `/dev/net/tun` 设备。
- 在 PVE 宿主机上，编辑容器配置文件 `/etc/pve/lxc/<容器ID>.conf`，添加允许访问 TUN 设备的权限，例如（PVE 7.0及以上版本）：

```
lxc.cgroup2.devices.allow: c 10:200 rw
lxc.mount.entry: /dev/net/tun dev/net/tun none bind,create=file
```

这一步是解决容器内 ZeroTier 一直显示 OFFLINE 的关键[^3][^9]。
- 宿主机开启 IP 转发：

```
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.forwarding=1
```

并将其写入 `/etc/sysctl.conf` 以持久化[^4]。
```
nano /etc/sysctl.conf 最后添加下面两行：
net.ipv4.ip_forward=1
net.ipv6.conf.all.forwarding=1
```


## 2. 容器内安装 ZeroTier

- 进入容器终端，更新软件源，安装必要依赖：

```
apt update
apt install -y curl gnupg iptables iptables-persistent
```

- 使用官方一键安装脚本安装 ZeroTier：

```
curl -s https://install.zerotier.com/ | bash
```

安装成功后，会显示类似：

```
*** Success! You are ZeroTier address [ 19f34350c3 ].
```

这个地址类似于设备的虚拟 MAC 地址[^1][^2][^4][^5]。


## 3. 启动并设置 ZeroTier 服务自启动

- 启动 ZeroTier 服务：

```
systemctl start zerotier-one.service
```

- 设置开机自启：

```
systemctl enable zerotier-one.service
```

- 检查服务状态确认是否正常运行：

```
systemctl status zerotier-one.service
```

如果启动失败，确认容器配置是否正确，特别是 TUN 设备权限[^1][^2][^4][^5]。


## 4. 加入 ZeroTier 网络

- 使用命令加入你的 ZeroTier 网络：

```
zerotier-cli join <NETWORK_ID>
```

- 登录 ZeroTier Central 管理后台，授权该容器加入网络，分配 IP 地址[^1][^2][^4][^5]。


## 5. 其他注意事项

- 如果容器内 ZeroTier 显示离线（OFFLINE），通常是因为容器缺少对 `/dev/net/tun` 的访问权限，或者网络配置不正确，需要回到宿主机配置文件中确认权限设置[^3][^9]。
- 在容器中配置好后，ZeroTier 网络内的其他设备即可通过分配的虚拟 IP 访问该容器服务，实现内网穿透。
- 若需要实现更复杂的 site-to-site 网络，还可以参考官方文档和相关博客进行路由配置[^4]。

---

综上，PVE 容器内安装 ZeroTier 的关键是：

- 修改容器配置文件，允许访问 TUN 设备。
- 容器内安装依赖并运行官方安装脚本。
- 启动并自启 ZeroTier 服务。
- 加入并授权 ZeroTier 网络。

这样即可在 PVE 的 LXC 容器中正常使用 ZeroTier，实现内网穿透和虚拟网络连接[^1][^2][^3][^4][^5][^8][^9]。

<div style="text-align: center">⁂</div>

[^1]: https://blog.csdn.net/hlz_07/article/details/122229311

[^2]: https://blog.csdn.net/Rickest_man/article/details/141288668

[^3]: https://www.icoeus.com/archives/lxc-container-under-pve-zerotier-is-always-offline

[^4]: https://isay.me/2023/07/pve-lxc-enable-zerotier-site-to-site-networking.html

[^5]: https://pve.sqlsec.com/8/2/

[^6]: https://willxup.top/archives/build-zerotier

[^7]: https://github.com/xubiaolin/docker-zerotier-planet

[^8]: https://www.leftso.com/article/2312151546398065.html

[^9]: https://www.bilibili.com/read/cv17658295/

[^10]: https://www.cxthhhhh.com/2020/11/09/enable-tun-port-on-lxc-container-in-proxmox-and-solve-problems-such-as-zerotier-and-openvpn-that-need-tun-br.html

