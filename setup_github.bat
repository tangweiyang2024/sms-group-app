@echo off
echo ==========================================
echo GitHub Actions 快速启动脚本
echo ==========================================

echo.
echo 当前 Git 仓库状态：
git status

echo.
echo ==========================================
echo 第一步：创建 GitHub 仓库
echo ==========================================
echo.
echo 1. 访问：https://github.com/new
echo 2. 创建新仓库：
echo    - Repository name: sms-group-app
echo    - Description: 智能短信分组 Flutter 应用
echo    - Visibility: Public 或 Private
echo    - 不要勾选 "Add README file"
echo 3. 点击 "Create repository"
echo.
pause

echo.
echo ==========================================
echo 第二步：连接 GitHub 仓库
echo ==========================================
echo.
echo 请输入你的 GitHub 用户名：
set /p username=

if "%username%"=="" (
    echo 用户名不能为空
    pause
    exit /b 1
)

echo.
echo 正在设置远程仓库...
git remote remove origin >nul 2>&1
git remote add origin https://github.com/%username%/sms-group-app.git

echo 远程仓库已设置：https://github.com/%username%/sms-group-app.git
echo.

echo ==========================================
echo 第三步：推送代码到 GitHub
echo ==========================================
echo.
echo 正在推送代码...
echo.

git branch -M main
git push -u origin main

if errorlevel 1 (
    echo.
    echo 推送失败！可能的原因：
    echo 1. 仓库不存在或用户名错误
    echo 2. 需要身份验证（GitHub Personal Access Token）
    echo.
    echo 解决方案：
    echo 1. 确认仓库已创建
     echo 2. 生成 Personal Access Token：
     echo    - GitHub Settings → Developer settings → Personal access tokens
     echo    - Generate new token, 勾选 repo 权限
     echo    - 使用 token 作为密码
     echo.
    pause
    exit /b 1
)

echo.
echo ==========================================
echo 代码推送成功！
echo ==========================================
echo.
echo 下一步：
echo 1. 访问：https://github.com/%username%/sms-group-app/actions
echo 2. 查看 "Build Android APK" 工作流
echo 3. 等待 10-15 分钟构建完成
echo 4. 下载生成的 APK 文件
echo.
pause