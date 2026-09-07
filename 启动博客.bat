@echo off
chcp 65001 >nul
echo ========================================
echo   老墨的博客 - 本地预览启动脚本
echo ========================================
echo.

rem 确保 Ruby 在 PATH 中
set PATH=C:\Ruby32-x64\bin;%PATH%

echo 正在清理旧构建缓存...
if exist _site rd /s /q _site

echo 正在检查 Ruby 环境...
ruby --version
if errorlevel 1 (
    echo.
    echo [错误] 未检测到 Ruby，请先安装 Ruby
    echo 下载地址: https://rubyinstaller.org/
    pause
    exit /b 1
)

echo.
echo 正在启用 MSYS2 开发工具...
call ridk enable
if errorlevel 1 (
    echo [警告] ridk enable 失败，部分 gem 编译可能受影响
)

echo.
echo 正在安装依赖...
call bundle install
if errorlevel 1 (
    echo.
    echo [错误] 依赖安装失败
    pause
    exit /b 1
)

echo.
echo ========================================
echo   启动本地服务器...
echo ========================================
echo.
echo 博客地址: http://localhost:4000/blog/
echo.
echo 按 Ctrl+C 停止服务器
echo.

ruby -rbundler/setup -e "load Gem.bin_path('jekyll', 'jekyll')" -- serve --baseurl "/blog"

pause
