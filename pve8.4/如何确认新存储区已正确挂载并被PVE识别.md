<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# 如何确认新存储区已正确挂载并被PVE识别

要确认Proxmox VE（PVE）中新建的存储区是否已正确挂载并被系统识别，可以按照以下步骤操作：

## 1. 通过PVE Web界面确认存储状态

- 登录PVE Web管理界面，进入“数据中心”->“存储”页面。
- 查看新建存储的列表，确认该存储是否显示为“已启用”状态，且路径和类型正确。
- 检查存储的“内容类型”（Content）是否包含你期望的内容（如`backup`、`images`、`iso`等），确保支持你需要的用途。


## 2. 在PVE主机上检查存储挂载情况

通过SSH登录到PVE主机，执行以下命令确认存储设备和挂载点：

- 查看系统识别的磁盘设备：

```bash
lsblk
```

- 查看存储设备的挂载情况：

```bash
df -h
mount | grep <存储路径>
```

- 如果是新加的物理硬盘或分区，确认是否已格式化并挂载到预期目录。


## 3. 检查PVE存储配置文件

- 查看PVE存储配置文件`/etc/pve/storage.cfg`，确认新存储的配置项存在且正确，例如：

```
dir: backup-storage
    path /mnt/backup
    content backup
    maxfiles 3
```

- 如果是网络存储（如NFS），确认服务器地址和挂载路径正确。


## 4. 手动测试挂载点读写权限

- 进入挂载目录，尝试创建临时文件测试权限：

```bash
cd /mnt/backup
touch testfile
ls -l testfile
rm testfile
```

- 如果无法写入，说明权限或挂载参数需要调整。


## 5. 确认PVE识别存储状态

- 使用PVE命令查看存储状态：

```bash
pvesm status
```

- 该命令会列出所有存储及其状态，确认新存储显示为`active`。

---

以上步骤能帮助你确认新存储区是否已被PVE正确识别和挂载。如果发现存储未挂载或权限不足，需根据具体情况：

- 格式化磁盘并挂载（如`mkfs.ext4 /dev/sdb1`，`mount /dev/sdb1 /mnt/backup`）
- 修改`/etc/fstab`实现开机自动挂载
- 调整目录权限（如`chown -R root:www-data /mnt/backup`，`chmod`等）

这些操作完成后，PVE才能正常使用该存储进行虚拟机备份或其他用途[^1][^4][^5]。

<div style="text-align: center">⁂</div>

[^1]: https://bbs.sangfor.com.cn/forum.php?mod=viewthread\&tid=128929

[^2]: https://thiscute.world/posts/proxmox-virtual-environment-instruction/

[^3]: https://foxi.buduanwang.vip/virtualization/1754.html/

[^4]: https://club.fnnas.com/forum.php?mod=viewthread\&tid=14408

[^5]: https://cloud.tencent.com/developer/article/2042971

[^6]: https://201.ustclug.org/ops/storage/lvm/

[^7]: http://104.194.87.108/pve/pve-admin-guide-cn.html

[^8]: https://ask.csdn.net/questions/8300639

[^9]: https://pve-doc-cn.readthedocs.io/_/downloads/zh-cn/latest/pdf/

[^10]: https://dl.dell.com/manuals/all-products/esuprt_ser_stor_net/esuprt_powerconnect/powerconnect-m6220_user's%20guide_zh-cn.pdf

