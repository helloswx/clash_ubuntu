[TOC]

# 项目介绍

此项目是通过使用开源项目[clash](https://github.com/Dreamacro/clash)作为核心程序，再结合脚本实现简单的代理功能。

主要是为了解决我们在服务器上下载GitHub等一些国外资源速度慢的问题。

<br>

# 使用须知

- 运行本项目建议使用root用户，或者使用 sudo 提权。
- 使用过程中如遇到问题，请优先查已有的 [issues](https://github.com/wanhebin/clash-for-linux/issues)。
- 在进行issues提交前，请替换提交内容中是敏感信息（例如：订阅地址）。
- 本项目是基于 [clash](https://github.com/Dreamacro/clash) 、[yacd](https://github.com/haishanh/yacd) 进行的配置整合，关于clash、yacd的详细配置请去原项目查看。
- 此项目不提供任何订阅信息，请自行准备Clash订阅地址。
- 运行前请手动更改`.env`文件中的`CLASH_URL`变量值，否则无法正常运行。
- 当前在RHEL系列和Debian系列Linux系统中测试过，其他系列可能需要适当修改脚本。
- 支持 x86_64/aarch64 平台

> **注意**：当你在使用此项目时，遇到任何无法独自解决的问题请优先前往 [Issues](https://github.com/wanhebin/clash-for-linux/issues) 寻找解决方法。由于空闲时间有限，后续将不再对Issues中 “已经解答”、“已有解决方案” 的问题进行重复性的回答。

<br>

# 使用教程

## 下载项目

下载项目

```bash
$ git clone https://github.com/wanhebin/clash-for-linux.git
# 或使用本仓库
$ git clone https://github.com/helloswx/clash_ubuntu.git
```

进入到项目目录，编辑`.env`文件，修改变量`CLASH_URL`的值。

```bash
$ cd clash-for-linux
$ vim .env
```

`.env` 文件格式示例：

```bash
# Clash 订阅地址
export CLASH_URL='https://your-subscription-url'
export CLASH_SECRET=''
```

> **注意：** 
> - `.env` 文件中的变量 `CLASH_SECRET` 为自定义 Clash Secret，值为空时，脚本将自动生成随机字符串。
> - 如果没有 `curl` 命令，脚本会自动使用 `wget` 作为备选方案。

<br>

## 启动程序

直接运行脚本文件`start.sh`

- 进入项目目录

```bash
$ cd clash-for-linux
```

- 运行启动脚本

```bash
$ sudo bash start.sh

正在检测订阅地址...
Clash订阅地址可访问！                                      [  OK  ]

正在下载Clash配置文件...
配置文件config.yaml下载成功！                              [  OK  ]

正在启动Clash服务...
服务启动成功！                                             [  OK  ]

Clash Dashboard 访问地址：http://<ip>:9090/ui
Secret：xxxxxxxxxxxxx

请执行以下命令加载环境变量: source /etc/profile.d/clash.sh

请执行以下命令开启系统代理: proxy_on

若要临时关闭系统代理，请执行: proxy_off

```

```bash
$ source /etc/profile.d/clash.sh
$ proxy_on
```

> **提示：** 如果没有 root 权限，环境变量文件可能无法写入 `/etc/profile.d/`。可以使用项目目录下的 `clash_env.sh` 文件：
> ```bash
> $ source clash_env.sh
> $ proxy_on
> ```

- 检查服务端口

```bash
$ netstat -tln | grep -E '9090|789.'
tcp        0      0 127.0.0.1:9090          0.0.0.0:*               LISTEN     
tcp6       0      0 :::7890                 :::*                    LISTEN     
tcp6       0      0 :::7891                 :::*                    LISTEN     
tcp6       0      0 :::7892                 :::*                    LISTEN
```

- 检查环境变量

```bash
$ env | grep -E 'http_proxy|https_proxy'
http_proxy=http://127.0.0.1:7890
https_proxy=http://127.0.0.1:7890
```

以上步鄹如果正常，说明服务clash程序启动成功，现在就可以体验高速下载github资源了。

<br>

## 重启程序

如果需要对Clash配置进行修改，请修改 `conf/config.yaml` 文件。然后运行 `restart.sh` 脚本进行重启。

> **注意：**
> 重启脚本 `restart.sh` 不会更新订阅信息。

<br>

## 停止程序

- 进入项目目录

```bash
$ cd clash-for-linux
```

- 关闭服务

```bash
$ sudo bash shutdown.sh

服务关闭成功，请执行以下命令关闭系统代理：proxy_off

```

```bash
$ proxy_off
```

然后检查程序端口、进程以及环境变量`http_proxy|https_proxy`，若都没则说明服务正常关闭。

<br>

## 项目脚本说明

项目包含以下主要脚本：

| 脚本文件 | 功能说明 |
|---------|---------|
| `start.sh` | 启动 Clash 服务（下载配置、启动服务） |
| `restart.sh` | 重启 Clash 服务（不更新订阅） |
| `shutdown.sh` | 停止 Clash 服务 |
| `clash_env.sh` | 环境变量管理脚本（开启/关闭代理） |
| `setup_root.sh` | 设置 root 用户密码的辅助脚本 |

### 环境变量脚本使用

如果以普通用户运行，可以使用项目目录下的 `clash_env.sh`：

```bash
# 加载环境变量
source clash_env.sh

# 开启系统代理
proxy_on

# 关闭系统代理
proxy_off
```

### 查看日志

```bash
tail -f logs/clash.log
```

<br>

## 相关文档

- **INSTALL_COMPLETE.md** - 详细的安装完成说明和使用指南
- **ROOT_SETUP.md** - root 用户设置指南（如果需要以 root 用户运行）

<br>

## Clash Dashboard

- 访问 Clash Dashboard

通过浏览器访问 `start.sh` 执行成功后输出的地址，例如：http://192.168.0.1:9090/ui

- 登录管理界面

在`API Base URL`一栏中输入：http://\<ip\>:9090 ，在`Secret(optional)`一栏中输入启动成功后输出的Secret。

点击Add并选择刚刚输入的管理界面地址，之后便可在浏览器上进行一些配置。

- 更多教程

此 Clash Dashboard 使用的是[yacd](https://github.com/haishanh/yacd)项目，详细使用方法请移步到yacd上查询。


<br>

# 常见问题

1. **脚本运行报错**：部分Linux系统默认的 shell `/bin/sh` 被更改为 `dash`，运行脚本会出现报错（报错内容一般会有 `-en [ OK ]`）。建议使用 `bash xxx.sh` 运行脚本。

2. **找不到代理节点**：部分用户在UI界面找不到代理节点，基本上是因为厂商提供的clash配置文件是经过base64编码的，且配置文件格式不符合clash配置标准。
   
   目前此项目已集成自动识别和转换clash配置文件的功能。如果依然无法使用，则需要通过自建或者第三方平台（不推荐，有泄露风险）对订阅地址转换。

3. **RULE-SET 错误**：程序日志中出现`error: unsupported rule type RULE-SET`报错，解决方法查看官方[WIKI](https://github.com/Dreamacro/clash/wiki/FAQ#error-unsupported-rule-type-rule-set)

4. **缺少 curl 命令**：如果系统没有安装 `curl`，脚本会自动使用 `wget` 作为备选。建议安装 `curl` 以获得更好的兼容性：
   ```bash
   # Ubuntu/Debian
   sudo apt-get install curl
   
   # CentOS/RHEL
   sudo yum install curl
   ```

5. **权限问题**：如果没有 root 权限，环境变量文件无法写入 `/etc/profile.d/`，可以使用项目目录下的 `clash_env.sh` 文件来管理代理环境变量。

6. **服务未启动**：如果服务启动失败，请检查：
   - `.env` 文件中的 `CLASH_URL` 是否正确
   - 订阅地址是否可以访问
   - 端口 7890、7891、7892、9090 是否被占用
   - 查看日志文件：`tail -f logs/clash.log`

<br>

# 项目结构

```
clash-for-linux/
├── bin/                    # Clash 二进制文件（amd64/arm64/armv7）
├── conf/                   # 配置文件目录
│   ├── config.yaml        # Clash 主配置文件（运行时生成）
│   └── Country.mmdb       # GeoIP 数据库
├── dashboard/              # Clash Dashboard (yacd)
├── logs/                   # 日志文件目录
├── scripts/                # 辅助脚本
│   ├── clash_profile_conversion.sh  # 配置文件转换脚本
│   └── get_cpu_arch.sh     # CPU 架构检测脚本
├── temp/                   # 临时文件目录
├── tools/                  # 工具目录（subconverter）
├── .env                    # 环境变量配置文件（需自行创建）
├── start.sh                # 启动脚本
├── restart.sh              # 重启脚本
├── shutdown.sh             # 停止脚本
├── clash_env.sh            # 环境变量管理脚本
├── setup_root.sh           # root 用户设置脚本
└── README.md               # 本文件
```

<br>

# 许可证

本项目基于 [clash](https://github.com/Dreamacro/clash) 和 [yacd](https://github.com/haishanh/yacd) 进行整合。

原始项目：[wanhebin/clash-for-linux](https://github.com/wanhebin/clash-for-linux)
