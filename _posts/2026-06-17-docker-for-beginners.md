---
layout: post
title: "Docker到底是啥？给电脑小白讲的集装箱入门课"
subtitle: "从软件装不上、环境配不对，到一键部署再也不折腾"
date: 2026-06-17
author: "老墨"
header-img: "img/post-bg-unix-linux.jpg"
tags:
  - Docker
  - 容器
  - DevOps
  - 教程
categories:
  - 工具教程
---

## 📖 从一个悲惨的故事说起

老王是医院信息科的小领导。领导让他部署一个档案管理系统。

他打开电脑，开始折腾——

```
第一步：安装 Python 3.9  → 报错，版本冲突
第二步：安装 MySQL      → 报错，端口被占
第三步：安装 Redis      → 报错，服务启动不了
第四步：配置环境变量    → 报错，路径写错了
第五步：安装依赖包      → 报错，权限不够
第六步：重启电脑        → 报错，之前装的又没了
第七步：查百度          → 说要装 12 个依赖
第八步：装完依赖        → 报错，跟昨天装的版本冲突
第九步：找同事帮忙      → 同事说"我这台电脑上能跑啊"
第十步：崩溃            → 🤯
```

老王花了三天，还没把系统跑起来。更崩溃的是——同事在自己的电脑上能跑，在老王的电脑上死活跑不起来。

老王哭了。

**如果老王用了 Docker，十分钟就能搞定。**

---

## 🤔 Docker 到底是个啥？

一句话：**Docker 是一个「集装箱」，把软件和它需要的所有东西打包在一起，搬到哪里都能直接用。**

你不需要懂编程才能用 Docker。它就像搬家时的集装箱——你把家具、家电、锅碗瓢盆全塞进去，到了新家，打开箱子，家里就齐活了。不用重新买家具，不用重新布线，箱子里的东西跟你搬走之前一模一样。

打个比方：

| 没有 Docker | 有 Docker |
|------------|----------|
| 装软件要装一堆依赖，缺一个就报错 | 软件和依赖打包在一起，一条命令就能跑 |
| 在你的电脑上能跑，换一台就不行 | 在任何电脑上都能跑，因为环境一模一样 |
| 配环境花三天，还可能配错 | 拉个镜像十秒钟，环境现成的 |
| 多个软件争端口、争版本 | 每个软件住自己的"集装箱"，互不打扰 |

### Docker 的三个核心概念

别被术语吓到，我用大白话给你讲：

| 术语 | 大白话解释 | 比喻 |
|------|-----------|------|
| **镜像 (Image)** | 软件的安装包，包含软件+环境+依赖 | 集装箱里的货物清单 |
| **容器 (Container)** | 正在运行的软件实例，从镜像启动 | 打开箱子，货物在用着 |
| **仓库 (Registry)** | 存放镜像的地方，可以下载 | 集装箱码头，随时取货 |

> 💡 简单理解：**镜像 = 安装包，容器 = 运行中的软件，仓库 = 下载站**

---

## 🛠️ 第一步：安装 Docker

### Windows 安装（最简单）

