# See:
- Linux 系统欢迎信息设置；登录提示信息设置；/etc/motd 设置
- [Linux 系统欢迎信息设置；登录提示信息设置；/etc/motd 设置](https://www.cnblogs.com/xuyaowen/p/linux-login-info.html)
- [教你如何修改Linux远程登录欢迎提示信息](https://cloud.tencent.com/developer/article/1722167)
- [linux ssh登录后展示内容修改](https://www.cleey.com/blog/single/id/867.html)


# 登录信息可以修改三个文件：

    /etc/issue 本地登陆显示的信息，本地登录前
    /etc/issue.net 网络登陆显示的信息，登录后显示，需要由sshd配置
    /etc/motd 常用于通告信息，如计划关机时间的警告等，登陆后的提示信息
