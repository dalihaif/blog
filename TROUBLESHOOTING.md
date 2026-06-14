# 🔧 GitHub Pages 故障排查指南

## ⚠️ 当前问题
前端页面没有加载 CSS 样式，显示为原始 HTML。

---

## ✅ 快速检查清单

### 1. 确认访问地址正确

**你应该访问：**
```
https://dalihaif.github.io/blog/
```

**不是这些：**
- ❌ http://localhost:4000/blog/ （这是本地预览）
- ❌ https://dalihaif.github.io/ （缺少 /blog/）
- ❌ https://dalihaif.github.io/blog （缺少末尾斜杠）

### 2. 确认 GitHub Pages 已启用

访问：https://github.com/dalihaif/blog/settings/pages

应该看到：
- ✅ Source: Deploy from a branch
- ✅ Branch: master / (root)
- ✅ 绿色提示："Your site is published at https://dalihaif.github.io/blog/"

如果没看到，请手动配置。

### 3. 检查构建状态

访问：https://github.com/dalihaif/blog/deployments/github-pages

查看最近的部署记录：
- 🟢 绿色 = 成功
- 🟡 黄色 = 进行中（等待）
- 🔴 红色 = 失败（查看错误日志）

### 4. 清除浏览器缓存

**Windows:** Ctrl + Shift + R  
**Mac:** Cmd + Shift + R  
**或者：** Ctrl + F5

### 5. 使用无痕模式测试

打开浏览器的无痕/隐私模式：
- Chrome: Ctrl + Shift + N
- Edge: Ctrl + Shift + N
- Firefox: Ctrl + Shift + P

然后访问：https://dalihaif.github.io/blog/

---

## 🔍 深入排查

### 检查1：CSS 文件是否存在

在浏览器中按 F12 打开开发者工具，切换到 **Network** 标签，刷新页面，查看：

1. 是否有 `.css` 文件加载？
2. 是否有 404 错误？
3. CSS 文件的路径是否正确？

**期望看到的路径：**
```
https://dalihaif.github.io/blog/css/main.css
https://dalihaif.github.io/blog/css/hux-blog.min.css
```

### 检查2：查看控制台错误

在开发者工具的 **Console** 标签中，查看是否有错误信息：
- Mixed Content 警告（HTTP/HTTPS 混合）
- CORS 错误
- 资源加载失败

### 检查3：查看页面源代码

在页面上右键 → "查看页面源代码"

查找 `<link>` 标签，确认 CSS 路径：
```html
<link rel="stylesheet" href="/blog/css/main.css">
```

路径应该以 `/blog/` 开头。

---

## 🛠️ 常见问题解决

### 问题1：CSS 文件 404 错误

**原因：** baseurl 配置不正确

**解决：**
1. 打开 `_config.yml`
2. 确认：
   ```yaml
   url: "https://dalihaif.github.io"
   baseurl: "/blog"
   ```
3. 提交并推送：
   ```bash
   git add _config.yml
   git commit -m "修复baseurl配置"
   git push origin master
   ```

### 问题2：Mixed Content 警告

**原因：** HTTPS 页面加载了 HTTP 资源

**解决：**
1. 检查 `_config.yml` 中的 `url` 是否使用 `https://`
2. 检查所有图片、外部资源是否使用 `https://`

### 问题3：样式部分加载

**原因：** 某些 CSS 文件路径错误

**解决：**
1. 打开开发者工具 Network 标签
2. 找出哪些 CSS 文件 404
3. 检查对应的 `<link>` 标签路径
4. 修正路径后重新推送

---

## 📞 获取帮助

### 方法1：查看 GitHub Actions 日志

1. 访问：https://github.com/dalihaif/blog/actions
2. 查看最近的构建记录
3. 点击失败的构建查看详细错误

### 方法2：本地测试

先在本地确认一切正常：

```bash
cd g:\web\blog-new
双击 "启动博客.bat"
```

访问：http://localhost:4000/blog/

如果本地正常，说明是 GitHub Pages 的问题。

### 方法3：联系支持

如果以上方法都无法解决：
1. 截图保存错误信息
2. 记录浏览器控制台的所有错误
3. 提供你的访问地址

---

## ️ 时间线参考

| 操作 | 预计时间 |
|-----|---------|
| 首次部署 | 5-10 分钟 |
| 后续更新 | 1-3 分钟 |
| DNS 传播（自定义域名） | 24-48 小时 |

---

## 🎯 最终验证

部署成功后，你应该看到：

1. ✅ 完整的样式和布局
2. ✅ 响应式设计（移动端适配）
3. ✅ 所有图片正常显示
4. ✅ 导航菜单正常工作
5. ✅ 文章列表正常展示

---

*最后更新：2026年6月15日*