1. 打开 [Docker 官网](https://www.docker.com/products/docker-desktop/)，下载 **Docker Desktop**
2. 双击安装包，一路 Next
3. 安装完重启电脑
4. 打开 Docker Desktop，看到鲸鱼图标 🐳 在运行，就装好了

> ⚠️ **Windows 要求**：Windows 10/11 专业版或企业版，需要开启 WSL2（Windows Subsystem for Linux）。如果安装时提示要开启 WSL2，按提示操作就行——就跟你装个更新一样。

**开启 WSL2 的方法：**

1. 打开 PowerShell（右键开始菜单 → PowerShell）
2. 输入 `wsl --install`
3. 等待安装完成，重启电脑

> 💡 如果你用的是 Windows 家庭版，Docker Desktop 现在也支持了！不用再折腾升级专业版。

### Linux 安装（一条命令搞定）

Ubuntu/Debian：

```bash
# 官方推荐的一键安装脚本
curl -fsSL https://get.docker.com | sh

# 启动 Docker
sudo systemctl start docker

# 设置开机自启动
sudo systemctl enable docker
```

CentOS/RHEL：

```bash
# 同样的一键脚本
curl -fsSL https://get.docker.com | sh
sudo systemctl start docker
sudo systemctl enable docker
```

### macOS 安装

1. 从 [Docker 官网](https://www.docker.com/products/docker-desktop/) 下载 Docker Desktop for Mac
2. 双击 `.dmg` 文件，拖到 Applications
3. 打开 Docker Desktop，等鲸鱼图标 🐳 变绿

### 验证安装是否成功

打开终端（Windows 用 PowerShell，Mac/Linux 用 Terminal），输入：

```bash
docker --version
# 应该显示类似：Docker version 27.x.x

docker run hello-world
# 应该下载一个测试镜像并运行，显示欢迎信息
```

看到欢迎信息就说明 Docker 装好了！

---

## 🎯 第二步：常用命令速查（小白够用版）

Docker 命令很多，但你日常只需要这几个：

### 镜像管理（下载/查看/删除安装包）

```bash
# 搜索镜像（在仓库里找软件）
docker search nginx

# 下载镜像（把安装包下载到本地）
docker pull nginx

# 查看本地有哪些镜像
docker images

# 删除镜像（删掉不需要的安装包）
docker rmi nginx
```

### 容器管理（启动/查看/停止运行中的软件）

```bash
# 启动容器（从镜像创建一个运行中的实例）
docker run -d --name my-nginx nginx
# -d 表示后台运行（不会占住你的终端）
# --name 给容器起个名字（方便管理）

# 查看正在运行的容器
docker ps

# 查看所有容器（包括已停止的）
docker ps -a

# 停止容器
docker stop my-nginx

# 启动已停止的容器
docker start my-nginx

# 删除容器（先停止再删）
docker rm my-nginx

# 查看容器日志（软件出了问题看这里）
docker logs my-nginx
```

### 进阶常用参数

```bash
# 端口映射：把容器的端口映射到本机
docker run -d -p 8080:80 --name my-nginx nginx
# -p 8080:80 → 本机8080端口 = 容器80端口
# 访问 http://localhost:8080 就能看到 nginx 页面

# 数据卷：把本机文件夹挂载到容器里（数据不会丢）
docker run -d -v /mydata:/data --name my-db mysql
# -v /mydata:/data → 本机 /mydata 文件夹 = 容器 /data 文件夹
# 容器删了，数据还在本机

# 环境变量：给容器传配置
docker run -d -e MYSQL_ROOT_PASSWORD=123456 --name my-db mysql
# -e 设置环境变量，这里给 MySQL 设了个密码

# 进入容器内部（像 SSH 登录一样）
docker exec -it my-nginx bash
# -it 交互模式，进去后可以像在 Linux 里一样操作
# 输入 exit 退出
```

> 💡 **小白重点记住三个参数**：`-p`（端口）、`-v`（数据卷）、`-e`（环境变量）。这三个几乎每次都用。

---

## 📦 第三步：常用镜像仓库与推荐镜像

### 官方仓库

| 仓库 | 地址 | 说明 |
|------|------|------|
| Docker Hub | [hub.docker.com](https://hub.docker.com) | 官方仓库，最全，免费 |
| GitHub Container Registry | ghcr.io | GitHub 的镜像仓库 |
| 阿里云镜像仓库 | [registry.cn-hangzhou.aliyuncs.com](https://cr.console.aliyun.com/) | 国内速度快 |

> ⚠️ **国内用户注意**：Docker Hub 有时候访问慢，建议配置国内镜像加速。方法见下方。

### Docker Hub 国内镜像加速配置

编辑 Docker 的配置文件（Windows/Mac 在 Docker Desktop → Settings → Docker Engine 里直接改）：

```json
{
  "registry-mirrors": [
    "https://docker.1ms.run",
    "https://docker.xuanyuan.me"
  ]
}
```

Linux 用户编辑 `/etc/docker/daemon.json`（没有就新建），写入上面的内容，然后：

```bash
sudo systemctl restart docker
```

> 💡 配置后，`docker pull` 的速度会从几分钟变成几秒钟！

### 新手必试的常用镜像

这些镜像一条命令就能跑，非常适合练手：

| 类别 | 镜像 | 一键启动命令 | 说明 |
|------|------|-------------|------|
| 🌐 Web服务器 | nginx | `docker run -d -p 8080:80 nginx` | 最流行的Web服务器 |
| 🌐 Web服务器 | httpd | `docker run -d -p 8080:80 httpd` | Apache官方镜像 |
| 🗄️ 数据库 | mysql | `docker run -d -e MYSQL_ROOT_PASSWORD=123456 mysql` | MySQL数据库 |
| 🗄️ 数据库 | postgres | `docker run -d -e POSTGRES_PASSWORD=123456 postgres` | PostgreSQL数据库 |
| 🗄️ 缓存 | redis | `docker run -d redis` | 缓存神器，超轻量 |
| 📝 文档 | mattermost | 官网有详细教程 | 开源团队协作工具 |
| 🖥️ 面板 | portainer | 见下方 | Docker管理面板（强烈推荐） |
| 🔍 搜索 | elasticsearch | `docker run -d -p 9200:9200 -e "discovery.type=single-node" elasticsearch:8` | 全文搜索引擎 |
| 📊 可视化 | grafana | `docker run -d -p 3000:3000 grafana/grafana` | 数据可视化面板 |
| 🛡️ 代理 | nginx-proxy-manager | 见下方 | 反向代理管理面板 |
| 📁 文件 | nextcloud | `docker run -d -p 8080:80 nextcloud` | 私有云盘（替代百度网盘） |
| 💬 博客 | ghost | `docker run -d -p 2368:2368 ghost` | 专业博客系统 |
| 🎮 论坛 | flarum | 官网有详细教程 | 轻量级论坛 |

---

## 🔧 第四步：搭配 Docker 使用的工具

Docker 本身是命令行工具，对小白来说有点"硬核"。下面几个工具能让 Docker 用起来像玩手机一样简单。

### 4.1 Portainer —— Docker 的"遥控器"

**这是我最推荐的工具！** Portainer 给 Docker 加了个网页界面，所有操作点按钮就行。

| 有了 Portainer | 没有 Portainer |
|---------------|---------------|
| 点按钮启动/停止容器 | 输命令 docker start/stop |
| 网页上看容器状态、日志 | 输命令 docker ps、docker logs |
| 点按钮删除/重建容器 | 输命令 docker rm、docker run |
| 可视化看网络和数据卷 | 输命令 docker network ls |
| 一键部署应用栈 | 手写 docker-compose.yml |

**安装 Portainer：**

```bash
docker run -d \
  -p 9000:9000 \
  --name portainer \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data \
  portainer/portainer-ce
```

> 💡 Windows/Mac 用户：把 `/var/run/docker.sock` 改成 `/var/run/docker.sock`（Docker Desktop 已自动映射）。

打开浏览器访问 `http://localhost:9000`，第一次会让你设个管理员密码。设完后就能看到所有容器的状态，想启动、停止、删除，点点按钮就行。

**Portainer 能做的事：**

- 📊 实时监控容器状态（CPU、内存使用）
- 🚀 一键启动/停止/重启容器
- 📝 在网页上查看容器日志
- 🔧 在网页上进入容器终端（不用输 `docker exec`）
- 📦 直接从 Docker Hub 搜索并拉取镜像
- 🏗️ 用 Stacks（应用栈）一键部署多个容器
- 🌐 管理多个 Docker 主机（管理局域网里所有服务器）

### 4.2 Docker Compose —— 一键部署全家桶

**如果说 Docker 是搬一个集装箱，Docker Compose 就是搬一整列火车。**

很多时候一个应用需要多个容器配合——比如一个网站需要 nginx + mysql + redis + php。单独启动四个容器还要配端口、配网络、配数据卷……烦死了。

Docker Compose 就是把这些容器写在一个 `docker-compose.yml` 文件里，一条命令全部启动：

```yaml
# docker-compose.yml 示例：部署一个博客系统
version: '3'
services:
  # Web服务器
  nginx:
    image: nginx
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html
    depends_on:
      - php

  # PHP处理
  php:
    image: php:fpm
    volumes:
      - ./html:/var/www/html

  # 数据库
  mysql:
    image: mysql
    environment:
      MYSQL_ROOT_PASSWORD: 123456
      MYSQL_DATABASE: blog
    volumes:
      - mysql_data:/var/lib/mysql

  # 缓存
  redis:
    image: redis

volumes:
  mysql_data:
```

**一键启动：**

```bash
docker compose up -d    # 后台启动所有容器
docker compose down      # 停止并删除所有容器
docker compose ps        # 查看所有容器状态
docker compose logs      # 查看所有容器日志
```

> 💡 Docker Desktop 自带 Docker Compose，不用单独安装！Linux 用户需要单独装：`sudo apt install docker-compose-plugin`

### 4.3 Watchtower —— 自动更新容器

**装了一堆容器，手动更新太麻烦？Watchtower 帮你自动更新！**

Watchtower 会定期检查你运行的容器是否有新版本镜像，如果有就自动拉取新镜像、重建容器。

```bash
docker run -d \
  --name watchtower \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --interval 3600   # 每小时检查一次
```

> 💡 建议先只在测试环境用自动更新，生产环境最好手动更新——万一新版有 bug 呢？

### 4.4 Nginx Proxy Manager —— 反向代理管理面板

**如果你想让多个网站共用一台服务器，每个网站有自己的域名，这个工具太省心了。**

```bash
docker run -d \
  -p 80:80 \
  -p 443:443 \
  -p 81:81 \
  --name npm \
  --restart=always \
  -v npm_data:/data \
  -v npm_letsencrypt:/etc/letsencrypt \
  jc21/nginx-proxy-manager
```

访问 `http://localhost:81` 进入管理面板：

- 添加代理主机：填写域名 → 选择目标容器 → 保存
- 自动申请 SSL 证书（Let's Encrypt，免费！）
- 一键配置 HTTPS

### 4.5 工具速查对比

| 工具 | 作用 | 适合谁 | 必装吗？ |
|------|------|--------|----------|
| **Portainer** | Docker网页管理面板 | 所有人 | ⭐ 强烈推荐 |
| **Docker Compose** | 一键部署多容器 | 部署多服务的 | ⭐ 必装 |
| **Watchtower** | 自动更新容器 | 懒人/运维 | 看需求 |
| **Nginx Proxy Manager** | 反向代理+SSL | 多站点部署 | 看需求 |
| **cAdvisor** | 容器资源监控 | 想看性能数据 | 看需求 |
| **Traefik** | 自动反向代理 | 进阶用户 | 看需求 |

---

## 🏗️ 第五步：实战案例

### 案例1：五分钟搭建私有云盘（替代百度网盘）

想拥有自己的网盘？不用买服务器，一台电脑就行：

```bash
docker run -d \
  --name nextcloud \
  -p 8080:80 \
  -v nextcloud_data:/var/www/html \
  --restart=always \
  nextcloud
```

打开浏览器访问 `http://localhost:8080`：

1. 创建管理员账号密码
2. 开始使用！上传文件、共享链接、在线编辑……全都有

> 💡 Nextcloud 支持 WebDAV，手机上装个 Nextcloud App 就能自动同步照片。

### 案例2：一键搭建博客系统

```yaml
# docker-compose.yml
version: '3'
services:
  ghost:
    image: ghost
    ports:
      - "2368:2368"
    environment:
      url: http://localhost:2368
    volumes:
      - ghost_data:/var/lib/ghost/content
    restart: always

volumes:
  ghost_data:
```

```bash
docker compose up -d
```

访问 `http://localhost:2368`，注册管理员账号，开始写博客！

### 案例3：医院信息科的"全家桶"部署

假设信息科要部署：档案系统 + OA系统 + 数据库 + 缓存 + Web服务器

```yaml
version: '3'
services:
  # Web服务器（统一入口）
  nginx:
    image: nginx
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - archive
      - oa
    restart: always

  # 档案管理系统
  archive:
    image: your-archive-system:latest
    environment:
      DB_HOST: mysql
      DB_PASSWORD: 123456
      REDIS_HOST: redis
    restart: always

  # OA办公系统
  oa:
    image: your-oa-system:latest
    environment:
      DB_HOST: mysql
      DB_PASSWORD: 123456
    restart: always

  # MySQL数据库
  mysql:
    image: mysql
    environment:
      MYSQL_ROOT_PASSWORD: 123456
    volumes:
      - mysql_data:/var/lib/mysql
    restart: always

  # Redis缓存
  redis:
    image: redis
    restart: always

volumes:
  mysql_data:
```

一条命令 `docker compose up -d`，五个系统全部上线！

> 💡 **真实场景**：我们医院的印章管理系统和通讯录 PWA 也是用 Docker 部署的。以前装一个系统要折腾一整天，现在几分钟搞定。

---

## 🧹 第六步：日常维护

### 查看磁盘占用

```bash
# 查看 Docker 占了多少磁盘
docker system df

# 清理所有不再使用的数据（停止的容器、没用的镜像、悬空的数据卷）
docker system prune

# 深度清理（包括没有被容器引用的镜像）
docker system prune -a
```

> ⚠️ `docker system prune -a` 会删掉所有没在运行的镜像！如果你有些镜像暂时不用但想留着，别用 `-a`。

### 容器自启动

重要服务一定要设置自启动，电脑重启后容器自动恢复：

```bash
# 启动时加 --restart=always
docker run -d --restart=always --name my-nginx nginx

# 已有的容器修改自启动策略
docker update --restart=always my-nginx
```

### 数据备份

数据库等重要数据一定要做数据卷备份：

```bash
# 备份一个数据卷
docker run --rm -v mysql_data:/data -v $(pwd):/backup alpine tar czf /backup/mysql_backup.tar.gz /data

# 恢复数据卷
docker run --rm -v mysql_data:/data -v $(pwd):/backup alpine tar xzf /backup/mysql_backup.tar.gz -C /
```

> 💡 或者更简单：直接把数据卷挂载到本机文件夹（用 `-v` 参数），然后用常规备份工具备份本机文件夹就行。

---

## 🗺️ 速查表：Docker 全流程

```
Docker 入门路线图
│
├─ 第1步：安装
│   ├─ Windows → Docker Desktop（官网下载）
│   ├─ Mac → Docker Desktop（官网下载）
│   ├─ Linux → curl -fsSL https://get.docker.com | sh
│   └─ 验证 → docker run hello-world
│
├─ 第2步：常用命令（就记这几个）
│   ├─ 拉镜像 → docker pull xxx
│   ├─ 启容器 → docker run -d -p 端口 -v 数据 --name 名字 xxx
│   ├─ 看状态 → docker ps
│   ├─ 看日志 → docker logs 名字
│   ├─ 停容器 → docker stop 名字
│   └─ 删容器 → docker rm 名字
│
├─ 第3步：装管理工具
│   ├─ Portainer → 网页管理面板（强烈推荐）
│   ├─ Docker Compose → 一键部署全家桶
│   └─ Watchtower → 自动更新容器
│
├─ 第4步：实战练手
│   ├─ 私有云盘 → docker run nextcloud
│   ├─ 博客系统 → docker compose up ghost
│   └─ 数据库   → docker run mysql
│
└─ 第5步：日常维护
    ├─ 清理 → docker system prune
    ├─ 自启动 → --restart=always
    └─ 备份 → 数据卷挂载到本机
```

---

## ⚠️ 常见问题与踩坑

### Q1：Docker Desktop 启动报错？

**最常见原因：** WSL2 没装或没更新。

解决：
```bash
wsl --install
wsl --update
```

重启电脑再试。

### Q2：拉镜像特别慢？

**原因：** Docker Hub 在国外，国内访问慢。

解决：配置国内镜像加速（见本文「镜像加速配置」部分）。

### Q3：容器启动后马上就退出了？

**排查：** 看日志！

```bash
docker logs 容器名
```

90% 的问题看日志就能找到原因——端口被占、密码没设、配置写错……

### Q4：容器里数据丢了？

**原因：** 没用数据卷（`-v`），容器删了数据就没了。

解决：重要数据一定要用 `-v` 挂载到本机：
```bash
docker run -d -v /本机路径:/容器路径 --name xxx xxx
```

### Q5：端口被占用？

**排查：**
```bash
# Windows 查看谁占了端口
netstat -ano | findstr :8080

# Linux/Mac 查看谁占了端口
lsof -i :8080
```

解决：换个端口，或者先停掉占用端口的程序。

### Q6：docker compose 命令找不到？

**原因：** 旧版用 `docker-compose`（带横线），新版用 `docker compose`（空格）。

Docker Desktop 自带新版，Linux 需要装插件：
```bash
sudo apt install docker-compose-plugin
```

---

## 📚 进阶推荐

当你玩熟了基础命令，可以看看这些进阶内容：

| 方向 | 推荐资源 | 说明 |
|------|---------|------|
| 📖 官方文档 | [docs.docker.com](https://docs.docker.com) | 最权威，英文 |
| 🎓 免费教程 | [Docker — 从入门到实践](https://yeasy.gitbook.io/docker_practice/) | 中文，非常全面 |
| 🎬 视频教程 | B站搜索「Docker入门」 | 选播放量高的 |
| 🏗️ Dockerfile | 编写自己的镜像 | 按需打包，更灵活 |
| 🔗 多容器编排 | Docker Swarm / Kubernetes | 多机器集群管理 |
| 🔐 安全加固 | Docker Security | 生产环境必学 |

> 💡 **小白建议**：先学会 `docker run` 和 `docker compose`，能部署常用软件就够了。Dockerfile、Swarm、K8s 这些进阶内容，等你有需求了再学，别被吓到。

---

## 写在最后

Docker 这个东西，就像快递柜一样——你不需要知道快递柜的电路怎么走、锁怎么设计，你只需要知道：**把东西放进去，取出来就能用。**

**总结三句话：**

1. 🐳 **Docker 是集装箱** — 软件和环境打包在一起，搬到哪都能用
2. 🎛️ **Portainer 是遥控器** — 网页上点点按钮就能管所有容器
3. 🚂 **Compose 是火车** — 一个文件一条命令，全家桶一键上线

记住：**技术不是拿来炫的，是拿来解决问题的。** 你能用 Docker 十分钟部署一个系统，比折腾三天装环境强太多了。

下次领导让你部署系统，别慌，先 `docker pull`，再 `docker run`，完事。

---

> 📌 **相关阅读**：
> - [电脑越用越卡？零基础教你恢复如初](/blog/2026/06/17/pc-slow-fix-guide/)
> - [Git到底是个啥？给电脑小白讲的版本管理入门课](/blog/2026/06/16/git-for-beginners/)
> - [零基础搭博客：从注册账号到文章上线全流程](/blog/2026/06/16/build-your-blog/)