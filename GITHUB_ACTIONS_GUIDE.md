# 🚀 GitHub Actions 构建详细指南

## ✅ 已完成的工作

1. ✅ Git 仓库已初始化
2. ✅ 所有文件已提交（69个文件，5418行代码）
3. ✅ GitHub Actions 工作流配置已准备
4. ✅ Flutter 项目结构完整

## 📋 接下来的步骤

### 第一步：创建 GitHub 账号（如果没有）

1. 访问：https://github.com/signup
2. 注册免费账号
3. 验证邮箱

### 第二步：创建 GitHub 仓库

1. 访问：https://github.com/new
2. 填写仓库信息：
   - **Repository name**: `sms-group-app`
   - **Description**: `智能短信分组 Flutter 应用`
   - **Visibility**: 选择 `Public`（公开）或 `Private`（私有）
   - **不要**勾选 "Add a README file"
   - **不要**勾选 "Add .gitignore"
3. 点击 "Create repository"

### 第三步：推送代码到 GitHub

在命令提示符中运行以下命令（替换为你的GitHub用户名）：

```cmd
cd D:\study\sms-group

# 添加远程仓库（替换 YOUR_USERNAME 为你的GitHub用户名）
git remote add origin https://github.com/YOUR_USERNAME/sms-group-app.git

# 推送代码到 GitHub
git push -u origin master
```

如果遇到认证问题，使用 HTTPS：
```cmd
git remote set-url origin https://YOUR_USERNAME:YOUR_TOKEN@github.com/YOUR_USERNAME/sms-group-app.git
```

### 第四步：触发自动构建

推送代码后，GitHub Actions 会自动开始构建：

1. 访问：https://github.com/YOUR_USERNAME/sms-group-app/actions
2. 你会看到 "Build Android APK" 工作流正在运行
3. 等待 10-15 分钟让构建完成

### 第五步：下载构建的 APK

构建完成后：

1. 在 Actions 页面，点击最新的构建记录
2. 滚动到底部的 "Artifacts" 部分
3. 你会看到两个文件：
   - **app-release** - APK 文件（推荐下载）
   - **app-release-bundle** - AAB 文件（用于 Google Play）
4. 点击下载 `app-release.zip`
5. 解压 zip 文件
6. 得到 `app-release.apk`

## 🎯 关键命令汇总

### 创建和推送仓库：
```cmd
# 设置远程地址（替换用户名）
git remote add origin https://github.com/YOUR_USERNAME/sms-group-app.git

# 推送代码
git push -u origin master
```

### 如果推送失败：
```cmd
# 强制推送到 main 分支
git branch -M main
git push -u origin main
```

## 📱 安装 APK 到设备

下载 APK 后：

### 方法一：直接安装
1. 将 APK 文件传输到 Android 手机
2. 在手机上启用"未知来源应用安装"
3. 点击 APK 文件进行安装

### 方法二：使用 ADB
```cmd
# 确保 USB 调试已开启
adb devices
adb install app-release.apk
```

## 🔧 GitHub Actions 配置说明

工作流文件位置：`.github/workflows/build-android.yml`

功能：
- 自动检测代码推送
- 安装 Flutter 3.16.5
- 安装项目依赖
- 构建发布版 APK
- 构建发布版 AAB（Google Play）
- 自动上传构建结果

触发条件：
- 推送代码到 main/master 分支
- 创建 Pull Request
- 手动触发（workflow_dispatch）

## ⚡ 加速构建技巧

如果想要加快构建速度：

1. **手动触发构建**：
   - 访问 Actions 页面
   - 选择 "Build Android APK"
   - 点击 "Run workflow"

2. **修改构建配置**：
   - 编辑 `.github/workflows/build-android.yml`
   - 调整缓存和并发设置

## 🆘 常见问题

### Q: 推送代码时提示认证失败
**A**: 需要创建 Personal Access Token：
1. GitHub 设置 → Developer settings → Personal access tokens
2. 生成新 token，勾选 `repo` 权限
3. 使用 token 替代密码进行认证

### Q: 构建失败怎么办？
**A**: 检查 Actions 页面的错误日志，常见问题：
- 依赖冲突：运行 `flutter pub upgrade`
- 构建工具版本：修改 build.gradle 中的版本号

### Q: 如何更新应用？
**A**: 修改代码后：
```cmd
git add .
git commit -m "Update app"
git push
```
GitHub Actions 会自动重新构建。

## 📊 构建时间参考

- 首次构建：15-20 分钟
- 后续构建：5-10 分钟（使用缓存）
- 仅 APK 构建：8-12 分钟
- APK + AAB 构建：15-20 分钟

---

**下一步：现在就去 GitHub 创建仓库，然后推送代码！**