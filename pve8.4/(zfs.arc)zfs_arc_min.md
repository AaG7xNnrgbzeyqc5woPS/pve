<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# zfs_arc_min

`zfs_arc_min` 是ZFS ARC缓存的**最小大小限制**，表示ARC缓存不会缩小到该值以下，即使系统内存压力较大时也会保留至少这么多内存用于缓存。

### 关键点总结

- **默认值**：通常是系统物理内存的1/32或64MB（较大者），例如16GB内存时，默认约为512MB左右[^3][^7]。
- **作用**：保证ARC缓存的下限，避免缓存被完全释放，保持一定缓存性能。
- **不可动态调整**：`zfs_arc_min` 不是动态参数，修改后需重启系统才能生效[^3]。
- **设置注意**：
    - 不建议随意调高`zfs_arc_min`，因为这会限制ARC在内存紧张时收缩，可能导致系统内存压力加大。
    - 如果设置`zfs_arc_min`过高，且高于`zfs_arc_max`，会导致`zfs_arc_max`设置失效，系统忽略`zfs_arc_max`[^1][^5]。
    - 需要保证 `zfs_arc_min < zfs_arc_max`，否则`zfs_arc_max`不会生效。
- **调整场景**：只有在特殊需求下（如对缓存性能有严格要求且内存充足）才考虑调整。


### 具体示例（Proxmox VE环境）

假设你有16GB内存，想设置ARC最大为4GB（`zfs_arc_max=4294967296`），则`zfs_arc_min`应设置为小于4GB的值，比如1GB（`zfs_arc_min=1073741824`），确保两者配合生效[^1][^5]。

### 设置方法

在 `/etc/modprobe.d/zfs.conf` 添加：

```
options zfs zfs_arc_min=1073741824
options zfs zfs_arc_max=4294967296
```

然后更新initramfs并重启：

```bash
update-initramfs -u
reboot
```


---

### 总结

| 参数 | 说明 | 默认值（16GB内存示例） | 注意事项 |
| :-- | :-- | :-- | :-- |
| zfs_arc_min | ARC缓存最小大小，硬限制 | 约512MB | 不宜过高，必须小于zfs_arc_max |
| zfs_arc_max | ARC缓存最大大小 | 系统内存的1/2左右 | 必须大于zfs_arc_min，否则无效 |

合理设置`zfs_arc_min`和`zfs_arc_max`，能保证ZFS缓存性能和系统内存使用的平衡，避免缓存占用过多内存或缓存缩小过度影响性能。

<div style="text-align: center">⁂</div>

[^1]: https://forum.proxmox.com/threads/pve-6-0-unable-to-set-zfs_arc_max-value-below-4gbs.59235/

[^2]: https://www.reddit.com/r/zfs/comments/1jlicqp/can_zfs_arc_max_be_made_strict_as_in_never_use/

[^3]: https://docs.oracle.com/en/operating-systems/solaris/oracle-solaris/11.4/tuning/zfs_arc_min-parameter.html

[^4]: https://www.truenas.com/community/threads/zfs-tune-zfs_arc_min-zfs_arc_max.99361/

[^5]: https://pve.proxmox.com/wiki/ZFS_on_Linux

[^6]: https://www.claudiokuenzler.com/blog/451/solaris-how-to-limit-zfs-arc-cache-max-size

[^7]: https://docs.oracle.com/cd/E26505_01/html/E37386/chapterzfs-3.html

[^8]: https://openzfs.github.io/openzfs-docs/Performance and Tuning/Module Parameters.html

