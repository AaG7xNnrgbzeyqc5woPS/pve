# See: 
[PVE 部署虚拟机内部网络](https://invites.fun/d/25411)

# 一、笔记及要点：
## 1，安全的修改配置文件/etc/network/interfaces
- 进入目录 ```cd /etc/network/```
- 保存备份 ```cp interfaces interfaces.bak```
- 建立新的配置 ``` cp interfaces interfaces.new ```
- 编辑新的配置 ``` nano interfaces.new ```
- 使配置生效 ``` mv  interfaces.new interfaces```
- 重启网络服务：``` sudo systemctl restart networking```
- 查看网络接口ip ``` ip a ```


# 二、Debian Linux 网络配置指南

Debian Linux 的网络配置有多种方式，从传统的 /etc/network/interfaces 文件配置，到使用 NetworkManager 等工具进行图形化管理，再到使用 systemd-networkd 进行更现代化的配置。
## 1. 传统配置：/etc/network/interfaces

    优点： 配置简单直观，适合熟悉文本编辑的使用者。
    缺点： 配置较为繁琐，重启网络服务时可能需要手动干预。

示例配置：
```
auto eth0
iface eth0 inet static
    address 192.168.1.100
    netmask 255.255.255.0
    gateway 192.168.1.1

    配置说明：
        auto eth0：系统启动时自动启用 eth0 网卡。
        iface eth0 inet static：将 eth0 网卡设置为静态 IP。
        address：设置 IP 地址。
        netmask：设置子网掩码。
        gateway：设置默认网关。
```
应用示例：
```
    配置静态 IP： 如上示例所示。
    配置 DHCP： 将 inet static 改为 inet dhcp。
    配置多个网卡： 为每个网卡添加相应的配置段。
```
## 2. NetworkManager

    优点： 提供图形化界面，易于操作，支持多种连接方式（有线、无线）。
    缺点： 配置过于简单，对于复杂网络环境可能不够灵活。

使用方式：

    图形界面： 系统设置 -> 网络。
    命令行： 使用 nmcli 命令进行配置。

## 3. systemd-networkd

    优点： 配置灵活，支持多种网络配置方式，与 systemd 集成紧密。
    缺点： 配置语法较为复杂，需要熟悉 systemd 的配置方式。

配置文件路径： /etc/systemd/network/

示例配置：
```
[Match]
Name=eth0

[Network]
Address=192.168.1.100/24
Gateway=192.168.1.1
DNS=8.8.8.8
```
## 4. DNS 配置

    配置文件： /etc/resolv.conf
    示例：
```
nameserver 8.8.8.8
nameserver 8.8.4.4
```
5. 重启网络
```
    重启 NetworkManager： sudo systemctl restart NetworkManager
    重启网络服务： sudo systemctl restart networking
```
**其他配置**

    防火墙： 使用 ufw 或 iptables 配置防火墙。
    路由： 使用 ip route 命令配置路由。
    VPN： 根据 VPN 类型选择相应的客户端软件进行配置。

**注意事项**

    配置文件语法： 严格按照配置文件的语法格式进行配置，否则可能导致网络无法正常工作。
    服务重启： 配置完成后，务必重启相应的网络服务，使配置生效。
    网络设备名称： 不同系统中网络设备的名称可能不同，可以通过 ip link 命令查看。
    复杂网络环境： 对于复杂的网络环境，建议参考官方文档或寻求专业人士的帮助。

**更多信息**

    Debian 官方文档： https://www.debian.org/doc/manuals/debian-reference/ch05.zh-cn.html
    CSDN 博客： https://blog.csdn.net/qw6r5/article/details/121885393

如果您有更具体的问题，欢迎随时提出！

例如，您可以提出以下问题：

    我想配置静态 IP，应该怎么做？
    如何连接到无线网络？
    如何设置 DNS？
