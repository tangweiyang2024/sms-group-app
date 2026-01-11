FROM ubuntu:22.04

# 避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基础工具
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

# 安装 Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /opt/flutter
ENV PATH="/opt/flutter/bin:${PATH}"
ENV FLUTTER_ROOT="/opt/flutter"

# 配置 Flutter 国内镜像
ENV PUB_HOSTED_URL=https://pub.flutter-io.cn
ENV FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# 预热 Flutter
RUN flutter doctor --verbose > /dev/null 2>&1 || true
RUN flutter precache --android

# 安装 Android SDK
RUN mkdir -p /opt/android-sdk/cmdline-tools
RUN curl -L https://dl.google.com/android/repository/commandlinetools-linux-9513336_latest.zip -o /tmp/cmdline-tools.zip
RUN unzip -q /tmp/cmdline-tools.zip -d /opt/android-sdk/cmdline-tools
RUN mv /opt/android-sdk/cmdline-tools/cmdline-tools /opt/android-sdk/cmdline-tools/latest

ENV ANDROID_HOME="/opt/android-sdk"
ENV ANDROID_SDK_ROOT="/opt/android-sdk"
ENV PATH="${PATH}:/opt/android-sdk/cmdline-tools/latest/bin:/opt/android-sdk/platform-tools"

# 接受许可证
RUN yes | sdkmanager --licenses > /dev/null 2>&1 || true

# 安装必要的 SDK 组件
RUN sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0"

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 安装依赖
RUN flutter pub get

# 构建 APK
RUN flutter build apk --release

# 复制 APK 到输出目录
RUN cp build/app/outputs/flutter-apk/app-release.apk /app/sms-group-app.apk

# 输出文件位置说明
VOLUME ["/app/output"]

CMD ["sh", "-c", "echo 'APK 文件位置: /app/sms-group-app.apk' && ls -lh /app/sms-group-app.apk"]