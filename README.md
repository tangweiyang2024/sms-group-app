# 短信分组 Flutter App

一款支持关键字和正则表达式进行短信分组的跨平台移动应用。

## 项目简介

基于Flutter开发的智能短信分组管理应用，支持iOS和Android双平台。用户可以通过自定义规则（关键字、正则表达式、发件人匹配）将短信自动分类到不同组别，提高短信管理效率。

## 功能特点

- **智能分组**: 支持关键字、正则表达式、发件人三种匹配模式
- **优先级排序**: 规则按优先级依次匹配，确保精确分类
- **可视化编辑**: 直观的规则编辑器，支持实时测试
- **颜色标识**: 为不同分组设置颜色标识，便于识别
- **数据持久化**: SQLite存储规则和分组数据
- **跨平台**: 同时支持iOS和Android，代码复用率高

## 技术架构

### 技术栈
- **框架**: Flutter 3.x
- **语言**: Dart 3.x
- **最低支持**: iOS 15+, Android 5.0+
- **架构模式**: MVVM + Provider状态管理
- **数据库**: SQLite
- **配置存储**: SharedPreferences

### 项目结构
```
lib/
├── main.dart                 # 应用入口
├── models/                   # 数据模型层
│   ├── sms_message.dart      # 短信模型
│   ├── group_rule.dart       # 分组规则模型
│   └── sms_group.dart        # 分组数据模型
├── services/                 # 服务层
│   ├── sms_service.dart      # 短信服务
│   ├── grouping_engine.dart  # 分组引擎
│   └── storage_service.dart  # 数据持久化服务
├── views/                    # 视图层
│   ├── main_tab_view.dart    # 主标签页
│   ├── sms_list_view.dart    # 短信列表视图
│   ├── grouped_sms_view.dart # 分组短信视图
│   ├── group_detail_view.dart # 分组详情视图
│   ├── rule_list_view.dart   # 规则列表视图
│   └── rule_editor_view.dart # 规则编辑器视图
└── widgets/                  # 自定义组件
    ├── message_card.dart     # 短信卡片
    ├── group_card.dart       # 分组卡片
    └── rule_card.dart        # 规则卡片
```

## 快速开始

### 环境要求
- Flutter SDK 3.0+
- Dart 3.0+
- Android Studio / VS Code
- iOS开发需要Xcode（仅macOS）

### 安装步骤

1. **克隆项目**
```bash
git clone <repository-url>
cd sms-group
```

2. **安装依赖**
```bash
flutter pub get
```

3. **运行项目**
```bash
# Android
flutter run

# iOS (仅macOS)
flutter run -d ios
```

### 主要依赖
```yaml
dependencies:
  provider: ^6.1.1          # 状态管理
  sqflite: ^2.3.0           # 本地数据库
  shared_preferences: ^2.2.2 # 配置存储
  flutter_colorpicker: ^1.0.3 # 颜色选择器
  intl: ^0.18.1             # 国际化
  uuid: ^4.2.1              # 唯一标识符生成
```

## 功能使用说明

### 1. 短信管理
- 查看所有短信和未分组短信
- 下拉刷新短信列表
- 实时显示短信分组状态

### 2. 分组查看
- 查看所有已创建的分组
- 点击分组查看分组内短信
- 显示每个分组的短信数量

### 3. 规则管理
- 创建新的分组规则
- 编辑现有规则
- 删除不需要的规则
- 设置规则优先级

### 4. 规则编辑器
- **基本设置**: 设置分组名称、匹配类型、优先级
- **模式配置**: 添加/删除匹配模式
- **颜色选择**: 8种预设颜色选择
- **实时测试**: 测试规则的匹配效果

## 匹配模式详解

### 关键字匹配
- 在短信内容和发件人中搜索关键字
- 支持多关键字，任一匹配即成功
- 示例: `["银行", "账户", "余额"]`

### 正则表达式匹配
- 支持完整的正则表达式语法
- 可进行复杂的模式匹配
- 示例: `[r'\d{6}', '验证码']`

### 发件人匹配
- 精确匹配发件人号码或名称
- 示例: `["10086", "10010", "95588"]`

## 开发说明

### 状态管理
使用Provider进行全局状态管理，主要状态包括：
- `SMSService`: 短信和分组数据管理
- `StorageService`: 数据持久化服务

### 数据持久化
- **SQLite**: 存储分组规则和分组数据
- **SharedPreferences**: 存储用户配置信息

### 平台差异处理
- **iOS**: 使用MessageKit框架读取短信
- **Android**: 使用ContentResolver读取短信
- **权限管理**: 自动处理短信访问权限

## 后续优化计划

- [ ] 实现真实短信访问功能
- [ ] 添加iCloud/Google Drive同步
- [ ] 支持批量操作短信
- [ ] 添加主屏幕小组件
- [ ] 实现暗黑模式
- [ ] 添加规则导入/导出功能
- [ ] 支持多语言国际化
- [ ] 优化性能和内存使用

## 常见问题

### 1. Windows开发iOS应用
Flutter允许在Windows上开发iOS应用，但最终打包需要Mac电脑。可以使用：
- 云端Mac服务
- 虚拟机
- 借用朋友Mac进行打包

### 2. 短信权限
- Android需要在运行时请求READ_SMS权限
- iOS需要在Info.plist中添加权限说明

### 3. 数据迁移
应用会自动处理版本升级时的数据库迁移。

## 许可证
MIT License

## 贡献指南
欢迎提交Pull Request和Issue。

## 联系方式
如有问题，请提交Issue或联系开发者。