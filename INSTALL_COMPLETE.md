# Clash 安装完成 ✅

Clash 服务已经成功安装并启动！

## 服务状态

- ✅ Clash 服务正在运行
- ✅ 所有端口已监听（7890, 7891, 7892, 9090）

## 访问信息

### Clash Dashboard（Web 管理界面）

- **访问地址**: http://10.30.137.23:9090/ui
- **Secret**: `05c47f8895c458659dfc547474008e1cf5caf80a07b4ebc127271e74758e3f8e`

**使用步骤**：
1. 在浏览器中打开上述地址
2. 在 `API Base URL` 中输入：`http://10.30.137.23:9090`
3. 在 `Secret(optional)` 中输入上面的 Secret
4. 点击 Add 并选择该管理界面地址

### 代理端口

- **HTTP 代理**: 127.0.0.1:7890
- **SOCKS5 代理**: 127.0.0.1:7891
- **混合端口**: 127.0.0.1:7892

## 使用代理

### 方法一：使用环境变量脚本（推荐）

```bash
# 加载环境变量
source ~/Clash.for.Linux/clash-for-linux/clash_env.sh

# 开启系统代理
proxy_on

# 关闭系统代理
proxy_off
```

### 方法二：手动设置环境变量

```bash
# 开启代理
export http_proxy=http://127.0.0.1:7890
export https_proxy=http://127.0.0.1:7890
export HTTP_PROXY=http://127.0.0.1:7890
export HTTPS_PROXY=http://127.0.0.1:7890

# 关闭代理
unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
```

## 常用命令

### 检查服务状态

```bash
# 检查进程
ps aux | grep clash-linux-amd64

# 检查端口
netstat -tln | grep -E '9090|789.' || ss -tln | grep -E '9090|789.'
```

### 重启服务

```bash
cd ~/Clash.for.Linux/clash-for-linux
sudo bash restart.sh
```

### 停止服务

```bash
cd ~/Clash.for.Linux/clash-for-linux
sudo bash shutdown.sh
```

### 查看日志

```bash
tail -f ~/Clash.for.Linux/clash-for-linux/logs/clash.log
```

## 配置文件位置

- **主配置文件**: `~/Clash.for.Linux/clash-for-linux/conf/config.yaml`
- **日志文件**: `~/Clash.for.Linux/clash-for-linux/logs/clash.log`

## 注意事项

1. 如果需要修改配置，请编辑 `conf/config.yaml` 文件，然后运行 `sudo bash restart.sh` 重启服务
2. 重启脚本不会更新订阅信息，如需更新订阅请运行 `sudo bash start.sh`
3. 如果需要在系统启动时自动加载环境变量，可以将 `source ~/Clash.for.Linux/clash-for-linux/clash_env.sh` 添加到 `~/.bashrc` 或 `~/.zshrc`

## 测试代理

```bash
# 开启代理后测试
curl -I https://www.google.com
# 或
wget -O- https://www.google.com
```

