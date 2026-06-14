# 老墨的个人博客

> 在平凡的岗位上，做不平凡的事

这是一个基于 Jekyll 构建的个人博客，用于展示我的技术实践、设计作品和生活思考。

## 📝 关于我

- **姓名：** 李海峰（网名：老墨）
- **职业：** 大理大学第一附属医院 档案室
- **技术栈：** 前端开发、平面设计、区块链应用、办公自动化
- **GitHub：** [@dalihaif](https://github.com/dalihaif)
- **座右铭：** 技术改变工作，设计美化生活

## 🚀 快速开始

### 本地预览

1. **安装依赖**
   ```bash
   bundle install
   ```

2. **启动本地服务器**
   ```bash
   bundle exec jekyll serve
   ```

3. **访问博客**
   打开浏览器访问：http://localhost:4000/blog/

### 部署到 GitHub Pages

博客已配置为自动部署到 GitHub Pages：

1. 将代码推送到 `blog` 仓库的 `main` 分支
2. GitHub Actions 会自动构建并部署
3. 访问：https://dalihaif.github.io/blog/

## 📂 项目结构

```
blog/
├── _posts/          # 博客文章
├── _includes/       # 页面组件
├── _layouts/        # 页面布局
├── img/             # 图片资源
├── css/             # 样式文件
├── js/              # JavaScript 文件
├── about.md         # 关于我页面
├── portfolio.md     # 作品集页面
└── _config.yml      # 站点配置
```

## ✍️ 写新文章

在 `_posts/` 目录下创建新的 Markdown 文件，命名格式：`YYYY-MM-DD-title.md`

示例：
```markdown
---
layout: post
title: "文章标题"
subtitle: "副标题（可选）"
date: 2024-01-15
author: "李海峰"
header-img: "img/home-bg.jpg"
tags:
  - 标签1
  - 标签2
---

文章内容...
```

## 🎨 自定义内容

### 修改个人信息

编辑 `_config.yml` 文件：
- `title`: 博客标题
- `email`: 联系邮箱
- `description`: 博客描述
- `github_username`: GitHub 用户名

### 更新关于我页面

编辑 `about.md` 文件，修改个人介绍、技能展示等内容。

### 添加作品集

编辑 `portfolio.md` 文件，添加新的项目展示。

## 📱 主要功能

- ✅ 响应式设计，支持移动端
- ✅ PWA 渐进式 Web 应用
- ✅ 代码高亮显示
- ✅ 标签分类系统
- ✅ RSS 订阅
- ✅ 社交分享链接
- ✅ 搜索功能

## 🛠️ 技术栈

- **Jekyll** - 静态网站生成器
- **Bootstrap** - UI 框架
- **Less** - CSS 预处理器
- **Rouge** - 代码高亮
- **GitHub Pages** - 托管平台

## 📫 联系方式

- **Email:** dlaihaif@qq.com
- **电话:** 13988531240
- **GitHub:** https://github.com/dalihaif

## 📄 许可证

本项目采用 Apache License 2.0 许可证。

---

© 2024 老墨的博客 | 用代码和画笔记录生活
