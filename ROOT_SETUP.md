# 设置 root 用户指南

## 方法一：使用脚本设置（推荐）

运行以下命令：

```bash
cd ~/Clash.for.Linux/clash-for-linux
bash setup_root.sh
```

脚本会引导您设置 root 密码。

## 方法二：手动设置

### 1. 设置 root 密码

```bash
sudo passwd root
```

系统会提示您输入：
1. 您当前用户的密码（用于 sudo 权限）
2. 新的 root 密码（输入两次）

### 2. 切换到 root 用户

设置完成后，可以使用以下方式切换到 root：

```bash
# 方法1: 使用 su 命令（推荐）
su -

# 方法2: 使用 sudo -i
sudo -i

# 方法3: 使用 su（不切换环境变量）
su
```

### 3. 以 root 用户运行 Clash

切换到 root 后，直接运行启动脚本（不需要 sudo）：

```bash
cd /home/bz/Clash.for.Linux/clash-for-linux
bash start.sh
```

## 方法三：配置 sudo 免密码（可选）

如果您不想设置 root 密码，但希望使用 sudo 时不需要输入密码：

```bash
# 编辑 sudoers 文件
sudo visudo

# 在文件末尾添加以下行（将 bz 替换为您的用户名）
bz ALL=(ALL:ALL) NOPASSWD: ALL
```

保存后，您就可以使用 `sudo` 命令而不需要输入密码了。

## 注意事项

1. **安全性**：设置 root 密码后，请妥善保管，不要泄露给他人
2. **Ubuntu 默认**：Ubuntu 默认禁用 root 用户，这是为了安全考虑
3. **推荐做法**：建议使用 `su -` 切换到 root，而不是直接以 root 登录系统
4. **Clash 运行**：以 root 用户运行 Clash 后，环境变量会写入 `/etc/profile.d/clash.sh`，所有用户都可以使用

## 验证 root 用户

设置完成后，可以验证：

```bash
# 切换到 root
su -

# 检查当前用户
whoami
# 应该显示: root

# 检查用户 ID
id
# 应该显示: uid=0(root) gid=0(root) 组=0(root)
```

## 以 root 用户运行 Clash 的优势

1. ✅ 不需要每次使用 sudo
2. ✅ 环境变量会写入系统目录，所有用户可用
3. ✅ 可以绑定特权端口（如果需要）
4. ✅ 配置文件权限更灵活

