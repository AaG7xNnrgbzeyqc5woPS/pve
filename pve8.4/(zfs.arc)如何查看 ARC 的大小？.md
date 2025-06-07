<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# 如何查看 ARC 的大小？

查看ZFS ARC（Adaptive Replacement Cache）大小的方法主要有以下几种：

## 1. 使用 `arcstat` 工具

`arcstat` 是一个专门用于监控ZFS ARC缓存状态的工具，可以实时显示ARC的使用情况，包括当前大小、命中率、MRU/MFU分布等。

安装后运行：

```bash
arcstat 1
```

每秒刷新一次，显示ARC的详细统计数据。

## 2. 查看 `/proc/spl/kstat/zfs/arcstats` 文件

Linux系统中，ZFS的ARC统计信息可以从该虚拟文件中读取：

```bash
cat /proc/spl/kstat/zfs/arcstats
```

其中字段 `size` 表示当前ARC缓存占用的内存大小，单位是字节。

## 3. 使用 `arc_summary.py` 脚本

这个Python脚本可以解析 `/proc/spl/kstat/zfs/arcstats` 并以更友好的格式显示ARC统计信息。

## 4. 通过系统监控工具查看内存使用

由于ARC占用的内存显示为“used”而非“cached”，可以通过 `htop`、`free` 等工具观察系统内存使用情况，结合ZFS ARC的最大限制参数判断当前ARC大小。

## 5. 查看和设置ARC最大/最小值（辅助理解）

- ARC最大值：`zfs_arc_max`，默认是系统内存的一半，可以通过命令查看或设置：

```bash
cat /sys/module/zfs/parameters/zfs_arc_max
```

- ARC最小值：`zfs_arc_min`，保证ARC的最小缓存大小。

这些参数帮助理解ARC的内存使用范围。

---

### 参考示例

查看当前ARC大小（字节）：

```bash
grep "^size" /proc/spl/kstat/zfs/arcstats
```

输出示例：

```
size 123456789
```

表示当前ARC占用约123MB内存。

---

综上，最直接查看ARC大小的方法是读取 `/proc/spl/kstat/zfs/arcstats` 中的 `size` 字段，或者使用 `arcstat` 工具获取实时详细信息[^1][^3][^6]。

<div style="text-align: center">⁂</div>

[^1]: https://201.ustclug.org/ops/storage/zfs/

[^2]: https://docs.oracle.com/cd/E56344_01/html/E53993/gjheb.html

[^3]: https://dapeng.li/learning/zfs/FreeBSDMastery：AdvancedZFS_%E7%AC%AC7%E7%AB%A0%EF%BC%9A%E7%BC%93%E5%AD%98.html

[^4]: https://blog.csdn.net/kyle__shaw/article/details/128194916

[^5]: https://wiki.archlinuxcn.org/wiki/ZFS

[^6]: https://wener.me/notes/os/linux/fs/zfs/faq

[^7]: https://docs.oracle.com/cd/E56344_01/html/E53993/gjhec.html

[^8]: https://blog.csdn.net/fengidea/article/details/142318376

[^9]: https://www.rockylinux.cn/notes/diy-nas-xi-lie-11-zfs-xing-neng-jian-kong-yu-guan-li.html

