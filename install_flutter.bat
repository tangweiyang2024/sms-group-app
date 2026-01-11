@echo off
echo ==========================================
echo Flutter SDK 自动安装脚本
echo ==========================================

REM 设置安装目录
set FLUTTER_DIR=C:\flutter
set ZIP_FILE=%TEMP%\flutter_windows_3.16.5-stable.zip

echo.
echo 正在下载 Flutter SDK...
echo 下载链接: https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.16.5-stable.zip
echo.

REM 检查是否已下载
if exist "%ZIP_FILE%" (
    echo 发现已下载的文件，跳过下载步骤
) else (
    echo 请手动下载 Flutter SDK 并保存到: %ZIP_FILE%
    echo.
    echo 1. 访问: https://flutter.dev/docs/get-started/install/windows
    echo 2. 下载最新稳定版 (推荐 3.16.5 或更高版本)
    echo 3. 保存为: %ZIP_FILE%
    echo.
    pause

    if not exist "%ZIP_FILE%" (
        echo 错误：未找到下载文件
        pause
        exit /b 1
    )
)

echo.
echo 正在解压 Flutter SDK 到 %FLUTTER_DIR%...
if exist "%FLUTTER_DIR%" (
    echo 删除现有的 Flutter 安装...
    rmdir /s /q "%FLUTTER_DIR%"
)

powershell -Command "Expand-Archive -Path '%ZIP_FILE%' -DestinationPath 'C:\' -Force"

if not exist "%FLUTTER_DIR%\flutter.exe" (
    echo 错误：Flutter SDK 解压失败
    pause
    exit /b 1
)

echo.
echo 正在配置环境变量...
for /f "tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path 2^>nul') do set "sys_path=%%b"
for /f "tokens=2*" %%a in ('reg query "HKCU\Environment" /v Path 2^>nul') do set "user_path=%%b"

echo %FLUTTER_DIR%\bin | findstr /C:"%FLUTTER_DIR%\bin" >nul
if errorlevel 1 (
    echo 添加 Flutter 到用户环境变量...
    setx Path "%user_path%;%FLUTTER_DIR%\bin" >nul
    echo 环境变量已更新
) else (
    echo Flutter 已在环境变量中
)

echo.
echo 正在运行 Flutter 依赖检查...
"%FLUTTER_DIR%\bin\flutter.exe" doctor
echo.
echo ==========================================
echo Flutter SDK 安装完成！
echo ==========================================
echo.
echo 重要提示：
echo 1. 请重启命令提示符以使环境变量生效
echo 2. 运行 'flutter doctor' 检查环境配置
echo 3. 如果遇到问题，请访问：https://flutter.dev/docs/get-started/install/windows
echo.
pause