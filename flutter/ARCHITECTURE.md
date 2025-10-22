# 项目架构说明

## 架构概览

本项目采用 **MVVM + Repository** 架构模式，结合 Riverpod 状态管理，实现清晰的分层结构。

```
┌─────────────────────────────────────────────────────┐
│                    UI Layer (View)                   │
│  ┌───────────────┐  ┌───────────────┐  ┌──────────┐ │
│  │ MainFramePage │  │ BookkeepingPg │  │ AssetPg  │ │
│  └───────────────┘  └───────────────┘  └──────────┘ │
│          │                  │                │       │
└──────────┼──────────────────┼────────────────┼───────┘
           │                  │                │
           ▼                  ▼                ▼
┌─────────────────────────────────────────────────────┐
│              State Management (ViewModel)            │
│  ┌─────────────────┐  ┌──────────────────────────┐  │
│  │ NavigationPrvdr │  │ TransactionNotifier      │  │
│  └─────────────────┘  └──────────────────────────┘  │
│  ┌─────────────────┐  ┌──────────────────────────┐  │
│  │ AssetNotifier   │  │ CategoryProvider         │  │
│  └─────────────────┘  └──────────────────────────┘  │
│          │                  │                │       │
└──────────┼──────────────────┼────────────────┼───────┘
           │                  │                │
           ▼                  ▼                ▼
┌─────────────────────────────────────────────────────┐
│              Repository / Service Layer              │
│  ┌──────────────────────────────────────────────┐   │
│  │         DatabaseService (Repository)         │   │
│  │  - Transaction CRUD                          │   │
│  │  - Category CRUD                             │   │
│  │  - Asset CRUD                                │   │
│  └──────────────────────────────────────────────┘   │
│          │                                           │
└──────────┼───────────────────────────────────────────┘
           │
           ▼
┌─────────────────────────────────────────────────────┐
│                   Data Layer                         │
│  ┌──────────────────────────────────────────────┐   │
│  │              SQLite Database                 │   │
│  │  - transactions table                        │   │
│  │  - categories table                          │   │
│  │  - assets table                              │   │
│  └──────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────┘
```

## 数据流向

### 读取数据流
```
User Action → Widget → Provider (read) → Service → Database
                ↓
            Widget rebuild with new data
```

### 写入数据流
```
User Input → Widget → Provider (notifier) → Service → Database
                                              ↓
                                        Notify listeners
                                              ↓
                                        UI auto-update
```

## 核心模块说明

### 1. 常量层 (Constants)
- **职责**: 定义应用级常量
- **文件**: `app_constants.dart`
- **内容**: 颜色、分类、枚举等

### 2. 数据模型层 (Models)
- **职责**: 定义数据结构
- **文件**: 
  - `transaction.dart`: 交易记录
  - `category.dart`: 分类
  - `asset.dart`: 资产
  - `financial_indicators.dart`: 财务指标
- **特点**: 
  - 包含 `fromMap` 和 `toMap` 方法用于数据库转换
  - 不包含业务逻辑

### 3. 服务层 (Services)
- **职责**: 数据访问和业务逻辑
- **文件**: `database_service.dart`
- **功能**:
  - 数据库初始化
  - CRUD操作封装
  - 数据查询和过滤
- **模式**: 单例模式

### 4. 状态管理层 (Providers)
- **职责**: 状态管理和业务协调
- **技术**: Flutter Riverpod
- **类型**:
  - `StateProvider`: 简单状态（如导航索引）
  - `StateNotifierProvider`: 复杂状态（如交易列表）
  - `Provider`: 计算衍生状态（如月度统计）
  - `FutureProvider`: 异步数据加载

#### Provider依赖关系
```
financialIndicatorsProvider
    ├─→ totalAssetsProvider
    │       └─→ assetProvider
    ├─→ totalLiabilitiesProvider
    │       └─→ assetProvider
    ├─→ monthlyIncomeProvider
    │       └─→ transactionProvider
    └─→ monthlyExpenseProvider
            └─→ transactionProvider
```

### 5. 组件层 (Widgets)
- **职责**: 可复用的UI组件
- **组件**:
  - `TopBar`: 顶部导航栏
  - `BottomNavBar`: 底部导航栏
  - `TransactionInputSheet`: 记账输入
  - `CategorySelector`: 分类选择
  - `FinancialIndicatorCard`: 指标卡片

### 6. 页面层 (Pages)
- **职责**: 完整的页面组件
- **页面**:
  - `MainFramePage`: 主框架
  - `BookkeepingPage`: 记账页
  - `AssetPage`: 资产页
  - `ProfilePage`: 我的页

