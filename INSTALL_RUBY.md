# 🛠️ Windows 本地 Jekyll 环境安装指南

## ️ 当前问题
本地预览无法运行，因为 **Ruby 和 Bundler 未安装**或不在系统 PATH 中。

---

## ✅ 解决方案：安装 Ruby 环境

### 方法一：使用 RubyInstaller（推荐）

#### 步骤1：下载 RubyInstaller

访问官网：https://rubyinstaller.org/

**推荐版本：**
- Ruby+Devkit 3.2.x (64-bit)
- 或者 Ruby+Devkit 3.1.x (64-bit)

**直接下载链接：**
```
https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.2.2-1/rubyinstaller-devkit-3.2.2-1-x64.exe
```

#### 步骤2：安装 Ruby

1. 双击下载的 `.exe` 文件
2. 选择语言（建议 English）
3. 同意许可协议
4. **重要：** 勾选以下选项：
   - ✅ **MSYS2 development toolchain** （必须勾选！）
   - ✅ **Add Ruby executables to your PATH**
5. 点击 Install
6. 等待安装完成（会自动下载 MSYS2）
7. 安装完成后，会弹出一个终端窗口，按 **Enter** 键继续
8. 等待 MSYS2 组件安装完成

#### 步骤3：验证安装

打开新的命令提示符（CMD）或 PowerShell，输入：

```bash
ruby --version
```

应该看到类似输出：
```
ruby 3.2.2p53 (2023-03-30 revision e51014f9c0) [x64-mingw-ucrt]
```

再输入：
```bash
gem --version
```

应该看到版本号，如 `3.4.10`

---

### 方法二：使用 Chocolatey（如果已安装）

如果你已经安装了 Chocolatey 包管理器：

```powershell
choco install ruby
```

然后重启终端。

---

## 🔧 安装 Jekyll 和依赖

### 步骤1：进入博客目录

```bash
cd g:\web\blog-new
```

### 步骤2：安装 Bundler

```bash
gem install bundler
```

### 步骤3：安装项目依赖

```bash
bundle install
```

这可能需要几分钟时间，会安装 Jekyll 和所有需要的插件。

**如果遇到问题：**

#### 问题1：SSL 证书错误
```bash
gem sources --remove https://rubygems.org/
gem sources -a http://rubygems.org/
bundle install
```

#### 问题2：网络超时
```bash
bundle config set timeout 120
bundle install
```

#### 问题3：权限错误
以**管理员身份**运行命令提示符，然后重新执行 `bundle install`

---

## 🚀 启动本地服务器

### 方法一：使用启动脚本（推荐）

双击：`g:\web\blog-new\启动博客.bat`

脚本会自动：
1. 检查 Ruby 环境
2. 安装依赖
3. 启动 Jekyll 服务器

然后在浏览器访问：
```
http://localhost:4000/blog/
```

### 方法二：手动启动

```bash
cd g:\web\blog-new
bundle exec jekyll serve --baseurl "/blog"
```

然后在浏览器访问：
```
http://localhost:4000/blog/
```

---

##  常见问题排查

### 问题1：找不到 Ruby 命令

**原因：** Ruby 没有添加到系统 PATH

**解决：**
1. 右键"此电脑" → 属性 → 高级系统设置 → 环境变量
2. 在"系统变量"中找到 `Path`，点击编辑
3. 添加 Ruby 的安装路径，例如：
   ```
   C:\Ruby32-x64\bin
   ```
4. 确定保存
5. **重启终端**（重要！）
6. 再次尝试 `ruby --version`

### 问题2：bundle install 失败

**可能原因：**
- 网络连接问题
- SSL 证书问题
- 权限不足

**解决方法：**
1. 尝试使用国内镜像：
   ```bash
   gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
   bundle install
   ```

2. 以管理员身份运行终端

3. 检查 Gemfile 是否存在：
   ```bash
   cd g:\web\blog-new
   dir Gemfile
   ```

### 问题3：Jekyll serve 启动后页面空白

**原因：** CSS/JS 资源路径问题

**解决：**
1. 确认 `_config.yml` 中的配置：
   ```yaml
   baseurl: "/blog"
   ```

2. 清除浏览器缓存（Ctrl + Shift + R）

3. 检查浏览器控制台（F12）是否有 404 错误

### 问题4：端口 4000 已被占用

**解决：**
使用其他端口：
```bash
bundle exec jekyll serve --baseurl "/blog" --port 4001
```

然后访问：`http://localhost:4001/blog/`

---

## 📋 完整检查清单

安装完成后，请确认：

- [ ] `ruby --version` 能显示版本号
- [ ] `gem --version` 能显示版本号
- [ ] `bundle --version` 能显示版本号
- [ ] `bundle install` 成功执行
- [ ] `bundle exec jekyll serve --baseurl "/blog"` 能启动服务器
- [ ] 浏览器访问 `http://localhost:4000/blog/` 能看到完整的样式

---

## 🎯 快速开始流程

1. **安装 Ruby**（使用方法一的 RubyInstaller）
2. **重启终端**
3. **进入项目目录**：`cd g:\web\blog-new`
4. **安装依赖**：`bundle install`
5. **启动服务器**：双击 `启动博客.bat`
6. **访问博客**：http://localhost:4000/blog/

---

## 💡 小贴士

### 更新依赖
如果以后需要更新 Jekyll 或插件：
```bash
bundle update
```

### 查看已安装的 Gems
```bash
gem list
```

### 清理缓存
```bash
jekyll clean
```

### 构建静态站点
```bash
bundle exec jekyll build --baseurl "/blog"
```

生成的文件会在 `_site` 目录中。

---

## 📞 需要帮助？

如果按照以上步骤仍然无法解决：

1. **截图保存错误信息**
2. **记录完整的错误日志**
3. **提供以下信息：**
   - Windows 版本
   - Ruby 版本（如果能获取）
   - 执行的命令
   - 错误信息

我会继续帮你解决问题！

---

*最后更新：2026年6月15日*
