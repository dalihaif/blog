@echo off
chcp 65001 >nul
echo ========================================
echo   老墨的博客 - 本地预览启动脚本
echo ========================================
echo.
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

call bundle exec jekyll serve --baseurl "/blog"

pause
