# Android 开发环境完整安装指南

由于网络环境的限制，自动安装遇到了一些困难。请按照以下步骤手动完成Android SDK的安装：

## 🎯 推荐方案

### 方案一：使用 Android Studio（最简单）

#### 步骤：
1. **下载 Android Studio**
   - 访问：https://developer.android.com/studio
   - 下载 Windows 版本（约 1GB）
   - 下载地址：https://redirector.gvt1.com/edgedl/android/studio/install/2022.3.1.22/android-studio-2022.3.1.22-windows.exe

2. **安装 Android Studio**
   - 运行安装程序
   - 使用默认安装路径
   - 确保勾选 "Android Virtual Device"
   - 等待安装完成（约 10-20 分钟）

3. **首次启动配置**
   - 启动 Android Studio
   - 选择 "Standard" 安装类型
   - 等待 SDK 组件下载完成
   - 完成初始设置向导

4. **构建应用**
   ```cmd
   cd D:\study\sms-group
   build_release.bat
   ```

### 方案二：仅安装 Android SDK（轻量级）

#### 步骤：
1. **下载命令行工具**
   - 访问：https://developer.android.com/studio#command-tools
   - 下载 "Command line tools only"
   - 选择 Windows 版本

2. **手动安装**
   ```cmd
   # 创建目录
   mkdir C:\Android\sdk\cmdline-tools\latest

   # 解压下载的文件到上述目录

   # 配置环境变量
   setx ANDROID_HOME C:\Android\sdk
   setx ANDROID_SDK_ROOT C:\Android\sdk
   setx Path "%Path%;C:\Android\sdk\cmdline-tools\latest\bin;C:\Android\sdk\platform-tools"
   ```

3. **安装SDK组件**
   ```cmd
   # 重启命令提示符后运行
   sdkmanager --licenses
   sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0"
   ```

## 🚀 当前状态总结

✅ **已完成**：
- Flutter SDK 3.16.5 安装
- 项目依赖安装完成
- 国内镜像配置完成
- 构建脚本准备完成

⚠️ **待完成**：
- Android SDK 安装

## 📱 安装完成后的构建命令

```cmd
# 1. 重启命令提示符
# 2. 进入项目目录
cd D:\study\sms-group

# 3. 构建发布版本
flutter build apk --release

# 4. 查找生成的APK
# 输出位置：build\app\outputs\flutter-apk\app-release.apk
```

## 🔧 故障排除

### 问题 1：网络连接超时
**解决方案**：使用国内镜像或VPN服务

### 问题 2：下载速度慢
**解决方案**：
- 使用下载工具（如 IDM）
- 设置代理加速
- 从国内镜像站下载

### 问题 3：环境变量不生效
**解决方案**：
1. 完全关闭命令提示符
2. 重新打开命令提示符
3. 验证：`echo %ANDROID_HOME%`

## 🌐 备用下载源

如果官方下载困难，可以尝试：

### 中科大镜像
https://mirrors.ustc.edu.cn/android-studio/

### 华为云镜像
https://mirrors.huaweicloud.com/android-studio/

### 腾讯云镜像
https://mirrors.cloud.tencent.com/android-studio/

## 📞 技术支持

- Flutter官方文档：https://flutter.dev/docs/get-started/install/windows
- Android官方文档：https://developer.android.com/studio/install
- 清华开源镜像：https://mirrors.tuna.tsinghua.edu.cn/

---

**建议**：优先选择方案一（Android Studio），安装过程最简单，后续维护也最方便。