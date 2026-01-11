@echo off
echo ==========================================
echo 使用 Docker 构建 Android APK
echo ==========================================

echo.
echo 检查 Docker 是否安装...
docker --version >nul 2>&1
if errorlevel 1 (
    echo 错误: Docker 未安装
    echo 请先安装 Docker Desktop: https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)

echo Docker 已安装
echo.
echo 正在构建 Docker 镜像...
echo 这可能需要 10-20 分钟，请耐心等待...
echo.

docker build -t sms-group-app .

if errorlevel 1 (
    echo.
    echo Docker 镜像构建失败
    pause
    exit /b 1
)

echo.
echo ==========================================
echo 从 Docker 容器中提取 APK...
echo ==========================================

docker create --name sms-app sms-group-app
docker cp sms-app:/app/sms-group-app.apk D:\study\sms-group\sms-group-app.apk
docker rm sms-app

echo.
echo ==========================================
echo 构建完成！
echo ==========================================
echo.
echo APK 文件位置: D:\study\sms-group\sms-group-app.apk
echo.

if exist "D:\study\sms-group\sms-group-app.apk" (
    echo 文件大小:
    dir "D:\study\sms-group\sms-group-app.apk" | find "sms-group-app.apk"
    echo.
    echo 您现在可以：
    echo - 将 APK 传输到 Android 设备安装
    echo - 或使用 adb install D:\study\sms-group\sms-group-app.apk
    echo.
) else (
    echo 警告: APK 文件未找到
)

pause