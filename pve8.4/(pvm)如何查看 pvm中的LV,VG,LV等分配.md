<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# 如何查看 pvm中的LV,VG,LV等分配

在Linux系统中，查看LVM（逻辑卷管理器）中PV（物理卷）、VG（卷组）、LV（逻辑卷）的分配情况，可以使用以下命令：

## 查看物理卷（PV）

- `pvdisplay`：显示物理卷的详细信息，包括物理卷名、所属卷组、大小、已分配和空闲的物理扩展（PE）数量等。
- `pvdisplay -m /dev/sdX`：显示物理卷中物理扩展的使用分布情况，能看到哪些PE被分配给了哪个逻辑卷。

示例：

```bash
pvdisplay /dev/sda1
pvdisplay -m /dev/sda2
```


## 查看卷组（VG）

- `vgscan`：扫描系统中的所有卷组。
- `vgdisplay`：显示指定卷组的详细信息，包括卷组名称、包含的物理卷数量、总容量、已用和空闲容量、PE大小等。
- `vgs`：简洁地列出所有卷组的概要信息。

示例：

```bash
vgscan
vgdisplay BrinnattVg
vgs
```


## 查看逻辑卷（LV）

- `lvscan`：扫描并列出所有逻辑卷及其状态。
- `lvdisplay`：显示逻辑卷的详细信息，包括逻辑卷路径、名称、所属VG、大小、状态等。
- `lvs`：简洁地显示逻辑卷的概要信息。

示例：

```bash
lvscan
lvdisplay /dev/BrinnattVg/first_lv
lvs
```


## 设备文件位置

- 逻辑卷在 `/dev/<VG名>/` 目录下有对应的设备文件链接。
- `/dev/mapper/` 目录下也有对应的映射设备文件。

示例：

```bash
ls -l /dev/BrinnattVg/
ls -l /dev/mapper/
```


## 总结

- 物理卷（PV）是最底层的物理存储设备，通过`pvdisplay`查看。
- 卷组（VG）是将多个PV聚合起来的存储池，通过`vgdisplay`查看。
- 逻辑卷（LV）是从VG中分配的逻辑分区，通过`lvdisplay`查看。

这些命令可以帮助你清晰地查看LVM中各层级的空间分配和使用情况，便于管理和调整存储资源[^1][^3][^4][^8].

<div style="text-align: center">⁂</div>

[^1]: https://blog.csdn.net/xiezuoyong/article/details/106566644

[^2]: https://blog.csdn.net/u014774648/article/details/107056732

[^3]: https://www.cnblogs.com/guanghuiqq/p/13411859.html

[^4]: https://brinnatt.com/primary/第-6-章-linux-lvm-存储管理/

[^5]: http://kuring.me/post/lvm/

[^6]: https://zq99299.github.io/linux-tutorial/tutorial-basis/14/03.html

[^7]: https://docs.redhat.com/zh-cn/documentation/red_hat_enterprise_linux/8/html/configuring_and_managing_logical_volumes/managing-lvm-volume-groups_configuring-and-managing-logical-volumes

[^8]: https://www.cnblogs.com/chenmh/p/5107901.html

