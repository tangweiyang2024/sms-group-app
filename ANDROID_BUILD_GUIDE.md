# Windows环境下Flutter Android打包指南

## 第一步：安装Flutter SDK

### 1. 下载Flutter SDK
1. 访问Flutter官网：https://flutter.dev/docs/get-started/install/windows
2. 下载最新稳定版Flutter SDK（推荐3.16.0或更高版本）
3. 解压到您希望的目录，例如：`C:\flutter`

### 2. 配置环境变量
1. 右键点击"此电脑" → "属性" → "高级系统设置" → "环境变量"
2. 在"系统变量"中找到`Path`，点击"编辑"
3. 添加Flutter的bin目录路径：`C:\flutter\bin`
4. 重启命令提示符使环境变量生效

### 3. 验证安装
打开新的命令提示符，运行：
```cmd
flutter --version
flutter doctor
```

## 第二步：安装Android开发工具

### 1. 安装JDK
1. 下载并安装JDK 11或更高版本
2. 推荐版本：JDK 17 LTS
3. 下载地址：https://adoptium.net/

### 2. 安装Android Studio
1. 下载Android Studio：https://developer.android.com/studio
2. 安装时勾选"Android Virtual Device"选项
3. 启动Android Studio，完成初始设置向导

### 3. 配置Android SDK
在Android Studio中：
1. Settings → Appearance & Behavior → System Settings → Android SDK
2. 确保安装了：
   - Android SDK Platform-Tools
   - Android SDK Build-Tools
   - Android 13.0 (API 33)或更高版本

### 4. 配置环境变量
添加以下环境变量：
- `ANDROID_HOME` = `C:\Users\你的用户名\AppData\Local\Android\Sdk`
- 在Path中添加：`%ANDROID_HOME%\platform-tools`
- 在Path中添加：`%ANDROID_HOME%\tools`

## 第三步：安装依赖

### 1. 安装项目依赖
在项目目录中运行：
```cmd
cd D:\study\sms-group
flutter pub get
```

### 2. 验证环境
```cmd
flutter doctor -v
```
确保所有项都显示✓标记。

## 第四步：配置应用签名

### 1. 创建签名密钥
```cmd
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

### 2. 创建key.properties文件
在`android/`目录下创建`key.properties`文件：
```properties
storePassword=你的密钥库密码
keyPassword=你的密钥密码
keyAlias=upload
storeFile=../../upload-keystore.jks
```

## 第五步：构建Android应用

### 选项1：构建调试版本（快速测试）
```cmd
flutter build apk --debug
```
输出位置：`build/app/outputs/flutter-apk/app-debug.apk`

### 选项2：构建发布版本（用于分发）
```cmd
flutter build apk --release
```
输出位置：`build/app/outputs/flutter-apk/app-release.apk`

### 选项3：构建App Bundle（推荐用于Google Play）
```cmd
flutter build appbundle --release
```
输出位置：`build/app/outputs/bundle/release/app-release.aab`

## 第六步：安装测试

### 在真实设备上安装
```cmd
flutter install
```

### 或者手动传输APK
1. 将APK文件传输到Android手机
2. 在手机上启用"未知来源应用安装"
3. 点击APK文件进行安装

## 常见问题解决

### 1. Flutter找不到SDK
确保`ANDROID_HOME`环境变量正确设置。

### 2. Gradle下载缓慢
在`android/build.gradle`中添加国内镜像源：
```gradle
repositories {
    maven { url 'https://maven.aliyun.com/repository/google' }
    maven { url 'https://maven.aliyun.com/repository/jcenter' }
    maven { url 'https://maven.aliyun.com/repository/public' }
}
```

### 3. 构建失败
```cmd
flutter clean
flutter pub get
flutter build apk --release
```

## 快速开始命令汇总

```cmd
# 1. 检查环境
flutter doctor

# 2. 安装依赖
flutter pub get

# 3. 连接设备或启动模拟器
flutter devices

# 4. 运行应用（开发模式）
flutter run

# 5. 构建发布版本
flutter build apk --release

# 6. 查看输出文件
dir build\app\outputs\flutter-apk\
```

## 下一步

1. 完成上述步骤后，您将获得可安装的APK文件
2. 可以在Android设备上测试应用功能
3. 准备发布到Google Play Store时需要：
   - 注册Google Play开发者账号（$25一次性费用）
   - 准备应用图标、截图、描述等材料
   - 使用App Bundle格式上传

## 替代方案：使用在线构建服务

如果本地构建遇到问题，可以考虑使用：
- **Codemagic**: 自动化Flutter构建服务
- **Bitrise**: CI/CD平台支持Flutter
- **GitHub Actions**: 如果代码托管在GitHub上