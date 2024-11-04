# See:
- [PVE单节点修改名称和IP地址](https://cloud.tencent.com/developer/article/2007992)

# PVE单节点修改名称和IP地址
- **对于集群中的节点，建议不要修改其名称或IP地址。**

有些时候，我们可能会想要修改PVE的主机名或者IP地址，如果你的PVE只是单个节点，还是很容易的。步骤如下：

## 1， ❤️  修改配置文件
    更改主机名需要修改至少两个配置文件：
    ```
    /etc/hostname
    /etc/hosts
    ```
    还有一个涉及邮件服务器的，可以让PVE把报警信息发到自己的邮箱：
    ```
    /etc/postfix/main.cf
    ```
## 2，修改IP地址
更改IP地址需要修改至少两个配置文件：
```
/etc/hosts
/etc/network/interfaces（可以在web界面下修改）
```
## 3,修改主机登录信息
- 上面的/etc/hostname，  /etc/hosts 修改后，主机的欢迎信息自动修改好了。
- 直接修改 /etc/issue反而没有用，会被pve自动又改回原来的名字。应该是pve内部有些自动机制。
