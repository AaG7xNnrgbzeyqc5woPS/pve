#!/bin/bash

FILE="/usr/share/perl5/PVE/API2/APT.pm"
BACKUP="/usr/share/perl5/PVE/API2/APT.pm.bak_$(date +%F)"

# 1. 备份原始文件
if [ ! -f "$BACKUP" ]; then
    cp "$FILE" "$BACKUP"
    echo "已备份原始文件至: $BACKUP"
fi

# 2. 注入 Hook 逻辑 (替换原始的 return 语句)
# 寻找 repositories("pve"); 并将其捕获到变量再转发
sed -i 's/return Proxmox::RS::APT::Repositories::repositories("pve");/my $res = Proxmox::RS::APT::Repositories::repositories("pve"); return patch_apt_repos($res);/' "$FILE"

# 3. 清理旧的 patch 函数 (防止重复运行脚本导致冲突)
sed -i '/sub patch_apt_repos/,/^}/d' "$FILE"
sed -i '/# PVE_CRACK_BEGIN/,/# PVE_CRACK_END/d' "$FILE"

# 4. 在文件末尾 1; 之前注入自定义处理函数
# 使用临时文件构建新结尾
sed -i '$d' "$FILE" # 删除最后一行 1;

cat << 'INNER_EOF' >> "$FILE"
# PVE_CRACK_BEGIN
sub patch_apt_repos {
    my ($res) = @_;
    # 抹除错误信息
    $res->{errors} = []; 
    # 激活无订阅源状态
    if (defined($res->{'standard-repos'})) {
        foreach my $repo (@{$res->{'standard-repos'}}) {
            if ($repo->{handle} eq 'no-subscription') {
                $repo->{status} = 1; 
            }
        }
    }
    return $res;
}
# PVE_CRACK_END
1;
INNER_EOF

# 5. 语法检查与重启
echo "执行语法检查..."
if perl -c "$FILE"; then
    echo "语法正确，正在重启 pveproxy..."
    systemctl restart pveproxy
    echo "破解完成！请刷新 Web 界面查看绿色勾选。"
else
    echo "语法错误！正在回滚备份..."
    cp "$BACKUP" "$FILE"
fi
