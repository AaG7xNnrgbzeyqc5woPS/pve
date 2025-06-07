<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# sync 命令的格式如何?

`sync`命令的基本格式如下：

```
sync [选项] [文件...]
```

常用选项包括：

- `-d` 或 `--data`：仅同步文件数据，不同步元数据（metadata）。
- `-f` 或 `--file-system`：同步包含指定文件的文件系统。
- `-q`：减少输出，只显示错误和警告信息。
- `-h` 或 `--help`：显示帮助信息。
- `-V` 或 `--version`：显示命令版本信息。

通常情况下，直接输入`sync`命令即可将所有文件系统缓冲区中的数据同步写入磁盘，例如：

```
sync
```

执行后，系统会等待所有数据写入完成才返回，且通常无输出。

简而言之，`sync`命令可以不带参数直接使用，也可以根据需要加上选项来控制同步的范围和行为[^1][^2][^4][^5][^6][^8]。

<div style="text-align: center">⁂</div>

[^1]: https://www.linuxcool.com/ypzxsmldbyxh

[^2]: http://www.runoob.com/linux/linux-comm-sync.html

[^3]: https://blog.csdn.net/bryanwang_3099/article/details/131050672

[^4]: https://www.linuxcool.com/sync

[^5]: https://worktile.com/kb/ask/373336.html

[^6]: https://getiot.tech/linux-command/sync/

[^7]: https://blog.csdn.net/lanhuazui10/article/details/143094354

[^8]: https://blog.iprac.cn/blogs/689.html

