# Money Babystep 记账本

一个以“快速导入、自动成账、可视化洞察”为核心的个人记账应用。支持从支付宝、微信导出的账单一键导入，自动生成账本与分类，配合丰富图表与财务指标，让用户快速了解个人财务状况。

## 项目定位与期望

- 让用户在几分钟内完成从账单导入到生成账本的完整流程
- 提供清晰的收支趋势、资产负债结构与关键财务指标
- 以低学习成本的交互与类微信的 UI 体验快速上手

## 技术架构

- **Flutter**：移动端 UI 与交互层实现
- **Rust**：核心业务逻辑与数据处理
- **Rinf (Rust in Flutter)**：Flutter 与 Rust 之间的事件驱动通信
- **Riverpod**：状态管理
- **SQLite**：本地持久化存储
- **Kotlin / Swift**：必要时进行启动速度、内存与包体优化

## Rust 技术栈

基于 `native/hub/Cargo.toml` 与当前工程使用方式整理：

- **Rinf**：Flutter 与 Rust 的信号通信（Dart ↔ Rust）
- **Tokio**：异步运行时与任务调度
- **Serde**：数据结构序列化/反序列化
- **SQLx + SQLite**：异步数据库访问
- **SeaORM**：ORM 抽象与实体建模（SQLite）
- **Rusqlite**：SQLite 底层能力补充与兼容
- **Chrono**：时间与日期处理
- **Tracing**：结构化日志与诊断
- **Anyhow**：统一错误处理
- **Async-trait**：异步 trait 支持
- **Once_cell**：惰性初始化与全局单例

## 架构层级

```
native/  # 业务逻辑均通过 Rust 实现，Flutter 与 Rust 使用 Rinf 通信
├── README.md
└── hub
    ├── Cargo.toml
    ├── migrations
    └── src
        ├── biz      # 业务逻辑与数据仓储接口定义
        ├── data     # 数据仓储实现（SQLite）
        ├── server   # 服务启动与初始化
        └── service  # 服务编排层，对外提供业务能力
```

## 亮点

- **便捷导入**：支持支付宝与微信账单导入，自动解析并生成账本
- **快速成账**：减少手动录入成本，导入即生成可用账本
- **图表丰富**：多维度收支趋势、分类占比、资产负债结构展示
- **财务指标**：核心财务指标与健康建议快速呈现

## 功能概览

- 收支明细与分类记账
- 资产与负债汇总展示
- 账单导入与快速成账
- 图表分析与财务指标

## 开发与运行

```bash
flutter pub get
flutter run
```

如需使用 Rust 与 Flutter 之间的信号通信：

```bash
cargo install rinf_cli
rinf gen
```

## 设计与实现要求

- 顶层 UI 参考微信式交互，降低学习成本
- Flutter UI 遵循最佳实践，组件可复用、性能可控
- Rust 端遵循工程最佳实践，避免业务逻辑外泄至 UI 层
- 需要时用 Kotlin / Swift 做原生优化
