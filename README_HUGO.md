# 🎉 老墨的博客 - Hugo + PaperMod 主题

这是一个基于 **Hugo** 静态网站生成器和 **PaperMod** 主题的现代化博客，完全不需要 Ruby！

## ✨ 特性

- 🚀 **极速构建**：Hugo 使用 Go 语言，构建速度毫秒级
- 🎨 **现代设计**：PaperMod 主题简洁优雅，支持暗黑模式
- 📱 **响应式**：完美适配手机、平板、电脑
- 🔍 **内置搜索**：快速查找文章
- 📊 **自动 TOC**：自动生成文章目录
- 💻 **代码高亮**：优秀的代码展示
- 🌙 **暗黑模式**：自动/手动切换
- 📦 **零依赖**：只需一个 Hugo 可执行文件

## 📁 项目结构

```
blog-hugo/
├── content/
│   ├── posts/              # 博客文章
│   │   ├── 2026-06-15-archive-management-tutorial.md
│   │   ├── 2026-06-15-ai-prompts-collection.md
│   │   ├── 2026-06-15-archive-label-printer.md
│   │   └── 2026-06-15-autobiography-first-meeting.md
│   ├── about.md            # 关于页面
│   └── archives.md         # 归档页面
├── themes/
│   └── PaperMod/           # PaperMod 主题
├── hugo.toml               # 配置文件
└── 启动博客.bat             # 启动脚本
```

## 🚀 快速开始

### 1. Hugo 已安装 ✅

Hugo 已通过 winget 安装到：
```
C:\Users\Administrator\AppData\Local\Microsoft\WinGet\Packages\Hugo.Hugo.Extended_...\hugo.exe
```

### 2. 启动博客

**双击运行：**
```
启动博客.bat
```

**或在命令行运行：**
```bash
cd g:\web\blog-hugo
hugo server --buildDrafts
```

### 3. 访问博客

在浏览器中打开：
```
http://localhost:1313/blog/
```

## ⚠️ 重要：修复文章编码问题

由于从 Jekyll 迁移时出现了编码问题，需要手动修复文章的 Front Matter。

### 修复步骤：

打开每篇文章，将 Front Matter 改为以下格式：

```markdown
---
title: "文章标题"
date: 2026-06-15T10:00:00+08:00
draft: false
tags: ["标签1", "标签2", "标签3"]
categories: ["分类"]
author: "李海峰"
description: "文章描述"
---

文章内容...
```

### 需要修复的文件：

1. `content/posts/2026-06-15-ai-prompts-collection.md`
2. `content/posts/2026-06-15-archive-label-printer.md`
3. `content/posts/2026-06-15-autobiography-first-meeting.md`

**注意：** `2026-06-15-archive-management-tutorial.md` 已经修复好了！

## 📝 添加新文章

### 方法1：使用 Hugo 命令

```bash
hugo new content posts/my-new-post.md
```

### 方法2：手动创建

在 `content/posts/` 目录创建 `.md` 文件，命名格式：`YYYY-MM-DD-title.md`

### 文章模板

```markdown
---
title: "我的新文章"
date: 2026-06-15T10:00:00+08:00
draft: false
tags: ["标签1", "标签2"]
categories: ["分类"]
author: "李海峰"
description: "文章简短描述"
---

## 引言

文章内容...

## 正文

更多内容...
```

## ⚙️ 配置说明

主要配置在 `hugo.toml` 文件中：

```toml
baseURL = 'https://dalihaif.github.io/blog/'
languageCode = 'zh-cn'
title = '老墨的博客'
theme = 'PaperMod'

[params]
  author = "李海峰"
  description = "一个在医院档案室里写代码、做设计、玩区块链的 70 后技术爱好者"
  defaultTheme = "auto"  # auto, light, dark
```

## 🎨 自定义主题

### 修改颜色

编辑 `themes/PaperMod/assets/css/common/variables.css`

### 添加自定义 CSS

创建 `assets/css/extended/custom.css`，添加你的样式

### 修改布局

复制 `themes/PaperMod/layouts/` 中的文件到项目根目录的 `layouts/`，然后修改

## 📦 部署到 GitHub Pages

### 方法1：使用 GitHub Actions（推荐）

1. 推送代码到 GitHub
2. 在仓库 Settings → Pages 中启用
3. 选择 Source: Deploy from a branch
4. Branch: master / (root)
5. 等待构建完成

### 方法2：手动构建

```bash
hugo --baseURL "https://dalihaif.github.io/blog/"
# 将 public/ 目录的内容推送到 GitHub Pages
```

## 🔧 常用命令

### 本地预览

```bash
hugo server --buildDrafts
```

### 构建站点

```bash
hugo --minify
```

### 创建新文章

```bash
hugo new content posts/article-name.md
```

### 更新主题

```bash
cd themes/PaperMod
git pull
```

## 📚 PaperMod 主题文档

- **官方演示**: https://adityatelange.github.io/hugo-PaperMod/
- **GitHub**: https://github.com/adityatelange/hugo-PaperMod
- **文档**: https://github.com/adityatelange/hugo-PaperMod/wiki

## ❓ 常见问题

### Q: Hugo 命令找不到？

A: 重启终端或 PowerShell，或者使用完整路径：
```
C:\Users\Administrator\AppData\Local\Microsoft\WinGet\Packages\Hugo.Hugo.Extended_...\hugo.exe
```

### Q: 文章不显示？

A: 检查：
1. Front Matter 格式是否正确
2. `draft: false` 是否设置
3. 日期是否在未来（未来日期的文章默认不显示）

### Q: 如何启用评论系统？

A: 在 `hugo.toml` 中添加：
```toml
[params]
  [params.comments]
    enabled = true
    provider = "giscus"
    
    [params.comments.giscus]
      repo = "dalihaif/blog"
      repoID = "xxx"
      category = "General"
      categoryID = "xxx"
```

### Q: 如何添加 Google Analytics？

A: 在 `hugo.toml` 中添加：
```toml
[services]
  [services.googleAnalytics]
    ID = "G-XXXXXXXXXX"
```

## 💬 联系方式

- **邮箱**：dlaihaif@qq.com
- **GitHub**：[dalihaif](https://github.com/dalihaif)

---

> "平凡的人也可以有不平凡的人生。"

**最后更新**：2026年6月15日
