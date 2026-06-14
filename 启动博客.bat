@echo off
chcp 65001 >nul
echo ========================================
echo   老墨的博客 (Hugo + PaperMod) - 本地预览
echo ========================================
echo.

set HUGO_PATH=C:\Users\Administrator\AppData\Local\Microsoft\WinGet\Packages\Hugo.Hugo.Extended_Microsoft.Winget.Source_8wekyb3d8bbwe\hugo.exe

if not exist "%HUGO_PATH%" (
    echo [错误] 未找到 Hugo，请重新安装
    echo 运行命令: winget install Hugo.Hugo.Extended
    pause
    exit /b 1
)

echo 正在启动 Hugo 服务器...
echo.
echo 博客地址: http://localhost:1313/blog/
echo.
echo 按 Ctrl+C 停止服务器
echo.

"%HUGO_PATH%" server --buildDrafts --baseURL "http://localhost:1313/blog/"

pause
