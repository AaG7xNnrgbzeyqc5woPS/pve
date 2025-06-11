<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# server ntp1.aliyun.com iburst

server ntp2.aliyun.com iburst
server ntp3.aliyun.com iburst
server ntp.aliyun.com iburst

这几行配置：

```
server ntp1.aliyun.com iburst
server ntp2.aliyun.com iburst
server ntp3.aliyun.com iburst
server ntp.aliyun.com iburst
```

是NTP客户端配置文件中指定多个NTP服务器地址，并为每个服务器添加了 `iburst` 选项。

## 各部分含义

- `server ntp1.aliyun.com` 等：指定NTP服务器的域名，客户端将向这些服务器请求时间同步。这里使用的是阿里云提供的公共NTP服务器。
- `iburst`：这是一个NTP客户端的优化选项，用于加快初次与服务器同步的速度。
    - 当客户端启动时，如果与服务器尚未同步，`iburst` 会在短时间内快速发送一组（通常是6个或8个）NTP请求包，而不是默认的单个请求包，从而更快获得准确时间。
    - 这样可以显著减少时间同步的初始延迟，尤其是在网络延迟较高或服务器响应较慢的情况下[^1][^2][^4][^5]。


## 作用总结

- 指定多个NTP服务器提高时间同步的可靠性和稳定性，如果某个服务器不可用，客户端会自动切换到其他服务器。
- `iburst` 选项加快初始同步速度，缩短启动时的时间校准过程。

这种配置是NTP客户端（如`chrony`或`ntpd`）中常见的最佳实践，确保系统时间快速且准确地同步到可信的时间源。

<div style="text-align: center">⁂</div>

[^1]: https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/6/html/deployment_guide/s2_configuring_the_iburst_option

[^2]: https://arubanetworking.hpe.com/techdocs/AOS-CX/10.09/HTML/fundamentals_83xx-10000/Content/Chp_IniCfg/NTP_cmds/ntp-ser.htm

[^3]: https://www.reddit.com/r/Hue/comments/xuegnv/hue_bridges_talking_to_chinese_time_servers/

[^4]: https://arubanetworking.hpe.com/techdocs/AOS-CX/10.14/HTML/fundamentals_4100i-6000-6100/Content/Chp_IniCfg/NTP_cmds/ntp-ser.htm

[^5]: https://docs.ntpsec.org/latest/confopt.html

[^6]: https://community.infoblox.com/t5/nios-dns-dhcp-ipam/what-s-the-use-cases-of-burst-and-iburst-in-ntp-server-setting/td-p/16047

[^7]: https://support.hpe.com/hpesc/public/docDisplay?docId=sf000095180en_us\&docLocale=en_US

[^8]: https://www.meinbergglobal.com/english/info/ntp.htm

[^9]: https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/system_administrators_guide/ch-configuring_ntp_using_ntpd

[^10]: https://www.snbforums.com/threads/intercepting-ntp-traffic-philips-hue-hub.80929/

