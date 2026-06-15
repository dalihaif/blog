# 部署指南

## 🚀 快速部署到 GitHub Pages

### 方法一：使用 GitHub Actions（推荐）

1. **将代码推送到 GitHub**
   ```bash
   cd g:\web\blog-new
   git init
   git add .
   git commit -m "Initial commit: 老墨的个人博客"
   git branch -M main
   git remote add origin https://github.com/dalihaif/blog.git
   git push -u origin main
   ```

2. **启用 GitHub Pages**
   - 访问：https://github.com/dalihaif/blog/settings/pages
   - Source 选择：GitHub Actions
   - 保存设置

3. **等待自动部署**
   - GitHub Actions 会自动构建并部署
   - 大约需要 2-5 分钟
   - 访问：https://dalihaif.github.io/blog/

### 方法二：手动部署

如果你想使用 `gh-pages` 分支部署：

1. 安装 `jekyll-deploy` gem
2. 配置 `_config.yml` 中的部署设置
3. 运行 `bundle exec jekyll deploy`

---

## 📝 本地开发

### 安装 Ruby 环境

1. 下载 Ruby Installer：https://rubyinstaller.org/
2. 安装时勾选 "Add Ruby to PATH"
3. 验证安装：
   ```bash
   ruby --version
   gem --version
   ```

### 启动本地服务器

**方式一：使用批处理文件**
```bash
双击 "启动博客.bat"
```

**方式二：命令行**
```bash
cd g:\web\blog-new
bundle install
bundle exec jekyll serve --baseurl "/blog"
```

访问：http://localhost:4000/blog/

---

## ✍️ 发布新文章

1. 在 `_posts/` 目录创建新文件
2. 文件名格式：`YYYY-MM-DD-title.md`
3. 添加 Front Matter（文章头部信息）
4. 编写 Markdown 内容
5. 提交并推送代码

示例：
```markdown
---
layout: post
title: "我的第一篇文章"
date: 2024-01-15
author: "老墨"
tags:
  - 技术
  - 随笔
---

文章内容...
```

---

## 🎨 自定义主题

### 修改配色

编辑 `css/` 目录下的样式文件，或修改 `_config.yml` 中的主题色：

```yaml
chrome-tab-theme-color: "#000000"
```

### 更换头像

1. 将头像图片放入 `img/` 目录
2. 修改 `_config.yml`：
   ```yaml
   sidebar-avatar: /img/your-avatar.jpg
   ```

### 修改导航菜单

导航栏会自动显示所有页面。如需隐藏某个页面，在页面 Front Matter 中添加：

```yaml
hide-in-nav: true
```

---

## 🔧 常见问题

### Q: 本地预览时样式不加载？

A: 确保使用了正确的 baseurl：
```bash
bundle exec jekyll serve --baseurl "/blog"
```

### Q: GitHub Pages 部署失败？

A: 检查：
1. GitHub Actions 是否启用
2. `_config.yml` 中的 url 和 baseurl 是否正确
3. 查看 Actions 日志排查错误

### Q: 如何绑定自定义域名？

A: 
1. 在仓库根目录创建 `CNAME` 文件，写入你的域名
2. 在域名 DNS 设置中添加 CNAME 记录指向 `dalihaif.github.io`
3. 修改 `_config.yml` 中的 url 为你的域名

---

## 📞 需要帮助？

- Email: dlaihaif@qq.com
- GitHub: https://github.com/dalihaif/blog/issues

---

祝博客搭建顺利！🎉
