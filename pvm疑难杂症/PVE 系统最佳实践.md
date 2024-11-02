# See:
- [PVE 系统最佳实践](https://tendcode.com/subject/article/pve-used/)

# DNS 设置：

    阿里：233.5.5.5
    阿里：233.6.6.6
    DNSPOD：119.29.29.29

# 删除 local-lvm 分区

PVE 系统在安装的时候默认会把储存划分为 local 和 local-lvm 两个块，实际上不需要，一般会把 local-lvm 删掉，把空间都合并到 local 里面。

参考文档：PVE虚拟机删除local-lvm分区
