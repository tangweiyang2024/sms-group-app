@echo off
echo 正在解压 Flutter SDK...
echo 源文件: D:\study\sms-group\flutter_windows_3.16.5-stable.zip
echo 目标目录: C:\
echo.

REM 删除现有安装
if exist "C:\flutter" (
    echo 删除现有 Flutter 安装...
    rmdir /s /q "C:\flutter"
)

REM 使用 PowerShell 解压
echo 开始解压...
powershell -Command "Expand-Archive -Path 'D:\study\sms-group\flutter_windows_3.16.5-stable.zip' -DestinationPath 'C:\' -Force"

if exist "C:\flutter\bin\flutter.exe" (
    echo.
    echo ==========================================
    echo Flutter SDK 解压成功！
    echo ==========================================
    echo 安装位置: C:\flutter
    echo.
    echo 下一步：配置环境变量
    echo.
) else (
    echo.
    echo 解压失败，请检查压缩包是否完整
    echo.
    pause
    exit /b 1
)

pause