# Flutter SDK 快速安装指南 (Windows)

## 方法一：自动化安装（推荐）

### 步骤 1：下载 Flutter SDK
1. **直接下载链接**：
   - **稳定版 3.16.5**：https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.16.5-stable.zip
   - **备用链接**：https://flutter.dev/docs/get-started/install/windows

2. **手动下载步骤**：
   - 打开浏览器，访问上述链接
   - 下载大约 1GB 的压缩包
   - 保存到临时文件夹（如 `C:\Users\你的用户名\Downloads\`）

### 步骤 2：运行安装脚本
1. 双击运行 `install_flutter.bat`
2. 脚本会自动：
   - 解压 Flutter SDK 到 `C:\flutter`
   - 配置环境变量
   - 运行环境检查

### 步骤 3：验证安装
```cmd
# 重启命令提示符，然后运行：
flutter --version
flutter doctor
```

---

## 方法二：手动安装

### 步骤 1：下载并解压
1. 下载 Flutter SDK 压缩包
2. 解压到 `C:\flutter`（或其他路径，但路径中不要有空格）

### 步骤 2：配置环境变量
1. 按 `Win + X`，选择"系统"
2. 点击"高级系统设置"
3. 点击"环境变量"
4. 在"用户变量"中找到 `Path`，点击"编辑"
5. 添加新条目：`C:\flutter\bin`
6. 点击"确定"保存

### 步骤 3：验证安装
```cmd
# 重启命令提示符
flutter --version
flutter doctor
```

---

## 常见问题解决

### Q1: 下载速度慢
**解决方案**：使用国内镜像
```cmd
# 设置环境变量
setx PUB_HOSTED_URL https://pub.flutter-io.cn
setx FLUTTER_STORAGE_BASE_URL https://storage.flutter-io.cn
```

### Q2: 网络连接失败
**替代方案**：
- 使用第三方下载工具（如 IDM、Thunder）
- 从国内镜像站下载：
  - 清华大学镜像：https://mirrors.tuna.tsinghua.edu.cn/flutter/
  - 腾讯云镜像：https://mirrors.cloud.tencent.com/flutter/

### Q3: 环境变量不生效
**解决方案**：
1. 完全关闭命令提示符
2. 重新打开命令提示符
3. 检查环境变量：`echo %Path%`

---

## 安装后配置

### 1. 接受 Android 许可
```cmd
flutter doctor --android-licenses
```

### 2. 安装 Android Studio
1. 下载：https://developer.android.com/studio
2. 安装时选择 "Android Virtual Device"
3. 启动 Android Studio，完成初始设置

### 3. 验证环境
```cmd
flutter doctor -v
```

确保所有必要的工具都显示 ✓ 标记。

---

## 快速开始

完成安装后，在项目目录中运行：

```cmd
cd D:\study\sms-group
flutter pub get
flutter run
```

---

## 联系支持

如果遇到问题：
1. 查看官方文档：https://flutter.dev/docs/get-started/install/windows
2. 访问 Flutter 中文网：https://flutter.cn/
3. 查看项目中的 `ANDROID_BUILD_GUIDE.md`