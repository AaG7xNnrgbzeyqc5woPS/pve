<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# 使用local stratum 10后，系统如何与真实时间源保持同步

使用 `local stratum 10` 后，系统如何与真实时间源保持同步，关键在于该配置允许服务器在无法访问外部真实时间源时，仍以本地时钟作为时间源对客户端提供时间服务，但这并不妨碍服务器本身继续尝试与真实时间源同步。

具体来说：

- `local stratum 10` 使得服务器在没有外部NTP服务器可用时，将本地时钟作为一个低可信度（stratum 10）的时间源对外提供，保证局域网内其他客户端仍能获得时间同步服务[^1][^3][^4]。
- 当服务器能够访问真实的NTP时间源（如公共NTP服务器或内网NTP服务器）时，`chronyd`会优先选择这些更低stratum（更可靠）的时间源进行同步，自动调整本地时钟，使其与真实时间保持一致[^1][^2][^3]。
- 也就是说，`local stratum 10` 并不会阻止服务器与真实时间源同步，而是作为一种“后备”机制，当外部时间源不可用时，服务器仍能提供时间服务，避免时间同步中断。
- 服务器同步到真实时间源后，其stratum值会小于10，客户端也会检测到更优的时间源，从而优先同步真实时间，避免使用本地时钟[^3]。
- 这种配置常用于隔离网络或内网环境，确保时间同步的连续性和稳定性，同时避免本地时钟被误认为是准确的参考时间源[^1][^3][^5]。

总结：
`local stratum 10` 是一种容错配置，允许服务器在无外部时间源时提供时间服务，但服务器本身依然会持续尝试与真实时间源同步，一旦同步成功，服务器时间会自动校正，stratum值降低，客户端也会优先选择真实时间源同步[^1][^3][^4]。

<div style="text-align: center">⁂</div>

[^1]: https://docs.redhat.com/zh-cn/documentation/red_hat_enterprise_linux/7/html/system_administrators_guide/sect-understanding_chrony_and-its_configuration

[^2]: https://blog.csdn.net/qq_43437874/article/details/110651605

[^3]: https://blog.csdn.net/weixin_37590300/article/details/135198845

[^4]: https://www.jianshu.com/p/e9be333aa54c

[^5]: https://www.cnblogs.com/js1314/p/11457950.html

[^6]: https://help.aliyun.com/zh/ecs/user-guide/alibaba-cloud-ntp-server

[^7]: https://docs.redhat.com/zh-cn/documentation/red_hat_enterprise_linux/10/pdf/configuring_time_synchronization/Red_Hat_Enterprise_Linux-10-Configuring_time_synchronization-zh-CN.pdf

[^8]: https://chegva.com/3265.html

