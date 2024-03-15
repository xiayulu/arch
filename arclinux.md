# Archlinux 简单安装配置教程

## 安装教程

### 准备工作

- 一台电脑或虚拟机
- archlinux 官网下载 ISO 镜像
- Rufus 镜像制作工具
- U 盘
- 网络

### 安装教程

使用 Rufus 制作好镜像之后，进入Bios 设置U盘启动，进入系统之后设置 pacman 国内源，然后运行 archinstall。

- Mirrors：选 China（安装好之后自动配置国内源）
- Disk Configuration：best-effort------选最大的空间------ext4-------home(no)
- Bootloader------grub
- Profile----Minimal
- Audio---Pipwire
- Additional packages: vim git unzip wget curl base-devel
- Network：copy iso
- TimeZone：Asia/Shanghai

最后：Change root-----no，关机拔出优盘再次启动即可。

## 镜像源配置 

### 替换国内源

Pacman 以 `mirrorlist` 中 Server 的顺序作为优先级，因此添加镜像需要在文件的最顶端添加；您可以同时注释掉其它所有镜像。有关 Arch Linux 使用镜像的详细说明请见[官方文档](https://wiki.archlinux.org/title/mirrors)。

编辑 `/etc/pacman.d/mirrorlist`，在文件的最顶端添加：

```
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
```

更新软件包缓存：

```
sudo pacman -Syyu
```

两次 `y` 能避免从**损坏的**镜像切换到**正常的**镜像时出现的问题。

### Arch Linux CN 软件源

Arch Linux 中文社区仓库 是由 Arch Linux 中文社区驱动的非官方用户仓库。包含中文用户常用软件、工具、字体/美化包等。完整的包信息列表（包名称/架构/维护者/状态）请[点击这里](https://github.com/archlinuxcn/repo)查看。官方仓库地址：https://repo.archlinuxcn.org

使用方法：在 `/etc/pacman.conf` 文件末尾添加以下两行：

```
[archlinuxcn]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
```

之后通过以下命令安装 `archlinuxcn-keyring` 包导入 GPG key。

```
sudo pacman -Sy archlinuxcn-keyring
```

2023 年 12 月后，在新系统下安装 `archlinuxcn-keyring` 时可能会出现错误：

```
error: archlinuxcn-keyring: Signature from "Jiachen YANG (Arch Linux Packager Signing Key) " is marginal trust
```

需要在本地信任 farseerfc 的 GPG key：

```
sudo pacman-key --lsign-key "farseerfc@archlinux.org"
```

然后重试安装。详情参见 [新系统中安装 archlinuxcn-keyring 包前需要手动信任 farseerfc 的 key](https://www.archlinuxcn.org/archlinuxcn-keyring-manually-trust-farseerfc-key/)。

**pacman 更多配置**

还可以在 `/etc/pacman.conf` 中加入配置：

```bash
#UseSyslog # 把错误信息输出到系统日志中.不在终端输出
Color # 彩色支持
#NoProgressBar # 不显示下载进度条
#CheckSpace # 升级前检查磁盘空间
#VerbosePkgLists # 列出软件包时提供更多的详细信息
ParallelDownloads = 5 # 允许同时下载多个软件包
```

### aur helper

`yay` install https://github.com/Jguer/yay

```shell
sudo pacman -S --needed git  base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
```

##   语言与时区

### 本地化

安装中文 locale：将`en_US.UTF-8`和`zh_CN.UTF-8`的注释从配置文件`/etc/locale.gen`去掉，即删除行首的`#`：

```shell
# /etc/locale.gen
en_US.UTF-8 UTF-8
zh_CN.UTF-8 UTF-8
```

然后执行：

```text
sudo locale-gen
```

### 中文乱码

安装如下一款字体即可解决，例如：

```shell
sudo pacman -Sy adobe-source-han-sans-cn-fonts
```

- [adobe-source-han-sans-cn-fonts](https://archlinux.org/packages/?name=adobe-source-han-sans-cn-fonts)
- [adobe-source-han-serif-cn-fonts](https://archlinux.org/packages/?name=adobe-source-han-serif-cn-fonts)
- [noto-fonts-cjk](https://archlinux.org/packages/?name=noto-fonts-cjk)
- [wqy-microhei](https://archlinux.org/packages/?name=wqy-microhei)
- [wqy-microhei-lite](https://archlinux.org/packages/?name=wqy-microhei-lite)
- [wqy-bitmapfont](https://archlinux.org/packages/?name=wqy-bitmapfont)
- [wqy-zenhei](https://archlinux.org/packages/?name=wqy-zenhei)
- [ttf-arphic-ukai](https://archlinux.org/packages/?name=ttf-arphic-ukai)
- [ttf-arphic-uming](https://archlinux.org/packages/?name=ttf-arphic-uming)

### 中文输入法

> arch wiki 搜索 fcitx5, input method

安装如下依赖

```shell
sudo pacman -S fcitx5-im fcitx5-chinese-addons fcitx5-pinyin-zhwiki fcitx5-material-color
```

- fcitx5-chinese-addons 包含各种中文输入法
- fcitx5-pinyin-zhwiki 是中文字典

设置环境变量 `/etc/environment`

```shell
#GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
INPUT_METHOD=fcitx
SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=ibus
```

在 hyprland 中配置：

```shell
exec-once=fcitx5 --replace -d
```

运行  Fcitx5 Configuration，把一个中文输入法放到左边。

> 切换中文输入法：Ctrl+Space

### 设置时间

```shell
timedatectl list-timezones #列出所有时区
timedatectl set-timezone <time-zone> #设置时区
timedatectl set-ntp true #设置NTP服务器
timedatectl status #查看设置
```

## 科学上网

```shell
yay -S clash
```

首先直接在终端启动 Clash 生成基础配置文件。

```bash
clash
```

Clash 启动后会在 `~/.config/clash` 目录生成配置文件。其中 `~/.config/clash/config.yaml` 是需要你自定义的 Clash 的配置文件，存储你的节点和规则。你可以直接用你的配置文件覆盖这个文件。一般来说直接在浏览器中打开订阅链接会下载一个 `xxx.yaml` 的文件，把它放到配置目录并重名为 `config.yaml`即可。

配置终端  proxy，在 `/etc/environment` 中加入如下内容

```shell
http_proxy=http://127.0.0.1:7890
https_proxy=http://127.0.0.1:7890
socks_proxy=http://127.0.0.1:7891
no_proxy="localhost, 127.0.0.1"
```

sudo 保持环境变量

```
# vim /etc/sudoers.d/05_proxy
Defaults env_keep += "*_proxy *_PROXY"
```

创建 systemd 配置文件 `/etc/systemd/system/clash.service`

```bash
[Unit]
Description=Clash daemon, A rule-based proxy in Go.
After=network.target

[Service]
Type=simple
Restart=always
ExecStart=/usr/bin/clash -d ~/.config/clash

[Install]
WantedBy=multi-user.target
```

添加 Clash 至守护进程

```bash
sudo systemctl enable clash --now
```



## hyprland

- https://github.com/prasanthrangan/hyprdots

## 常见软件的安装

### 必装软件

```shell
sudo pacman -S git base-devel firefox code
```

- git：代码版本管理
- base-devel：编译工具
- firefox：火狐浏览器
- code：VsCode

### oh my zsh

### Docker

### golang

### java

### Rust

### android

## 常见问题解决

### Hyprland 4K 显示问题

https://www.bilibili.com/read/cv24998287/

替换为高分辨率依赖：

```shell
yay -S xorg-xwayland-hidpi-xprop wlroots-hidpi-xprop-git hyprland-hidpi-xprop-git xorg-xrdb   
```

配置 `hyprland`

```shell
# 配置wayland的缩放为两倍
monitor = ,highres,auto,2       
# 告诉 wayland xwayland它自己会缩放两倍,让 wayland 不要管 xwayland 的缩放
exec-once = xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2    
# 设置 xwayland 的 DPI 192, 一倍的 DPI 为96, 2倍即为192
exec-once = echo 'Xft.dpi:192' | xrdb -merge
# 设置 xwayland 下 gtk 的缩放，不会影响 wayland 下 gtk 的缩放
env = GDK_SCALE,2       # 这一行我不确定要不要，可以尝试一下
# 设置 xwayalnd 鼠标图标的大小
env = XCURSOR_SIZE,32
```

### Vscode，Typora 打开模糊

是 Electron 的问题，arch wiki 搜索 wayland，找到 Electron 小节配置就好。

新建配置`~/.config/electron25-flags.conf`：

```shell
--enable-features=WaylandWindowDecorations
--ozone-platform-hint=auto
```

`~/.config/electron13-flags.conf`：

```sehll
--enable-features=UseOzonePlatform
--ozone-platform=wayland
```

