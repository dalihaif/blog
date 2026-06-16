---
layout: post
title: "零基础搭博客：从注册账号到文章上线全流程"
subtitle: "Jekyll + GitHub Pages 免费建站，手把手教你拥有自己的博客"
date: 2026-06-16
author: "老墨"
header-img: "img/post-bg-dreamer.jpg"
tags:
  - Jekyll
  - GitHub Pages
  - 博客搭建
  - PWA
  - 教程
categories:
  - 技术实践
---

## 📖 写在前面

我是个档案管理员，不是程序员。2024年的时候，我连 GitHub 是什么都不知道。但现在，我有了一个自己的博客网站，全世界都能访问，而且**一分钱没花**。

这篇文章就是想把我的搭建过程完整记录下来——从注册账号到文章上线，每一步都写清楚。如果你也想要一个自己的博客，跟着做就行。

---

## 🎯 为什么要自己搭博客？

现在写东西的平台太多了——微信公众号、知乎、CSDN、简书……为什么还要自己搭？

我的理由很简单：

| 平台 | 问题 |
|------|------|
| 微信公众号 | 排版痛苦，代码显示差，修改要重新群发 |
| 知乎/CSDN | 广告多，有审核，文章不是你的 |
| 简书 | 排版有限，样式不自由 |

自己搭的博客：

- **完全属于你**——域名、内容、样式，全部你说了算
- **没有广告**——干干净净，只有你的文字
- **没有审核**——写什么发什么，不用等审核通过
- **代码友好**——技术文章代码高亮显示，排版漂亮
- **免费**——GitHub Pages 白送你一个网站空间

---

## 🏗️ 三个东西组合起来

博客是怎么搭出来的？说穿了就是三样东西：

1. **Jekyll** — 一个"排版软件"，你写 Markdown 文章，它帮你变成漂亮的网页
2. **博客主题** — 别人做好的"装修模板"，拿来改改就能用，不用从零设计
3. **GitHub Pages** — 免费的"房东"，帮你把网页放到互联网上

流程很简单：**你写文章 → Jekyll 帮你排版 → GitHub 免费帮你发布 → 全世界都能看到**

---

## 🚀 八步搭建全流程

### 第一步：注册 GitHub 账号

GitHub 是全世界最大的代码托管平台，可以理解为一个"存文件的地方"。

1. 打开 https://github.com/signup
2. 填用户名、邮箱、密码，点注册
3. 去邮箱里点确认链接

> 记住你的用户名，后面会反复用到。我的用户名是 `dalihaif`，所以我的博客地址就是 `dalihaif.github.io/blog/`。

### 第二步：复制博客模板

不用从零开始写网页！有人已经做好了一个很漂亮的博客模板，我们"Fork"一份过来就行（Fork 就是"复制一份到我自己账号下"的意思）。

1. 打开 https://github.com/Huxpro/huxpro.github.io
2. 点右上角的 **Fork** 按钮
3. 等待复制完成
4. 进 Settings，把仓库名改成你想要的名字（比如 `blog`）
5. 把这个仓库 Clone（下载）到你电脑上

