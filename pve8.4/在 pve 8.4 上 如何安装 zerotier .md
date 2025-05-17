<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>
# 概要
  - 经过实验，zerotier非常容易就安装上了，比[官方文档](https://www.zerotier.com/download/#linux)好用
  
# 在 pve 8.4 上 zerotier 如何安装

在 Proxmox VE 8.4（PVE 8.4）上安装 ZeroTier 的步骤如下：

1. **安装必要工具**
进入 PVE 的 Shell，先安装 curl 和 gnupg（非对称加密系统，ZeroTier 依赖）：

```bash
apt-get update
apt-get install curl gnupg
```

2. **安装 ZeroTier**
使用官方一键安装脚本：

```bash
curl -s https://install.zerotier.com/ | bash
```

安装成功后，会显示类似：

```
*** Success! You are ZeroTier address [ xxxxxxxx ].
```

这里的地址类似于设备的唯一标识。  

3. **启动并设置开机自启**
启动 ZeroTier 服务：

```bash
systemctl start zerotier-one.service
```

设置开机自启：

```bash
systemctl enable zerotier-one.service
```

4. **加入 ZeroTier 网络**
使用 ZeroTier CLI 加入你的私有网络，替换 `{NETWORK_ID}` 为你在 ZeroTier Central 创建的网络ID：

```bash
zerotier-cli join {NETWORK_ID}
```

然后登录 ZeroTier Central 管理页面，授权该节点加入网络。
5. **验证状态**
查看服务状态确认运行正常：

```bash
systemctl status zerotier-one.service
```


完成以上步骤后，PVE 服务器就接入了 ZeroTier 虚拟局域网，可以实现内网穿透和远程访问[^1][^2][^3][^4]。

总结：

- PVE 8.4 基于 Debian，安装方式与 Debian 类似。
- 先安装 curl 和 gnupg。
- 通过官方脚本安装 zerotier。
- 启动并设置服务开机自启。
- 加入 ZeroTier 网络并授权。

这样即可在 PVE 8.4 上成功安装并使用 ZeroTier。

<div style="text-align: center">⁂</div>

[^1]: https://blog.csdn.net/Rickest_man/article/details/141288668

[^2]: https://pve.sqlsec.com/8/2/

[^3]: https://www.leftso.com/article/2312151546398065.html

[^4]: https://blog.csdn.net/hlz_07/article/details/122229311

[^5]: https://juejin.cn/post/7322156804850696202

[^6]: https://www.youtube.com/watch?v=3zPqwL_JtMM\&vl=zh-Hans

[^7]: https://www.youtube.com/watch?v=ofOKZHtu1x0

[^8]: https://www.cnblogs.com/Yogile/p/18679869

