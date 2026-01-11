@echo off
echo ==========================================
echo 检查 GitHub Actions 构建状态
echo ==========================================

echo.
echo 请提供您的 GitHub 用户名：
set /p username=

if "%username%"=="" (
    echo 用户名不能为空
    pause
    exit /b 1
)

echo.
echo 正在打开 GitHub Actions 页面...
echo.

REM 打开 GitHub Actions 页面
start https://github.com/%username%/sms-group-app/actions

echo.
echo ==========================================
echo 如何查看构建进度
echo ==========================================
echo.
echo 1. 浏览器会自动打开 GitHub Actions 页面
echo 2. 你会看到 "Build Android APK" 工作流
echo 3. 点击工作流查看详细进度
echo 4. 等待状态变为 "✓" 绿色勾号
echo.
echo 构建时间：约 10-15 分钟
echo.

echo ==========================================
echo 构建状态说明
echo ==========================================
echo.
echo ⏱️  黄色圆点 - 正在构建中
echo ✓ 绿色勾号   - 构建成功
echo ✗ 红色叉号   - 构建失败
echo.

echo ==========================================
echo 下载构建结果
echo ==========================================
echo.
echo 构建完成后：
echo 1. 在 Actions 页面点击工作流
echo 2. 滚动到页面底部的 "Artifacts" 部分
echo 3. 点击下载 "app-release"
echo 4. 解压下载的 zip 文件
echo 5. 得到 app-release.apk 文件
echo.

pause