# GitHub Actions 构建指南

## 🚀 使用 GitHub Actions 免费构建 Android APK

这是最简单且免费的方案，无需本地安装 Android SDK！

### 步骤：

#### 1. 创建 GitHub 仓库
1. 访问 https://github.com/new
2. 创建新仓库（例如：sms-group-app）
3. 不要初始化 README（我们已经有代码了）

#### 2. 推送代码到 GitHub
```cmd
cd D:\study\sms-group

# 初始化 Git 仓库
git init

# 添加所有文件
git add .

# 提交代码
git commit -m "Initial commit: SMS Group App"

# 添加远程仓库
git remote add origin https://github.com/你的用户名/sms-group-app.git

# 推送代码
git push -u origin main
```

#### 3. 自动构建开始
推送代码后，GitHub Actions 会自动：
1. 检测到 `.github/workflows/build-android.yml`
2. 开始构建 Android APK
3. 大约 10-15 分钟完成

#### 4. 下载构建结果
1. 访问：https://github.com/你的用户名/sms-group-app/actions
2. 点击最新的 "Build Android APK" 工作流
3. 在 "Artifacts" 部分下载：
   - `app-release` (APK 文件)
   - `app-release-bundle` (AAB 文件，用于 Google Play)

### 🎯 优势

- ✅ **完全免费**：GitHub Actions 提供免费额度
- ✅ **无需本地环境**：不需要安装 Android SDK
- ✅ **自动构建**：每次推送代码都会自动构建
- ✅ **云端构建**：利用 GitHub 的强大服务器
- ✅ **持续集成**：代码提交即自动构建

### 📱 获取 APK

构建完成后：
1. 在 Actions 页面找到构建记录
2. 下载 `app-release.zip`
3. 解压后得到 `app-release.apk`
4. 可以直接安装到 Android 设备

### 🔄 手动触发构建

如果你不想推送代码，也可以手动触发：
1. 访问仓库的 Actions 页面
2. 选择 "Build Android APK" 工作流
3. 点击 "Run workflow" 按钮
4. 选择分支并点击运行

---

这是目前最简单和快速的方案！