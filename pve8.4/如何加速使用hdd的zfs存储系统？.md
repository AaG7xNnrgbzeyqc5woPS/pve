<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# 如何加速使用hdd的zfs存储系统？

使用机械硬盘（HDD）的ZFS存储系统要提升性能，主要可以从以下几个方面入手：

## 1. 增加内存（RAM）以提升缓存能力

ZFS非常依赖内存来做ARC（Adaptive Replacement Cache）缓存，内存越大，缓存效果越好，能显著提升读性能和部分写性能。建议内存容量至少达到存储池容量的千分之一加1GB（n/1000+1GB），且越多越好[^3]。

## 2. 添加SSD作为缓存设备（L2ARC）和写日志设备（SLOG）

- **L2ARC缓存**：当内存ARC缓存满了，ZFS会将部分缓存数据写入SSD作为二级缓存，提升热数据的读取速度，减少机械盘负载[^3][^4]。
- **SLOG设备**：ZFS的ZIL（ZFS Intent Log）默认存储在主池中，会占用HDD带宽。通过添加专用的快速SSD作为SLOG设备，可以将ZIL写入SSD，显著降低写入延迟，提升同步写性能，特别是网络写入场景（如NFS、VMware）[^4][^5]。


## 3. 优化写入策略

- **关闭同步写入（sync=disabled）**：默认情况下，ZFS同步写入会等待数据真正写入磁盘才返回确认，这会降低写入速度。关闭同步写入可以提升写入性能（但降低数据安全性），适合对数据安全要求不高或有其他保障的场景。写入完成后建议恢复默认同步策略[^6]。
- **合理设置recordsize**：根据工作负载调整ZFS的recordsize（默认128KB），对于大文件可以增大recordsize，减少I/O次数；对于小文件则适当减小[^6]。


## 4. 增加磁盘数量和合理布局vdev

- 增加更多硬盘和vdev可以提升整体IOPS和带宽，ZFS能并行处理多个vdev的I/O，提升聚合性能。使用镜像vdev比RAID-Z写性能更好，但空间利用率较低[^3]。
- 保持池中有足够的空闲空间（建议至少20%空闲），避免写入时因空间不足导致随机写入性能下降[^3]。


## 5. 调整ZFS参数减少不必要的磁盘I/O

- 关闭访问时间更新（atime=off）减少不必要的写操作。
- 使用relatime减少访问时间戳更新频率[^8]。
- 调整primarycache和secondarycache属性，针对不同应用场景优化缓存策略[^8]。


## 6. 利用ZFS的写入聚合技术和TRIM支持

- 一些厂商（如QNAP）提供写入聚合（Write Coalescing）算法，减少随机写入次数，提升SSD和整体性能[^5]。
- 启用SSD TRIM功能，保持SSD性能，避免写入速度下降[^5]。

---

综上，针对HDD的ZFS系统加速建议重点是：

- **增加内存**，提升ARC缓存。
- **增加SSD做L2ARC和SLOG**，分别加速读取和同步写入。
- **合理调整写入同步策略和ZFS参数**，减少写入延迟和无效I/O。
- **增加磁盘数量和保持足够空闲空间**，提升整体吞吐。
- **关闭atime，启用relatime，调整缓存策略**，减少不必要的I/O。

这些措施结合起来，可以显著提升基于HDD的ZFS存储系统的性能[^3][^4][^5][^6][^8]。

<div style="text-align: center">⁂</div>

[^1]: https://www.reddit.com/r/zfs/comments/jwk3zj/can_i_use_zfs_to_speedup_file_writes/?tl=zh-hans

[^2]: https://www.reddit.com/r/zfs/comments/n35jde/how_to_speed_up_the_write_on_zfs/?tl=zh-hans

[^3]: https://blog.csdn.net/weixin_34092455/article/details/92211389

[^4]: https://blog.csdn.net/Jon_c/article/details/140518621

[^5]: https://www.qnap.com.cn/zh-cn/operating-system/quts-hero

[^6]: https://lishouzhong.com/article/note/zfs/zfs-技巧与知识/

[^7]: https://www.wolai.com/littlenewton/gJvungs54zWgZ3YfoXAvKW

[^8]: https://201.ustclug.org/ops/storage/zfs/

[^9]: https://www.oracle.com/a/ocom/docs/zs9-datasheet-zhs.pdf

[^10]: https://lug.ustc.edu.cn/planet/2024/12/ustc-mirrors-zfs-rebuild/

[^11]: https://www.oracle.com/a/ocom/docs/zs7-2-datasheet-cn.pdf

[^12]: https://www.chiphell.com/thread-2663304-1-1.html

