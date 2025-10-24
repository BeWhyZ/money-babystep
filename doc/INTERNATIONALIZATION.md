# 国际化使用指南

本项目采用基于 Riverpod 的简单国际化方案，支持中英文切换。

## 架构设计

```
┌─────────────────────────────────────┐
│         AppStrings (抽象类)          │
│  定义所有文本字符串的接口             │
└─────────────┬───────────────────────┘
              │
       ┌──────┴──────┐
       │             │
   ┌───▼───┐    ┌───▼───┐
   │ 中文   │    │ 英文   │
   │ AppStringsZh│  │AppStringsEn│
   └───┬───┘    └───┬───┘
       │             │
       └──────┬──────┘
              │
      ┌───────▼────────┐
      │ LocaleProvider  │
      │  (状态管理)      │
      └────────────────┘
```

## 文件结构

```
lib/
├── constants/
│   └── app_strings.dart         # 定义所有字符串
│
└── providers/
    └── locale_provider.dart     # 语言状态管理
```

## 核心组件说明

### 1. AppStrings 抽象类

定义了应用中所有文本字符串的接口：

```dart
abstract class AppStrings {
  String get appName;
  String get navBookkeeping;
  String get navAsset;
  // ... 更多字符串
}
```

### 2. 具体实现类

#### AppStringsZh (中文)
```dart
class AppStringsZh implements AppStrings {
  @override
  String get appName => '记账';
  
  @override
  String get navBookkeeping => '记账';
  
  @override
  String get navAsset => '资产';
  // ...
}
```

#### AppStringsEn (英文)
```dart
class AppStringsEn implements AppStrings {
  @override
  String get appName => 'Bookkeeping';
  
  @override
  String get navBookkeeping => 'Bookkeeping';
  
  @override
  String get navAsset => 'Assets';
  // ...
}
```

### 3. Provider 定义

```dart
// 语言枚举
enum AppLocale {
  zh, // 中文
  en, // 英文
}

// 当前语言状态
final localeProvider = StateProvider<AppLocale>((ref) => AppLocale.zh);

// 字符串提供者
final stringsProvider = Provider<AppStrings>((ref) {
  final locale = ref.watch(localeProvider);
  
  switch (locale) {
    case AppLocale.zh:
      return AppStringsZh();
    case AppLocale.en:
      return AppStringsEn();
  }
});
```

## 使用方法

### 1. 在组件中使用字符串

将 `StatelessWidget` 改为 `ConsumerWidget`，然后使用 `ref.watch(stringsProvider)`:

```dart
class MyWidget extends ConsumerWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    
    return Text(strings.appName); // 自动根据语言显示
  }
}
```

### 2. 切换语言

在任何地方调用：

```dart
// 切换到英文
ref.read(localeProvider.notifier).state = AppLocale.en;

// 切换到中文
ref.read(localeProvider.notifier).state = AppLocale.zh;
```

### 3. 获取当前语言

```dart
final currentLocale = ref.watch(localeProvider);

if (currentLocale == AppLocale.zh) {
  // 当前是中文
}
```

## 添加新字符串的步骤

### 1. 在 AppStrings 抽象类中添加 getter

```dart
abstract class AppStrings {
  // ... 现有字符串
  
  // 新增字符串
  String get myNewString;
}
```

### 2. 在所有实现类中提供翻译

```dart
// 中文实现
class AppStringsZh implements AppStrings {
  // ...
  
  @override
  String get myNewString => '我的新文本';
}

// 英文实现
class AppStringsEn implements AppStrings {
  // ...
  
  @override
  String get myNewString => 'My New String';
}
```

### 3. 在组件中使用

```dart
Text(strings.myNewString)
```

## 字符串分类

项目中的字符串按功能分类：

### 应用基础
- `appName`: 应用名称

### 导航相关
- `navBookkeeping`: 记账
- `navAsset`: 资产
- `navProfile`: 我的

### 记账页面
- `bookkeepingTitle`: 页面标题
- `bookkeepingIncome`: 收入
- `bookkeepingExpense`: 支出
- `bookkeepingBalance`: 结余
- `bookkeepingNoData`: 无数据提示
- `bookkeepingToday`: 今天
- `bookkeepingYesterday`: 昨天

### 资产页面
- `assetTitle`: 页面标题
- `assetNetAsset`: 净资产
- `assetFinancialIndicators`: 财务指标
- `assetTotalAssets`: 总资产
- `assetTotalLiabilities`: 总负债
- `assetSavingsRate`: 储蓄率
- `assetDebtRatio`: 负债率
- `assetNetAssetsGrowthRate`: 净资产增长率
- `assetFreeCashFlow`: 自由现金流
- `assetEmergencyReserve`: 应急储备
- `assetFinancialAdvice`: 财务建议

### 交易输入
- `transactionExpense`: 支出
- `transactionIncome`: 收入
- `transactionAmount`: 金额
- `transactionCategory`: 分类
- `transactionNote`: 备注
- `transactionComplete`: 完成

### 分类
- `categoryFood`: 餐饮
- `categoryShopping`: 购物
- `categoryTransport`: 交通
- `categoryTelecom`: 通讯
- `categoryMedical`: 医疗
- `categoryHome`: 居家
- `categoryPension`: 养老保险
- `categoryPet`: 宠物
- `categoryEntertainment`: 娱乐
- `categorySalary`: 工资
- `categoryBonus`: 奖金
- `categoryInvestment`: 投资收益
- `categoryOther`: 其他

