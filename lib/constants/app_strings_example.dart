/// 新国际化系统使用示例
///
/// 本文件展示了新的基于枚举的国际化系统的各种使用方式

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_strings.dart';
import '../providers/locale_provider.dart';

/// ============================================
/// 使用方式 1: 使用扩展方法（最推荐）
/// ============================================
class Example1 extends ConsumerWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(localeProvider);

    return Column(
      children: [
        // ✅ 推荐：清晰直观
        Text(AppStrings.appName.tr(language)),
        Text(AppStrings.bookkeepingTitle.tr(language)),
        Text(AppStrings.transactionSuccess.tr(language)),
      ],
    );
  }
}

/// ============================================
/// 使用方式 2: 直接访问中文或英文
/// ============================================
class Example2 extends StatelessWidget {
  const Example2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 固定显示中文
        Text(AppStrings.appName.zh),

        // 固定显示英文
        Text(AppStrings.appName.en),
      ],
    );
  }
}

/// ============================================
/// 使用方式 3: 在无 context 的地方使用
/// ============================================
class Example3 {
  void printMessage(Language language) {
    // 在普通类或函数中使用
    print(AppStrings.transactionSuccess.tr(language));
    print(AppStrings.transactionFailed.tr(language));
  }

  String getLocalizedText(Language language) {
    return AppStrings.bookkeepingTitle.tr(language);
  }
}

/// ============================================
/// 使用方式 4: 语言切换
/// ============================================
class LanguageSettingsExample extends ConsumerWidget {
  const LanguageSettingsExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(localeProvider);

    return Column(
      children: [
        // 显示当前语言
        Text('当前语言: ${currentLanguage.displayName}'),

        const SizedBox(height: 16),

        // 语言切换按钮
        ...Language.values.map((language) {
          return RadioListTile<Language>(
            title: Text(language.displayName),
            subtitle: Text(language.englishName),
            value: language,
            groupValue: currentLanguage,
            onChanged: (value) {
              if (value != null) {
                // 切换语言
                ref.read(localeProvider.notifier).state = value;
              }
            },
          );
        }),
      ],
    );
  }
}

/// ============================================
/// 使用方式 5: 在列表构建器中使用
/// ============================================
class Example5 extends ConsumerWidget {
  const Example5({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(localeProvider);

    final categories = [
      AppStrings.categoryFood,
      AppStrings.categoryShopping,
      AppStrings.categoryTransport,
    ];

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(categories[index].tr(language)));
      },
    );
  }
}

/// ============================================
/// 使用方式 6: 在对话框中使用
/// ============================================
class Example6 {
  static void showConfirmDialog(BuildContext context, WidgetRef ref) {
    final language = ref.read(localeProvider);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppStrings.commonConfirm.tr(language)),
        content: Text(AppStrings.transactionSuccess.tr(language)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.commonCancel.tr(language)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppStrings.commonConfirm.tr(language)),
          ),
        ],
      ),
    );
  }
}

/// ============================================
/// 使用方式 7: 枚举特性
/// ============================================
class Example7 {
  void demonstrateEnumFeatures() {
    // 获取所有语言
    for (var language in Language.values) {
      print('${language.displayName} (${language.englishName})');
      print('Code: ${language.code}');
    }

    // 根据名称获取枚举
    final zh = Language.values.byName('zh');
    print(zh.displayName); // 输出: 中文

    // 判断是否为特定语言
    final currentLang = Language.zh;
    if (currentLang == Language.zh) {
      print('当前是中文');
    }

    // Switch 语句（类型安全）
    switch (currentLang) {
      case Language.zh:
        print('Chinese');
        break;
      case Language.en:
        print('English');
        break;
    }
  }
}

/// ============================================
/// 使用方式 8: 创建自定义 Widget
/// ============================================
class LocalizedText extends ConsumerWidget {
  final (String, String) text;
  final TextStyle? style;

  const LocalizedText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(localeProvider);
    return Text(text.tr(language), style: style);
  }
}

// 使用示例
class Example8 extends StatelessWidget {
  const Example8({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LocalizedText(AppStrings.appName),
        LocalizedText(
          AppStrings.bookkeepingTitle,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

/// ============================================
/// 完整的实际使用案例
/// ============================================
class BookkeepingPageExample extends ConsumerWidget {
  const BookkeepingPageExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.bookkeepingTitle.tr(language)),
        actions: [
          // 语言切换按钮
          PopupMenuButton<Language>(
            initialValue: language,
            onSelected: (value) {
              ref.read(localeProvider.notifier).state = value;
            },
            itemBuilder: (context) => Language.values.map((lang) {
              return PopupMenuItem(value: lang, child: Text(lang.displayName));
            }).toList(),
          ),
        ],
      ),
      body: Column(
        children: [
          // 收支显示
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(AppStrings.bookkeepingIncome.tr(language)),
                  const Text('¥1000'),
                ],
              ),
              Column(
                children: [
                  Text(AppStrings.bookkeepingExpense.tr(language)),
                  const Text('¥500'),
                ],
              ),
            ],
          ),

          // 空状态
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.bookkeepingNoData.tr(language)),
                  const SizedBox(height: 8),
                  Text(AppStrings.bookkeepingNoDataHint.tr(language)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
