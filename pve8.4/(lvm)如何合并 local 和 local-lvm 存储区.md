<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# 如何合并 local 和 local-lvm 存储区

在Proxmox VE（PVE）中，默认安装会将存储划分为两个区域：`local`（目录类型，存放ISO、备份等文件）和`local-lvm`（LVM-thin类型，存放虚拟机磁盘镜像）。如果想合并这两个存储区，将`local-lvm`的空间释放并合并到`local`，可以按照以下步骤操作：

## 合并 local-lvm 到 local 的步骤

1. **备份虚拟机数据**
由于操作会删除`local-lvm`，务必先备份所有虚拟机数据，确保数据安全。
2. **迁移虚拟机磁盘**
如果有虚拟机磁盘存放在`local-lvm`，需先通过PVE界面将磁盘移动到`local`存储区，避免数据丢失。
3. **删除 local-lvm 逻辑卷**
使用SSH登录PVE服务器，执行以下命令删除`local-lvm`的逻辑卷（通常是`pve/data`）：

```bash
lvremove /dev/pve/data
```

系统会提示确认，输入`y`确认删除。
4. **将释放的空间合并到 local（pve-root）**
删除`local-lvm`后，空间会变为未分配，使用以下命令将其全部扩展到`local`所在的根分区（一般是`pve/root`）：

```bash
lvextend -rl +100%FREE /dev/pve/root
```

该命令会自动调整逻辑卷大小。
5. **扩展文件系统**
扩展完逻辑卷后，使用以下命令调整文件系统大小，使其使用新扩展的空间：

```bash
resize2fs /dev/mapper/pve-root
```

6. **通过PVE Web界面移除 local-lvm 存储配置**
登录PVE管理界面，进入“数据中心”->“存储”，找到`local-lvm`，选择删除移除该存储配置。
7. **编辑 local 存储配置，增加内容类型**
在PVE Web界面编辑`local`存储，勾选包括`images`、`rootdir`等内容类型，使其支持存放虚拟机磁盘和容器数据。
8. **验证空间合并**
使用命令`df -h`查看根分区空间，确认已成功扩展。也可在PVE界面确认`local`存储容量增加。

---

## 注意事项

- 操作前务必备份重要数据，避免误操作导致数据丢失。
- 确保虚拟机已关闭且磁盘已迁移，避免删除时丢失数据。
- 该操作适用于基于LVM的存储结构，且`local-lvm`是thin pool类型的情况。
- 操作完成后，`local`存储将包含所有虚拟机磁盘文件，便于文件直接访问和管理。

---

通过上述步骤，可以将`local-lvm`的空间释放并合并到`local`存储区，实现统一管理和更灵活的空间使用[^1][^2][^3][^4][^5][^6]。

<div style="text-align: center">⁂</div>

[^1]: https://blog.csdn.net/weixin_52960369/article/details/135450871

[^2]: https://www.cnblogs.com/xiykj/p/18182258

[^3]: https://alay.cc/417.html

[^4]: https://www.sakamoto.blog/proxmox-local-merge/

[^5]: https://blog.csdn.net/weixin_52626278/article/details/144147803

[^6]: https://www.cnblogs.com/txqdm/p/18515437

[^7]: https://www.reddit.com/r/Proxmox/comments/y4p6uz/no_space_in_locallvm_proxmox_help/?tl=zh-hans

[^8]: https://www.bilibili.com/video/BV171NXeDE9i/

