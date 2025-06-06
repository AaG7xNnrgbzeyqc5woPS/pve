<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# 如何配置ZFS存储区支持备份功能而不限制为只存放镜像和容器

要让Proxmox VE中的ZFS存储区不仅能存放虚拟机磁盘（disk image）和容器（container），还能用作备份存储（backup），需要避免直接将ZFS池作为`zfspool`类型存储使用，因为这种类型默认只支持`images`和`rootdir`内容，不支持`backup`。正确做法是：

## 关键思路

- **在ZFS池中创建一个专用的dataset（子文件系统）用于备份存储**，该dataset挂载为普通目录。
- **在Proxmox中以目录（dir）类型添加该挂载目录为存储**，并设置`content`包含`backup`。
- 这样既利用了ZFS的底层性能和特性，也满足Proxmox备份存储对目录类型的需求。

---

## 具体配置步骤

### 1. 在ZFS池中创建备份dataset

假设ZFS池名为`tank`，执行：

```bash
zfs create tank/backup
```

确认挂载点（默认挂载在`/tank/backup`）：

```bash
zfs get mountpoint tank/backup
```

如果需要自定义挂载点，比如`/mnt/tank_backup`，执行：

```bash
zfs set mountpoint=/mnt/tank_backup tank/backup
```

确保挂载点目录存在且权限正确。

### 2. 在Proxmox中添加目录类型存储

编辑`/etc/pve/storage.cfg`，添加如下内容：

```
dir: tank-backup
    path /mnt/tank_backup
    content backup
    maxfiles 3
    shared 0
    is_mountpoint 1
```

- `dir`类型支持存放备份文件。
- `content backup`允许存储备份数据。
- `path`指向ZFS dataset挂载目录。

保存后，Proxmox会自动识别该存储。

### 3. 在Web界面使用新备份存储

- 在Proxmox Web界面“数据中心”->“存储”确认`tank-backup`已显示。
- 创建备份任务时选择`tank-backup`作为备份目标。

---

## 说明与建议

- 直接将ZFS池作为`zfspool`类型存储时，Proxmox只支持`images`和`rootdir`，不支持`backup`。
- 备份文件是普通文件，必须存放在目录类型存储中。
- 通过创建ZFS子文件系统（dataset）并挂载为目录，再以`dir`类型添加存储，既能利用ZFS优势，又支持备份。
- 你也可以对该dataset设置ZFS特性（如压缩、快照等）以优化性能和空间。

---

## 参考

- Proxmox官方文档关于ZFS存储配置，示例中`zfspool`只支持`rootdir,images`内容类型[^6]。
- ZFS文件系统管理建议创建多个dataset以便管理和维护[^4]。
- 备份存储必须是目录类型，支持`backup`内容。

---

通过以上配置，ZFS存储区即可支持备份功能，不再局限于只存放镜像和容器。

<div style="text-align: center">⁂</div>

[^1]: https://blog.csdn.net/2501_91590464/article/details/148207652

[^2]: https://docs.oracle.com/cd/E19253-01/819-7065/819-7065.pdf

[^3]: https://www.amazonaws.cn/articles/storage/how-to-build-a-shared-file-storage-systems-zfs-storage-architecture-practice/

[^4]: https://201.ustclug.org/ops/storage/zfs/

[^5]: https://blog.csdn.net/styshoo/article/details/62033880

[^6]: https://pve-doc-cn.readthedocs.io/zh_CN/latest/chapter_storage/zfsstorage.html

[^7]: https://documentation.suse.com/zh-cn/sles/15-SP6/single-html/SLES-storage/index.html

[^8]: https://docs.oracle.com/cd/E24847_01/pdf/819-7065.pdf

[^9]: https://www.qnap.com.cn/zh-cn/product/tvs-h674

[^10]: https://www.amazonaws.cn/articles/storage/how-to-build-a-storage-system/

