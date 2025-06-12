Cloudflare 设置 DDNS（动态域名解析）主要通过调用其 DNS API 来实现动态更新域名的解析记录，步骤如下：

# 1. 创建 Cloudflare API Token
  -  登录 Cloudflare 账号，访问 API Tokens 页面（https://dash.cloudflare.com/profile/api-tokens）。
  -  点击“Create Token”，选择“Edit zone DNS”模板。
  -  在 Zone Resources 中选择你要操作的域名。
  -  创建完成后复制该 API Token，用于后续认证。

# 2. 配置域名的 DNS 记录
  -  在 Cloudflare 域名管理页面，进入 DNS 标签。
  -  添加一条 A 记录，填写你的子域名（如 self.example.com），IP 先填一个默认值。
  -  关闭“Proxied”（云朵图标变灰），设置为 DNS only，保存。

# 3. 总结：
  - 通过cloudflare 的 dns api 编辑子域名。
  - 注意：API Token 拥有这个域名的编辑权限。

后续，pve 主机使用 软件 DDNS-GO 定时上传 变化后的ip地址
