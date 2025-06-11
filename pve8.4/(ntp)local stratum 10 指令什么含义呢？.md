<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# local stratum 10 指令什么含义呢？

`local stratum 10` 是 `chrony` 时间同步服务配置中的一个指令，主要含义如下：

- **local** 关键字允许该服务器即使没有从任何外部NTP服务器同步时间，也能将自己的本地时钟作为时间源对外提供时间服务。
- **stratum 10** 表示该本地时钟的层级（stratum）被人为设置为10，这个数值较大，意味着该时钟相对于参考时间源的可靠性较低，时间可能不够精确。
- 这样配置的目的是防止这台服务器的本地时间被误认为是准确的参考时间，避免误导客户端。通常，stratum值越小，时间源越可靠，10是一个较高的层级，表示“仅当没有更好的时间源时才使用”。
- 该配置常用于隔离网络或无法访问外部NTP服务器的环境中，使得服务器仍能提供时间服务，但告知客户端该时间不够精确，客户端可据此决定是否信任该时间源。

简而言之，`local stratum 10` 允许服务器在无外部同步时以本地时钟作为时间源对外服务，但标记为低可信度（stratum 10），防止时间混淆和误用[^1][^2][^5][^6]。

<div style="text-align: center">⁂</div>

[^1]: https://docs.redhat.com/zh-cn/documentation/red_hat_enterprise_linux/7/html/system_administrators_guide/sect-understanding_chrony_and-its_configuration

[^2]: https://blog.csdn.net/sun2019720/article/details/130144977

[^3]: https://www.cnblogs.com/paul8339/p/17240400.html

[^4]: https://debian.cn/articles/732

[^5]: https://www.vxworks.net/linux/922-config-ntp-time-sync-service-in-linux

[^6]: https://www.cnblogs.com/Presley-lpc/p/13064341.html

[^7]: https://blog.csdn.net/stevensxiao/article/details/85103186

[^8]: https://docs.redhat.com/zh-cn/documentation/red_hat_enterprise_linux/10/pdf/configuring_time_synchronization/Red_Hat_Enterprise_Linux-10-Configuring_time_synchronization-zh-CN.pdf

[^9]: https://cloud.tencent.com/developer/article/1360576

