# See:
- [PVE单节点修改名称和IP地址](https://cloud.tencent.com/developer/article/2007992)

# PVE单节点修改名称和IP地址
- **对于集群中的节点，建议不要修改其名称或IP地址。**

有些时候，我们可能会想要修改PVE的主机名或者IP地址，如果你的PVE只是单个节点，还是很容易的。步骤如下：

  1，   修改配置文件
    更改主机名需要修改至少两个配置文件：
    /etc/hostname
    /etc/hosts
    还有一个涉及邮件服务器的，可以让PVE把报警信息发到自己的邮箱：
    /etc/postfix/main.cf
2，
