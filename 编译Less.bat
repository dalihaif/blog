@echo off
chcp 65001 >nul
echo ========================================
echo   Hux Blog Less 编译器
echo ========================================
echo.

REM 检查 node_modules 是否存在
if not exist "node_modules" (
    echo [步骤 1/3] 安装 npm 依赖...
    call npm install
    if errorlevel 1 (
        echo ❌ npm install 失败!
        pause
        exit /b 1
    )
    echo ✅ 依赖安装完成
    echo.
) else (
    echo [步骤 1/3] 依赖已存在,跳过安装
    echo.
)

REM 编译 Less
echo [步骤 2/3] 编译 Less 文件...
call npx grunt less
if errorlevel 1 (
    echo ❌ Less 编译失败!
    pause
    exit /b 1
)
echo ✅ Less 编译完成
echo.

REM 显示结果
echo [步骤 3/3] 编译结果检查...
if exist "css\hux-blog.css" (
    echo ✅ CSS 文件生成成功: css\hux-blog.css
) else (
    echo ❌ CSS 文件未找到!
    pause
    exit /b 1
)
echo.

echo ========================================
echo   ✨ 编译完成!可以启动本地预览了
echo ========================================
echo.
echo 提示: 运行 "bundle exec jekyll serve --baseurl "/blog"" 启动本地服务器
pause
