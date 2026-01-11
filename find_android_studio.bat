@echo off
echo ==========================================
echo 查找可用的 Android Studio 版本
echo ==========================================

echo.
echo 正在检查清华镜像的 Android Studio 版本...
echo.

REM 检查几个常见的版本号
set VERSIONS=2022.3.1.22 2023.1.1.28 2024.1.1.10

for %%V in (%VERSIONS%) do (
    echo 检查版本: %%V
    powershell -Command "try { $response = Invoke-WebRequest -Uri 'https://mirrors.tuna.tsinghua.edu.cn/android/studio/install/%%V/android-studio-%%V-windows.exe' -Method Head -UseBasicParsing; if ($response.StatusCode -eq 200) { Write-Host '版本 %%V 可用' -ForegroundColor Green } } catch { Write-Host '版本 %%V 不可用' -ForegroundColor Red }"
)

echo.
echo ==========================================
echo 推荐使用官方源或其他镜像源
echo ==========================================
echo.
echo 备用下载方案：
echo.
echo 1. 官方下载页面:
echo    https://developer.android.com/studio#downloads
echo.
echo 2. 中科大镜像:
echo    https://mirrors.ustc.edu.cn/android-studio/
echo.
echo 3. 华为云镜像:
echo    https://mirrors.huaweicloud.com/android-studio/
echo.
echo 4. 腾讯云镜像:
echo    https://mirrors.cloud.tencent.com/android-studio/
echo.
pause