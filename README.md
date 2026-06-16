# 老墨的博客

> 在平凡的岗位上，做不平凡的事

🔗 **线上地址：** [https://dalihaif.github.io/blog/](https://dalihaif.github.io/blog/)

---

## 这个博客是怎么搭的？

简单说，就是三样东西组合起来的：

1. **Jekyll** — 一个把 Markdown 文章变成网页的工具（相当于"排版软件"）
2. **Hux Blog 主题** — 别人做好的博客"装修模板"，拿来改改就能用
3. **GitHub Pages** — 免费帮你放网页的服务器（相当于免费"房东"）

你写文章 → Jekyll 帮你排版 → GitHub 免费帮你发布 → 全世界都能看到

---

## 从零开始搭建（手把手教学）

### 第一步：注册 GitHub 账号

如果你还没有 GitHub 账号：
1. 打开 https://github.com/signup
2. 填用户名、邮箱、密码，点注册
3. 去邮箱里点确认链接

> 记住你的用户名，后面会用到。我的用户名是 `dalihaif`。

### 第二步：复制博客模板

1. 打开这个地址：https://github.com/Huxpro/huxpro.github.io
2. 点右上角的 **Fork** 按钮（就是"复制一份到我自己账号下"的意思）
3. 等待复制完成，你会看到自己账号下多了一个仓库
4. 点 **Settings**（设置），把仓库名改成你想要的名字，比如 `blog`
5. 把这个仓库 **Clone**（下载）到你电脑上

> 💡 怎么下载？装一个 [GitHub Desktop](https://desktop.github.com/)，登录后点 Clone 就行，比敲命令简单多了。

### 第三步：安装必要软件

只需要装一个软件：**Ruby**（Jekyll 运行需要它）

1. 打开 https://rubyinstaller.org/downloads/
2. 下载 **Ruby+Devkit 3.3.x (x64)** 那个版本
3. 双击安装，**一路默认，全部勾选**，特别是 "Add Ruby executables to your PATH" 必须勾选
4. 安装完会弹出一个黑色命令行窗口，输入 `3` 回车（安装 MSYS2），等它跑完

装好后验证一下：打开命令提示符（Win+R 输入 cmd），输入：

```
ruby --version
```

如果显示版本号，就说明装好了。

### 第四步：改配置文件

用记事本或 VS Code 打开项目里的 `_config.yml` 文件，改这几个地方：

```yaml
# 改成你自己的信息
title: 你的博客名字
description: "一句话介绍你的博客"
url: "https://你的用户名.github.io"
baseurl: "/blog"          # 如果仓库名叫 blog 就填 /blog

# 侧边栏显示的内容
sidebar-about-description: "一句话介绍你自己"
sidebar-avatar: /img/你的头像文件名.jpg

# 导航菜单（就是页面顶部的几个按钮）
nav:
  - title: "博客"
    url: "/"
  - title: "档案"
    url: "/archive.html"
  - title: "关于"
    url: "/about.html"
```

> ⚠️ **最重要的一行是 `baseurl`！** 因为你的博客地址是 `用户名.github.io/blog`（不是 `用户名.github.io`），所以必须设置 baseurl，否则图片、样式全都会加载不出来。

### 第五步：换上你自己的图片

找到项目里的 `img/` 文件夹，替换这几张图：

| 图片文件 | 干什么用的 | 尺寸建议 |
|---------|-----------|---------|
| `img/home-bg.jpg` | 首页的大背景图 | 宽 1920px，高清大图 |
| `img/avatar-mo.jpg` | 侧边栏的小头像 | 正方形，至少 512×512 |

> 💡 直接把你的新图片改成相同的文件名覆盖进去就行。格式支持 jpg、png。

还有 PWA 图标（就是手机添加到桌面后显示的图标），在 `pwa/icons/` 文件夹：

| 文件 | 尺寸 |
|------|------|
| `128.png` | 128×128 |
| `192.png` | 192×192 |
| `512.png` | 512×512 |

> 💡 不想一个个做？可以用 Python 一键从头像生成三种尺寸（后面有代码）。

### 第六步：本地预览

打开命令提示符，进入项目目录，运行以下命令：

```bash
# 1. 先换成国内镜像源（不然下载依赖会非常慢）
gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/

# 2. 安装依赖包（第一次需要，之后就不用了）
cd 你的项目路径
bundle install

# 3. 启动本地预览
bundle exec jekyll serve --baseurl "/blog"
```

然后打开浏览器，访问 http://localhost:4000/blog/ 就能看到你的博客了！

> 💡 我做了一个 `启动博客.bat` 双击就能启动，不用每次敲命令。

### 第七步：写文章

在 `_posts/` 文件夹里新建一个文件，**文件名必须是这种格式**：

```
2026-06-16-my-first-post.md
```

就是：`年-月-日-英文简述.md`

文件内容模板（直接复制改就行）：

```markdown
---
layout: post
title: "我的第一篇博客"
subtitle: "副标题，一句话概括文章"
date: 2026-06-16
author: "你的名字"
header-img: "img/post-bg-desk.jpg"
tags:
  - 随笔
  - 技术
---

## 这里开始写正文

用 Markdown 语法写文章，和写微信差不多：

- 用 # 号表示标题
- 用 - 号表示列表
- 用 **加粗** 表示重点

写完保存，本地刷新就能看到效果。
```

> 💡 `header-img` 是文章顶部的大图，可以每篇文章用不同的图。

### 第八步：发布到网上

文章写好了，怎么让别人看到？上传到 GitHub 就行：

```bash
git add -A
git commit -m "发布新文章"
git push origin master
```

> 💡 用 GitHub Desktop 的话更简单：写完文章后打开 GitHub Desktop，它会自动检测到变更，写个说明点 Commit，再点 Push 就行了。

上传后等 1-2 分钟，GitHub 会自动帮你构建发布，然后打开 `https://你的用户名.github.io/blog/` 就能看到新文章了！

> 💡 以后每次写新文章，重复第七步和第八步就行了。

---

## PWA 是什么？怎么配？

PWA 就是让你的博客像手机 App 一样，可以**添加到手机桌面**，而且**断网也能看之前浏览过的页面**。

### 修改应用清单 `pwa/manifest.json`

这个文件决定了"添加到桌面"后显示什么信息：

```json
{
  "name": "你的博客名字",
  "short_name": "短名字",
  "start_url": "https://你的用户名.github.io/blog/",
  "display": "standalone",
  "theme_color": "#000",
  "background_color": "#fff"
}
```

### 用 Python 一键生成三种尺寸图标

```python
from PIL import Image
img = Image.open('img/你的头像.jpg')
for size in [128, 192, 512]:
    img.resize((size, size), Image.LANCZOS).save(f'pwa/icons/{size}.png')
```

### Service Worker 离线功能

项目里的 `sw.js` 就是控制离线缓存的。**关键一点**：这个文件开头必须加两行 `---`，不然 Jekyll 不会处理里面的变量：

```
---
---
// 后面才是正式代码...
```

同理，`js/sw-registration.js` 也要加。这俩文件里所有路径都要用 `{{ site.baseurl }}` 开头，不然部署后路径不对。

---

## 项目文件夹说明

不用全懂，知道哪个文件夹干什么就行：

```
blog/
├── _config.yml       ← 💡 总配置文件，改博客名字、头像都在这里
├── _posts/           ← 💡 文章放这里，最常用的文件夹
├── img/              ← 💡 图片放这里
├── pwa/icons/        ← 💡 手机桌面图标放这里
├── _layouts/         页面布局模板（一般不用改）
├── _includes/        页面组件（导航栏、侧边栏等）
├── js/               JavaScript 脚本
├── css/              样式文件
├── sw.js             离线缓存配置
├── offline.html      断网时显示的页面
├── portfolio.md      作品集页面
├── about.md          关于我页面
├── archive.html      文章归档页
├── 404.html          页面找不到时显示
├── Gemfile           Ruby 依赖声明（不用管）
└── 启动博客.bat       双击启动本地预览（Windows）
```

---

## 踩过的坑（遇到问题看这里）

### 🔴 坑1：图片和样式全都不显示（404）

**原因：** 博客部署在 `用户名.github.io/blog/` 这个子路径下，但模板里写的是 `/img/xxx.jpg`，浏览器会去找 `用户名.github.io/img/xxx.jpg`，当然找不到。

**解决办法：** 把所有资源路径改成 `{{ site.baseurl }}/img/xxx.jpg`，需要改这几个文件：
- `_layouts/default.html`（微信图标路径）
- `_includes/footer.html`（搜索功能路径）
- `js/sw-registration.js`（Service Worker 注册路径）
- `sw.js`（预缓存列表里的所有路径）

### 🔴 坑2：Jekyll 构建报错 `Errno::EINVAL`

**原因：** Windows 系统有个保留名叫 `nul`（相当于 Linux 的黑洞设备），如果你的项目里不小心出现了一个叫 `nul` 的文件，Jekyll 想处理它时 Windows 就会报错。

**解决办法：**
1. 删掉项目根目录下的 `nul` 文件
2. 在 `_config.yml` 的 exclude 列表里加上 `"nul"`
3. 在 `.gitignore` 里也加上 `nul`

### 🔴 坑3：git push 报 403 没权限

**原因：** GitHub 推送代码需要验证身份。如果你用 Fine-grained Token（细粒度令牌），默认没有写入权限。

**解决办法：** 创建 Token 时要注意：
1. Repository access 选 **Only select repositories**，勾选你的 blog 仓库
2. Repository permissions 里找到 **Contents**，选 **Read and write**
3. 生成后复制 Token，推送时用：
```bash
git -c credential.helper='!f() { echo username=你的用户名; echo password=你的Token; }; f' push origin master
```

---

## 一键生成 PWA 图标

如果你装了 Python，把下面代码保存为 `make_icons.py` 放在项目根目录，双击运行就行：

```python
"""从头像一键生成 PWA 所需的三种尺寸图标"""
from PIL import Image
import os

avatar = 'img/avatar-mo.jpg'  # 改成你的头像文件名
img = Image.open(avatar)

# 裁剪为正方形
w, h = img.size
s = min(w, h)
left = (w - s) // 2
top = (h - s) // 2
img = img.crop((left, top, left + s, top + s))

# 生成三种尺寸
for size in [128, 192, 512]:
    path = f'pwa/icons/{size}.png'
    img.resize((size, size), Image.LANCZOS).save(path)
    print(f'已生成: {path} ({size}x{size})')

print('全部完成！')
```

---

## 联系方式

- **GitHub:** [@dalihaif](https://github.com/dalihaif)
- **Email:** [dlaihaif@qq.com](mailto:dlaihaif@qq.com)

## 许可证

基于 [Hux Blog](https://github.com/Huxpro/huxpro.github.io) 主题（Apache License 2.0）二次开发。

代码遵循 Apache 2.0 协议，文章内容版权归作者所有。
