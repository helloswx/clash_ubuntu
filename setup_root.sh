#!/bin/bash

# 设置 root 用户密码脚本
# 使用方法: bash setup_root.sh

echo "=========================================="
echo "  设置 root 用户密码"
echo "=========================================="
echo ""
echo "注意：此操作需要您当前的用户密码（用于 sudo）"
echo ""

# 检查是否已经有 root 密码
if sudo -n true 2>/dev/null; then
    echo "✓ 您已经有 sudo 权限，可以直接设置 root 密码"
else
    echo "需要输入您的用户密码以获取 sudo 权限"
fi

echo ""
read -p "是否要设置 root 密码？(y/n): " confirm

if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "已取消"
    exit 0
fi

echo ""
echo "正在设置 root 密码..."
echo "（您需要输入两次新密码）"
echo ""

# 设置 root 密码
sudo passwd root

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "  ✓ root 密码设置成功！"
    echo "=========================================="
    echo ""
    echo "现在您可以使用以下方式切换到 root 用户："
    echo ""
    echo "  方法1: 使用 su 命令"
    echo "    su -"
    echo "    然后输入刚才设置的 root 密码"
    echo ""
    echo "  方法2: 直接登录 root 用户"
    echo "    如果启用了图形界面登录，可以在登录界面选择 root 用户"
    echo ""
    echo "  方法3: 使用 sudo -i 切换到 root"
    echo "    sudo -i"
    echo ""
    echo "提示：设置 root 密码后，建议："
    echo "  1. 使用 'su -' 切换到 root 用户"
    echo "  2. 然后运行 Clash 的启动脚本（不需要 sudo）"
    echo ""
else
    echo ""
    echo "=========================================="
    echo "  ✗ root 密码设置失败"
    echo "=========================================="
    echo ""
    exit 1
fi

