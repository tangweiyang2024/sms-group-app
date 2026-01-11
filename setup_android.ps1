# Android SDK 一键安装和配置脚本
Write-Host "===========================================" -ForegroundColor Green
Write-Host "Android SDK 一键安装脚本" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Green
Write-Host ""

# 设置变量
$SdkDir = "C:\Android\sdk"
$CmdToolsUrl = "https://dl.google.com/android/repository/commandlinetools-win-9513336_latest.zip"
$CmdToolsZip = "$env:TEMP\commandlinetools.zip"

# 步骤1：下载命令行工具
Write-Host "[步骤 1/4] 下载 Android SDK 命令行工具..." -ForegroundColor Yellow
Write-Host "正在从 Google 官方源下载..."
Write-Host ""

try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $CmdToolsUrl -OutFile $CmdToolsZip -UseBasicParsing
    Write-Host "下载完成！" -ForegroundColor Green
} catch {
    Write-Host "下载失败：$_" -ForegroundColor Red
    Write-Host "请手动下载并保存到：$CmdToolsZip"
    pause
    exit 1
}

# 步骤2：创建目录结构
Write-Host ""
Write-Host "[步骤 2/4] 创建 SDK 目录结构..." -ForegroundColor Yellow
if (-not (Test-Path $SdkDir)) {
    New-Item -Path $SdkDir -ItemType Directory -Force | Out-Null
}
if (-not (Test-Path "$SdkDir\cmdline-tools\latest")) {
    New-Item -Path "$SdkDir\cmdline-tools\latest" -ItemType Directory -Force | Out-Null
}
Write-Host "目录结构创建完成" -ForegroundColor Green

# 步骤3：解压文件
Write-Host ""
Write-Host "[步骤 3/4] 解压命令行工具..." -ForegroundColor Yellow
try {
    Expand-Archive -Path $CmdToolsZip -DestinationPath "$SdkDir\cmdline-tools\latest" -Force
    Write-Host "解压完成" -ForegroundColor Green
} catch {
    Write-Host "解压失败：$_" -ForegroundColor Red
    pause
    exit 1
}

# 步骤4：配置环境变量
Write-Host ""
Write-Host "[步骤 4/4] 配置环境变量..." -ForegroundColor Yellow
try {
    [Environment]::SetEnvironmentVariable("ANDROID_HOME", $SdkDir, "User")
    [Environment]::SetEnvironmentVariable("ANDROID_SDK_ROOT", $SdkDir, "User")

    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $newPath = "$currentPath;$SdkDir\cmdline-tools\latest\bin;$SdkDir\platform-tools"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")

    Write-Host "环境变量配置完成" -ForegroundColor Green
} catch {
    Write-Host "环境变量配置失败：$_" -ForegroundColor Red
}

# 清理临时文件
Write-Host ""
Write-Host "清理临时文件..."
Remove-Item $CmdToolsZip -Force -ErrorAction SilentlyContinue

# 完成
Write-Host ""
Write-Host "===========================================" -ForegroundColor Green
Write-Host "Android SDK 安装完成！" -ForegroundColor Green
Write-Host "===========================================" -ForegroundColor Green
Write-Host ""
Write-Host "SDK 位置：$SdkDir"
Write-Host ""
Write-Host "下一步操作："
Write-Host "1. 重启命令提示符或PowerShell"
Write-Host "2. 运行: .\install_sdk_components.ps1"
Write-Host "3. 运行: .\build_android.ps1"
Write-Host ""

pause