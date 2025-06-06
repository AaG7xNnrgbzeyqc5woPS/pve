<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# 我想知道硬盘的smart功能是否打开，是用什么指令呢？

你可以使用以下命令查看硬盘的SMART功能是否开启：

```bash
smartctl -i /dev/sdX
```

其中 `/dev/sdX` 是你的硬盘设备名（如 `/dev/sda`）。执行后，输出中会有一行类似：

```
SMART support is: Enabled
```

表示SMART功能已开启；如果显示 `Disabled`，则表示未开启。

如果SMART未开启，可以用以下命令启用：

```bash
smartctl --smart=on --offlineauto=on --saveauto=on /dev/sdX
```


---

### 相关命令总结

| 命令 | 作用 |
| :-- | :-- |
| `smartctl -i /dev/sdX` | 查看硬盘信息及SMART是否开启 |
| `smartctl -a /dev/sdX` | 查看硬盘全部SMART信息 |
| `smartctl -H /dev/sdX` | 快速查看硬盘健康状态 |
| `smartctl --smart=on /dev/sdX` | 启用硬盘SMART功能 |


---

这些命令均来自Linux常用的smartmontools工具包，适用于绝大多数支持SMART的硬盘[^1][^2][^3][^7]。

<div style="text-align: center">⁂</div>

[^1]: https://ticket.tieten.cn/kb/zh-cn/20-/174-linux-smartctl-s-m-a-r-t

[^2]: https://www.cnblogs.com/fiberhome/p/8275961.html

[^3]: https://blog.csdn.net/HuDi_2017/article/details/121184359

[^4]: https://blog.csdn.net/m0_63331248/article/details/140575992

[^5]: https://www.bookstack.cn/read/linux-command-1.14-zh/command-smartmontools.md

[^6]: https://github.com/LCTT/TranslateProject/blob/master/published/201412/20141017 How to check hard disk health on Linux using smartmontools.md

[^7]: https://cloud.tencent.com/developer/article/2156629

[^8]: https://my.oschina.net/emacs_8757573/blog/17192470

[^9]: https://www.cnblogs.com/klb561/p/9157537.html

