@echo off
echo ==========================================
echo Flutter SDK 清华镜像自动安装脚本
echo ==========================================

set FLUTTER_VERSION=3.16.5
set FLUTTER_DIR=C:\flutter
set ZIP_FILE=%TEMP%\flutter_windows_%FLUTTER_VERSION%-stable.zip
set DOWNLOAD_URL=https://mirrors.tuna.tsinghua.edu.cn/flutter/flutter_infra_release/releases/stable/windows/flutter_windows_%FLUTTER_VERSION%-stable.zip

echo.
echo 正在从清华镜像下载 Flutter SDK %FLUTTER_VERSION%...
echo 下载地址: %DOWNLOAD_URL%
echo.

REM 检查是否已下载
if exist "%ZIP_FILE%" (
    echo 发现已下载的文件，跳过下载步骤
) else (
    echo 使用 PowerShell 下载中...
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%ZIP_FILE%' -UseBasicParsing}"

    if errorlevel 1 (
        echo.
        echo 下载失败，请手动下载：
        echo 1. 访问: %DOWNLOAD_URL%
        echo 2. 或访问: https://mirrors.tuna.tsinghua.edu.cn/flutter/flutter_infra_release/releases/stable/windows/
        echo 3. 下载文件保存为: %ZIP_FILE%
        echo.
        pause
        exit /b 1
    )

    if not exist "%ZIP_FILE%" (
        echo 错误：下载失败，文件不存在
        pause
        exit /b 1
    )

    echo 下载完成！
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
echo 正在配置 Flutter 国内镜像环境变量...
setx PUB_HOSTED_URL "https://pub.flutter-io.cn" >nul
setx FLUTTER_STORAGE_BASE_URL "https://storage.flutter-io.cn" >nul
echo 国内镜像配置完成

echo.
echo 正在配置 Path 环境变量...
for /f "skip=2 tokens=2*" %%a in ('reg query "HKCU\Environment" /v Path 2^>nul') do set "current_path=%%b"

echo %current_path% | findstr /C:"%FLUTTER_DIR%\bin" >nul
if errorlevel 1 (
    echo 添加 Flutter 到用户环境变量...
    setx Path "%current_path%;%FLUTTER_DIR%\bin" >nul
    echo 环境变量已更新，请重启命令提示符以生效
) else (
    echo Flutter 已在环境变量中
)

REM 设置临时环境变量，使得后续命令能立即使用
set PATH=%FLUTTER_DIR%\bin;%PATH%

echo.
echo 正在验证 Flutter 安装...
"%FLUTTER_DIR%\bin\flutter.exe" --version

if errorlevel 1 (
    echo Flutter 验证失败
    pause
    exit /b 1
)

echo.
echo ==========================================
echo Flutter SDK 安装完成！
echo ==========================================
echo.
echo 重要提示：
echo 1. 请关闭当前命令提示符窗口
echo 2. 重新打开命令提示符
echo 3. 运行 'flutter doctor' 检查环境配置
echo 4. 运行 'build_android.bat' 开始构建应用
echo.
echo 国内镜像已配置，下载依赖会更快！
echo.
pause