### 我的页面
- `profileTitle`: 页面标题
- `profileUsername`: 用户名
- `profileDataManagement`: 数据管理
- `profileSettings`: 设置
- `profileAbout`: 关于
- `profileLanguage`: 语言设置
- 等等...

### 通用
- `commonLoading`: 加载中
- `commonError`: 错误
- `commonRetry`: 重试
- `commonConfirm`: 确认
- `commonCancel`: 取消
- `commonEdit`: 编辑
- `commonDelete`: 删除
- `commonSave`: 保存

## 语言设置页面

已实现语言设置页面 `LanguageSettingsPage`，用户可以在此切换语言：

- 位置：我的 → 语言设置
- 支持：简体中文、English
- 实时切换，无需重启应用

## 最佳实践

### 1. 命名规范

使用驼峰命名，前缀表示所属模块：

```dart
// ✅ 好的命名
String get assetTotalAssets;
String get bookkeepingIncome;
String get profileSettings;

// ❌ 不好的命名
String get total;  // 不明确
String get str1;   // 无意义
```

### 2. 分组管理

在抽象类中用注释分组：

```dart
abstract class AppStrings {
  // ===== 导航相关 =====
  String get navBookkeeping;
  String get navAsset;
  
  // ===== 记账页面 =====
  String get bookkeepingTitle;
  String get bookkeepingIncome;
}
```

### 3. 复数和变量处理

对于需要插入变量的字符串，可以使用方法：

```dart
abstract class AppStrings {
  String profileDaysCount(int days);
}

class AppStringsZh implements AppStrings {
  @override
  String profileDaysCount(int days) => '记账 $days 天';
}

class AppStringsEn implements AppStrings {
  @override
  String profileDaysCount(int days) => '$days day${days > 1 ? 's' : ''}';
}
```

使用：
```dart
Text(strings.profileDaysCount(7))
```

### 4. 性能优化

`stringsProvider` 是 `Provider` 类型，会自动缓存，无需担心性能问题。

## 添加新语言

要添加新语言（如日语），按以下步骤：

### 1. 扩展 AppLocale 枚举

```dart
enum AppLocale {
  zh, // 中文
  en, // 英文
  ja, // 日文
}
```

### 2. 创建新的实现类

```dart
class AppStringsJa implements AppStrings {
  @override
  String get appName => '家計簿';
  
  @override
  String get navBookkeeping => '記帳';
  
  // ... 实现所有字符串
}
```

### 3. 更新 stringsProvider

```dart
final stringsProvider = Provider<AppStrings>((ref) {
  final locale = ref.watch(localeProvider);
  
  switch (locale) {
    case AppLocale.zh:
      return AppStringsZh();
    case AppLocale.en:
      return AppStringsEn();
    case AppLocale.ja:
      return AppStringsJa();
  }
});
```

### 4. 更新语言设置页面

在 `LanguageSettingsPage` 中添加新选项。

## 与其他方案对比

### vs. 官方 intl + ARB

**优点**：
- ✅ 无需代码生成
- ✅ 配置简单
- ✅ 类型安全
- ✅ 易于维护

**缺点**：
- ❌ 没有 IDE 的 ARB 文件支持
- ❌ 不支持复数规则（可手动实现）
- ❌ 不支持日期/数字格式化（可使用 intl 包）

### 何时升级到官方方案

当以下情况出现时，考虑升级：

1. 支持语言超过 5 种
2. 需要专业翻译团队协作
3. 需要 IDE 的翻译文件支持
4. 需要复杂的复数规则

## 调试技巧

### 1. 查找未翻译的文本

搜索项目中直接使用的中文字符串：

```bash
grep -r "Text(" lib/ | grep "[\u4e00-\u9fa5]"
```

### 2. 验证所有语言都有实现

确保每个 `AppStrings` 的实现类都实现了所有 getter。Dart 的类型系统会在编译时检查。

### 3. 实时切换测试

在开发时，可以添加快捷方式快速切换语言：

```dart
FloatingActionButton(
  onPressed: () {
    final current = ref.read(localeProvider);
    ref.read(localeProvider.notifier).state =
        current == AppLocale.zh ? AppLocale.en : AppLocale.zh;
  },
  child: const Icon(Icons.language),
)
```

## 常见问题

### Q: 为什么不使用 Flutter 官方的 `Localizations`?

A: 官方方案对于中小型项目过于复杂。本方案更简单直接，满足大多数需求。

### Q: 如何持久化用户的语言选择？

A: 使用 `shared_preferences` 或其他本地存储方案：

```dart
// 保存
await prefs.setString('locale', AppLocale.zh.name);

// 读取
final savedLocale = prefs.getString('locale');
if (savedLocale != null) {
  ref.read(localeProvider.notifier).state = 
      AppLocale.values.firstWhere((e) => e.name == savedLocale);
}
```

### Q: 如何根据系统语言自动选择？

A: 在 `main.dart` 中：

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(ProviderScope(
    overrides: [
      localeProvider.overrideWith((ref) {
        final systemLocale = Platform.localeName; // 如 'zh_CN'
        if (systemLocale.startsWith('zh')) {
          return AppLocale.zh;
        } else {
          return AppLocale.en;
        }
      }),
    ],
    child: const MyApp(),
  ));
}
```

## 总结

本国际化方案的特点：

- ✅ **简单直接**：无需复杂配置
- ✅ **类型安全**：编译时检查
- ✅ **易于扩展**：添加新语言只需实现一个类
- ✅ **响应式**：使用 Riverpod 自动更新 UI
- ✅ **高性能**：自动缓存，无额外开销

适合中小型项目快速实现国际化需求。