> 💡 下载推荐用 [GitHub Desktop](https://desktop.github.com/)，图形界面操作，比敲命令简单多了。

### 第三步：安装 Ruby

Ruby 是 Jekyll 运行需要的环境，装一个就行：

1. 打开 https://rubyinstaller.org/downloads/
2. 下载 **Ruby+Devkit 3.3.x (x64)**
3. 双击安装，**一路默认，全部勾选**
4. 安装完弹出的黑色窗口里输入 `3` 回车，等它跑完

验证：打开命令提示符（Win+R 输入 cmd），输入 `ruby --version`，显示版本号就装好了。

### 第四步：改配置文件

用记事本或 VS Code 打开项目里的 `_config.yml`，改这几个地方：

```yaml
title: 你的博客名字
description: "一句话介绍你的博客"
url: "https://你的用户名.github.io"
baseurl: "/blog"          # 仓库名叫 blog 就填 /blog

sidebar-about-description: "一句话介绍你自己"
sidebar-avatar: /img/你的头像文件名.jpg
```

> ⚠️ **最重要的一行是 `baseurl`！** 因为你的博客地址是 `用户名.github.io/blog`（不是 `用户名.github.io`），所以必须设置 baseurl，否则图片、样式全都会加载不出来。这是我踩过的最大的坑，后面会细说。

### 第五步：换上你自己的图片

找到项目里的 `img/` 文件夹，替换这两张图：

| 图片 | 用途 | 建议 |
|------|------|------|
| `img/home-bg.jpg` | 首页大背景图 | 宽 1920px 的高清大图 |
| `img/avatar-xxx.jpg` | 侧边栏头像 | 正方形，至少 512×512 |

直接把你的新图片改成相同的文件名覆盖进去就行。

还有 PWA 图标（手机添加到桌面后显示的图标），在 `pwa/icons/` 文件夹，需要 128×128、192×192、512×512 三种尺寸。不想一个个做？后面有一键生成的 Python 代码。

### 第六步：本地预览

打开命令提示符，进入项目目录：

```bash
# 先换成国内镜像源（不然下载依赖非常慢）
gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/

# 安装依赖（第一次需要，之后就不用了）
bundle install

# 启动本地预览
bundle exec jekyll serve --baseurl "/blog"
```

打开浏览器访问 http://localhost:4000/blog/ ，就能看到你的博客了！

> 💡 我做了一个 `启动博客.bat`，双击就能启动，不用每次敲命令。

### 第七步：写文章

在 `_posts/` 文件夹里新建文件，**文件名必须是这种格式**：

```
2026-06-16-my-first-post.md
```

就是：`年-月-日-英文简述.md`

文件内容模板：

```markdown
---
layout: post
title: "我的第一篇博客"
subtitle: "副标题，一句话概括文章"
date: 2026-06-16
author: "你的名字"
header-img: "img/post-bg-dreamer.jpg"
tags:
  - 随笔
---

## 这里开始写正文

用 Markdown 语法写文章，和写微信差不多：

- 用 # 号表示标题
- 用 - 号表示列表
- 用 **加粗** 表示重点
```

写完保存，本地刷新就能看到效果。

### 第八步：发布到网上

文章写好了，上传到 GitHub 就行：

```bash
git add -A
git commit -m "发布新文章"
git push origin master
```

用 GitHub Desktop 更简单：写完文章后打开它，自动检测到变更，写个说明点 Commit，再点 Push。

上传后等 1-2 分钟，打开 `https://你的用户名.github.io/blog/` 就能看到新文章了！

> 以后每次写新文章，重复第七步和第八步就行。

---

## 🐛 踩过的坑

搭建过程中我踩了不少坑，记录下来，希望你不用再踩。

### 🔴 坑1：图片和样式全都不显示（404）

这是最常见的坑。**原因**：博客部署在 `用户名.github.io/blog/` 这个子路径下，但模板里写的是 `/img/xxx.jpg`，浏览器会去找 `用户名.github.io/img/xxx.jpg`，当然找不到。

**解决办法**：把所有资源路径改成 `{{ site.baseurl }}/img/xxx.jpg`，需要改这几个文件：

- `_layouts/default.html` — 微信图标路径
- `_includes/footer.html` — 搜索功能路径
- `js/sw-registration.js` — Service Worker 注册路径
- `sw.js` — 预缓存列表里的所有路径

这几个文件里，凡是看到 `/img/`、`/sw.js`、`/search.json` 这种硬编码路径，前面都要加上 `{{ site.baseurl }}`。

### 🔴 坑2：Jekyll 构建报错 `Errno::EINVAL`

**原因**：Windows 系统有个保留名叫 `nul`（相当于 Linux 的"黑洞设备"），如果你的项目里不小心出现了一个叫 `nul` 的文件，Jekyll 想处理它时 Windows 就会报错。

**解决办法**：
1. 删掉项目根目录下的 `nul` 文件
2. 在 `_config.yml` 的 exclude 列表里加上 `"nul"`
3. 在 `.gitignore` 里也加上 `nul`

### 🔴 坑3：git push 报 403 没权限

**原因**：GitHub 推送代码需要验证身份。如果用 Fine-grained Token（细粒度令牌），默认没有写入权限。

**解决办法（推荐用 SSH）**：

SSH 是一劳永逸的方式——配置一次，以后推送再也不用输密码：

```bash
# 1. 生成 SSH 密钥
ssh-keygen -t ed25519 -C "你的邮箱"

# 2. 查看公钥
cat ~/.ssh/id_ed25519.pub

# 3. 把公钥添加到 GitHub → Settings → SSH and GPG keys

# 4. 把仓库地址改成 SSH 格式
git remote set-url origin git@github.com:你的用户名/blog.git

# 5. 以后直接 push 就行
git push origin master
```

---

## 📱 PWA：让博客像手机 App 一样

PWA（Progressive Web App）就是让你的博客可以**添加到手机桌面**，而且**断网也能看之前浏览过的页面**。

### 修改应用清单

`pwa/manifest.json` 这个文件决定了"添加到桌面"后显示什么：

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

不想手动做 128×128、192×192、512×512 三种尺寸？Python 帮你：

```python
from PIL import Image

avatar = 'img/你的头像.jpg'
img = Image.open(avatar)

# 裁剪为正方形
w, h = img.size
s = min(w, h)
left, top = (w - s) // 2, (h - s) // 2
img = img.crop((left, top, left + s, top + s))

# 生成三种尺寸
for size in [128, 192, 512]:
    img.resize((size, size), Image.LANCZOS).save(f'pwa/icons/{size}.png')
    print(f'已生成: {size}x{size}')
```

把这段代码保存为 `make_icons.py`，双击运行就行。

### Service Worker 离线功能

`sw.js` 控制离线缓存。**关键一点**：这个文件开头必须加两行 `---`，不然 Jekyll 不会处理里面的变量：

```
---
---
// 后面才是正式代码...
```

同理，`js/sw-registration.js` 也要加。这俩文件里所有路径都要用 `{{ site.baseurl }}` 开头。

---

## 📁 项目文件夹速查

不用全懂，知道哪个文件夹干什么就行：

| 路径 | 干什么用的 |
|------|-----------|
| `_config.yml` | 💡 总配置文件，改名字、头像都在这 |
| `_posts/` | 💡 文章放这里，最常用 |
| `img/` | 💡 图片放这里 |
| `pwa/icons/` | 💡 手机桌面图标放这里 |
| `_layouts/` | 页面布局模板（一般不用改） |
| `_includes/` | 页面组件（导航栏、侧边栏等） |
| `sw.js` | 离线缓存配置 |
| `启动博客.bat` | 双击启动本地预览（Windows） |

---

## 💡 写在最后

回过头看，搭建这个博客最大的难关不是技术，而是**不知道该改哪里**。

Jekyll 博客的坑其实就那么几个——`baseurl` 路径、`nul` 文件冲突、Git 权限——解决之后就一帆风顺了。

如果你也想拥有一个自己的博客，别被"代码"这两个字吓住。按照这篇文章的步骤走，注册个账号、Fork 个模板、改改配置、写篇文章、Push 上去，一个属于你的博客就诞生了。

**技术不一定要多厉害，能解决自己的问题就够了。**

---

> *老墨，大理大学第一附属医院档案室，2026年6月*
