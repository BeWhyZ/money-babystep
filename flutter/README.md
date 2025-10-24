# 记账 - Flutter UI框架

一个基于Flutter + Riverpod + SQLite的个人记账应用。

## 项目结构

```
flutter/lib/
├── constants/              # 常量定义
│   └── app_constants.dart  # 应用常量（颜色、分类等）
│
├── models/                 # 数据模型
│   ├── transaction.dart    # 交易记录模型
│   ├── category.dart       # 分类模型
│   ├── asset.dart          # 资产模型
│   └── financial_indicators.dart  # 财务指标模型
│
├── services/               # 数据服务层
│   └── database_service.dart  # SQLite数据库服务
│
├── providers/              # Riverpod状态管理
│   ├── navigation_provider.dart    # 导航状态
│   ├── category_provider.dart      # 分类数据
│   ├── transaction_provider.dart   # 交易记录
│   └── asset_provider.dart         # 资产和财务指标
│
├── widgets/                # 通用组件
│   ├── top_bar.dart                # 顶部栏
│   ├── bottom_nav_bar.dart         # 底部导航栏
│   ├── transaction_input_sheet.dart  # 记账输入弹窗
│   ├── category_selector.dart       # 分类选择器
│   └── financial_indicator_card.dart  # 财务指标卡片
│
├── pages/                  # 页面
│   ├── main_frame_page.dart    # 主框架页
│   ├── bookkeeping_page.dart   # 记账页
│   ├── asset_page.dart         # 资产页
│   └── profile_page.dart       # 我的页
│
└── main.dart               # 应用入口
```

## 功能特性

### 1. 记账页面
- 月度收支总览（收入、支出、结余）
- 交易明细列表（按日期分组）
- 快捷记账功能（点击右下角"+"按钮）

### 2. 资产页面
- 净资产总览
- 财务指标展示：
  - 总资产 / 总负债
  - 储蓄率（建议≥20%）
  - 负债率（建议<50%）
  - 净资产增长率
  - 自由现金流
  - 应急储备充足度（建议3-6个月）
- 财务健康建议

### 3. 我的页面
- 用户信息管理
- 数据导入功能（微信、支付宝账单）
- 数据备份与恢复
- 分类管理
- 各项设置

## 技术栈

- **Flutter**: UI框架
- **Riverpod**: 状态管理
- **SQLite (sqflite)**: 本地数据库
- **intl**: 日期和数字格式化

## 快速开始

### 安装依赖

```bash
cd flutter
flutter pub get
```

### 运行应用

```bash
# iOS
flutter run -d ios

# Android
flutter run -d android

# Web
flutter run -d chrome
```

## 数据模型

### Transaction（交易记录）
- 金额、类型（支出/收入）
- 一级分类、二级分类（可选）
- 交易日期、备注

### Category（分类）
- 分类名称、父分类
- 类型（支出/收入）
- 图标

### Asset（资产）
- 资产名称、余额
- 类型（资产/负债）

### FinancialIndicators（财务指标）
- 总资产、总负债、净资产
- 收入、支出、储蓄
- 各类财务比率

## 预定义分类

### 支出分类
餐饮、购物、交通、通讯、医疗、居家、养老保险、宠物、娱乐

### 收入分类
工资、奖金、投资收益、其他

## UI设计

采用类微信风格设计：
- 顶部固定栏：左侧"我的"按钮 + 中间APP名称
- 底部导航栏：记账、资产 + 快捷记账"+"按钮
- 简洁的卡片式设计
- 清爽的绿色主题

## 待实现功能（TODO）

- [ ] 数据库实际数据CRUD操作
- [ ] 二级分类选择
- [ ] 分类名称显示（目前显示ID）
- [ ] 微信/支付宝账单导入
- [ ] 数据备份与恢复
- [ ] 分类管理
- [ ] 记账提醒
- [ ] 更多图表展示
- [ ] Rust后端集成（flutter_rust_bridge）

## 注意事项

1. 当前版本为UI框架搭建阶段，数据库操作已定义但留空实现
2. 状态管理使用Riverpod，遵循响应式编程模式
3. 所有组件均采用Material Design 3规范
4. 代码已通过Flutter Analyzer检查，无linter错误

## 版本信息

- Flutter SDK: >=3.9.2
- Dart SDK: >=3.0.0
- Version: 1.0.0+1