## 状态管理模式

### StateNotifier使用模式
```dart
class TransactionNotifier extends StateNotifier<AsyncValue<List<Transaction>>> {
  // 1. 初始化为loading状态
  TransactionNotifier() : super(const AsyncValue.loading()) {
    loadTransactions();
  }
  
  // 2. 异步加载数据
  Future<void> loadTransactions() async {
    state = const AsyncValue.loading();
    try {
      final data = await _service.getData();
      state = AsyncValue.data(data);  // 3. 更新为data状态
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);  // 4. 错误处理
    }
  }
}
```

### Consumer使用模式
```dart
Consumer(
  builder: (context, ref, child) {
    final asyncValue = ref.watch(provider);
    return asyncValue.when(
      data: (data) => DataWidget(data),
      loading: () => LoadingWidget(),
      error: (e, _) => ErrorWidget(e),
    );
  },
)
```

## 数据库设计

### 表结构

#### transactions (交易记录表)
```sql
CREATE TABLE transactions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  amount REAL NOT NULL,
  type INTEGER NOT NULL,              -- 0:支出, 1:收入
  primary_category_id INTEGER NOT NULL,
  secondary_category_id INTEGER,
  note TEXT,
  transaction_date TEXT NOT NULL,
  created_at TEXT NOT NULL,
  updated_at TEXT
)
```

#### categories (分类表)
```sql
CREATE TABLE categories (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  parent_id INTEGER,                  -- NULL表示一级分类
  icon_name TEXT,
  type INTEGER NOT NULL,              -- 0:支出, 1:收入
  FOREIGN KEY (parent_id) REFERENCES categories(id)
)
```

#### assets (资产表)
```sql
CREATE TABLE assets (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  balance REAL NOT NULL,
  type INTEGER NOT NULL,              -- 0:资产, 1:负债
  note TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT
)
```

## 导航流程

```
MainFramePage (Root)
    ├─→ BookkeepingPage (Tab 0)
    │      └─→ TransactionInputSheet (Modal)
    │
    ├─→ AssetPage (Tab 1)
    │
    └─→ ProfilePage (Push Navigation)
           └─→ 各种设置页面 (未实现)
```

## UI设计原则

1. **类微信风格**: 简洁、直观的界面设计
2. **卡片式布局**: 信息分组清晰
3. **Material Design 3**: 遵循最新设计规范
4. **响应式设计**: 适配不同屏幕尺寸
5. **性能优化**: 
   - 使用 `const` 构造函数
   - `IndexedStack` 保持页面状态
   - 列表懒加载

## 错误处理

### 数据层错误
```dart
try {
  await _service.operation();
} catch (e) {
  // 记录错误
  rethrow; // 或转换为友好的错误信息
}
```

### UI层错误
```dart
asyncValue.when(
  data: (data) => SuccessWidget(data),
  loading: () => LoadingWidget(),
  error: (error, stack) => ErrorWidget(
    message: '加载失败: $error',
    onRetry: () => ref.refresh(provider),
  ),
)
```

## 扩展性设计

### 添加新功能的步骤

1. **定义数据模型** (models/)
2. **更新数据库服务** (services/)
3. **创建状态提供者** (providers/)
4. **实现UI组件** (widgets/)
5. **创建页面** (pages/)
6. **集成到主应用**

### 示例：添加预算功能

```
1. 创建 models/budget.dart
2. 在 database_service.dart 添加 budget 表和CRUD
3. 创建 providers/budget_provider.dart
4. 创建 widgets/budget_card.dart
5. 创建 pages/budget_page.dart
6. 在 main_frame_page.dart 添加导航
```

## 性能优化建议

1. **数据库优化**
   - 为常用查询字段添加索引
   - 使用批量操作
   - 实现分页加载

2. **状态管理优化**
   - 使用 `select` 监听部分状态
   - 避免不必要的重建
   - 合理使用 `autoDispose`

3. **UI优化**
   - 图片懒加载
   - 列表项复用
   - 避免深层嵌套

## 测试策略

### 单元测试
- 数据模型转换
- Provider逻辑
- 工具函数

### 集成测试
- 数据库操作
- 状态管理流程

### Widget测试
- 组件渲染
- 用户交互
- 导航流程

## 未来规划

1. **Rust后端集成** (flutter_rust_bridge)
   - 高性能数据处理
   - 复杂财务计算
   - 数据加密

2. **数据同步**
   - 云端备份
   - 多设备同步

3. **高级功能**
   - 图表可视化
   - 数据导出
   - 账单识别（OCR）
   - 预算管理

