<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# pve 时间同步

Proxmox VE（PVE）时间同步主要依赖于网络时间协议（NTP）服务，确保集群中所有节点时间精确同步，这对集群稳定和某些组件（如Ceph）正常运行至关重要。以下是PVE时间同步的关键点和配置方法：

## 1. PVE时间同步的重要性

- PVE集群堆栈依赖所有节点时间的精确同步，时间不同步会导致集群组件异常，影响备份任务和日志时间准确性[^5]。


## 2. 时间同步工具

- 从Proxmox VE 7开始，默认使用`chrony`作为NTP守护程序，PVE 6及之前版本使用`systemd-timesyncd`。
- 也可以选择安装`ntp`或`openntpd`作为时间同步工具[^5]。


## 3. 配置时间同步的步骤

### 设置时区

- 在PVE节点上设置正确的时区，例如`Asia/Shanghai`：

```bash
timedatectl set-timezone Asia/Shanghai
```

- 确保硬件时钟与系统时钟同步：

```bash
hwclock -w
```


### 配置NTP服务器

- 编辑`chrony`配置文件`/etc/chrony/chrony.conf`，添加可信赖的NTP服务器。例如使用阿里云NTP服务器：

```
server ntp1.aliyun.com iburst
server ntp2.aliyun.com iburst
server ntp3.aliyun.com iburst
```

- 如果使用`systemd-timesyncd`，编辑`/etc/systemd/timesyncd.conf`，指定NTP服务器：

```
[Time]
NTP=ntp1.aliyun.com ntp2.aliyun.com ntp3.aliyun.com
```


### 启用并重启时间同步服务

- 对于chrony：

```bash
systemctl restart chronyd
```

- 对于systemd-timesyncd：

```bash
systemctl restart systemd-timesyncd
timedatectl set-ntp true
```


### 验证时间同步状态

- 查看chrony同步状态：

```bash
chronyc sources -v
chronyc tracking
```

- 查看systemd-timesyncd状态：

```bash
timedatectl status
systemctl status systemd-timesyncd
```


## 4. PVE集群内网时间同步方案

- 如果PVE集群处于独立内网且无法访问外网，可搭建内网NTP服务器（例如使用Debian虚拟机安装chrony），配置为内网时间源，允许集群内节点访问：

```
allow 192.168.122.0/24
local stratum 10
```

- PVE节点配置指向该内网NTP服务器，实现集群时间统一[^3][^4][^6]。


## 5. Windows客户机时间同步

- 对于连接PVE虚拟机的Windows客户机，需根据Windows版本调整启动参数或配置，以保证时间同步生效[^1]。


## 6. 常见问题及注意事项

- 确保PVE节点网络正常，DNS配置正确（如使用8.8.8.8或114.114.114.114），否则NTP服务器无法访问导致时间同步失败[^2]。
- 不要同时启用多个时间同步工具，避免冲突。
- 配置后务必重启对应服务，确保配置生效。
- 查看同步日志确认服务器是否正常工作。

---

综上，PVE时间同步主要通过配置`chrony`或`systemd-timesyncd`，指定可靠的NTP服务器，设置正确时区，确保网络连通性，并重启服务实现。对于内网环境，可搭建本地NTP服务器供集群内部同步，保证所有节点时间一致，提升集群稳定性和功能正常运行[^1][^2][^3][^4][^5][^6]。

<div style="text-align: center">⁂</div>

[^1]: https://duckgle.in/posts/PVE时间同步/

[^2]: https://blog.imbhj.com/archives/ah0qTDuT

[^3]: https://foxi.buduanwang.vip/virtualization/pve/kb/3316.html/

[^4]: https://www.280i.com/tech/11956.html

[^5]: https://waylee.net/pve/chapter_system_administration/timesync.html

[^6]: https://www.cnblogs.com/lovesKey/p/15951162.html

[^7]: https://dongrenwen.github.io/2020/03/16/lxc-install-ntp/

[^8]: https://blog.passall.us/archives/946

[^9]: http://www.bilibili.com/read/cv41363027/

