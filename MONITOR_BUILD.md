# 📋 GitHub Actions 构建监控指南

## 🚀 快速检查构建状态

### 方法一：直接访问（推荐）

1. **访问 GitHub Actions 页面**
   ```
   https://github.com/你的用户名/sms-group-app/actions
   ```

2. **查看工作流状态**
   - 你会看到 "Build Android APK" 工作流
   - 状态图标：
     - `⏱️` 黄色圆点 - 正在构建
     - `✓` 绿色勾号 - 构建成功
     - `✗` 红色叉号 - 构建失败

3. **点击查看详情**
   - 点击工作流名称进入详细页面
   - 可以看到每个步骤的执行情况

## ⏱️ 构建时间预估

- **首次构建**: 15-20 分钟
- **后续构建**: 10-15 分钟（使用缓存）

## 📥 下载构建的 APK

### 构建成功后：

1. **在 Actions 页面**
   - 点击最新的 "Build Android APK" 工作流
   - 滚动到页面底部

2. **在 Artifacts 部分**
   - 你会看到两个文件：
     - `app-release` - APK 文件（约 20MB）
     - `app-release-bundle` - AAB 文件（约 15MB）

3. **下载和安装**
   - 点击 `app-release` 下载 zip 文件
   - 解压 zip 文件
   - 得到 `app-release.apk`

## 📱 安装 APK 到设备

### 方法一：直接安装
1. 将 APK 文件传输到 Android 手机
2. 在手机上启用"未知来源应用安装"
3. 点击 APK 文件进行安装

### 方法二：使用 ADB
```cmd
adb devices
adb install app-release.apk
```

## 🔍 构建过程说明

### GitHub Actions 会自动执行以下步骤：

1. **环境准备** (1-2分钟)
   - 启动 Ubuntu 虚拟机
   - 安装基础工具

2. **安装 Flutter** (2-3分钟)
   - 下载 Flutter 3.16.5
   - 配置 Flutter 环境
   - 预热 Flutter 缓存

3. **安装依赖** (2-3分钟)
   - 运行 `flutter pub get`
   - 下载所有项目依赖

4. **构建 APK** (5-8分钟)
   - 编译 Dart 代码
   - 生成 Android APK
   - 优化和签名

5. **构建 AAB** (2-4分钟)
   - 生成 Google Play 格式

6. **上传结果** (1分钟)
   - 上传 APK 和 AAB
   - 保留30天

## 🆘 故障排除

### 如果构建失败：

1. **查看错误日志**
   - 在 Actions 页面点击失败的工作流
   - 展开失败的步骤查看详细错误

2. **常见问题**
   - **依赖冲突**: 切换到项目目录，运行 `flutter pub get`
   - **版本兼容**: 检查 `pubspec.yaml` 中的依赖版本
   - **内存不足**: GitHub 可能会自动重试

3. **重新构建**
   ```cmd
   # 修改任意文件触发重新构建
   echo "# test" >> README.md
   git add .
   git commit -m "Trigger rebuild"
   git push
   ```

### 如果构建长时间无响应：

1. **检查是否真的在运行**
   - 访问 Actions 页面确认状态
   - 查看是否有排队的工作流

2. **手动触发构建**
   - 在 Actions 页面选择工作流
   - 点击 "Run workflow" 按钮
   - 选择分支并运行

## 📊 构建优化建议

### 加速后续构建：

1. **启用缓存**（已自动配置）
   - Flutter 下载缓存
   - 依赖包缓存

2. **减少构建时间**
   - 避免不必要的依赖更新
   - 保持代码简洁

## 🎯 成功标志

### 构建成功的表现：

1. **状态图标**: ✓ 绿色勾号
2. **Artifacts 可用**: 底部出现下载区域
3. **文件完整**: APK 文件约 20MB

### 验证 APK：

1. **文件大小检查**
   - APK 应该在 15-25MB 之间

2. **安装测试**
   - 在 Android 设备上安装
   - 启动应用测试功能

---

**现在就去 GitHub Actions 页面查看构建进度吧！**