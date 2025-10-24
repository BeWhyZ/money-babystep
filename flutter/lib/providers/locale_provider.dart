import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_strings.dart';

/// 支持的语言枚举
enum AppLocale {
  zh, // 中文
  en, // 英文
}

/// 语言状态提供者
final localeProvider = StateProvider<AppLocale>((ref) => AppLocale.zh);

/// 字符串提供者 - 根据当前语言返回对应的字符串
final stringsProvider = Provider<AppStrings>((ref) {
  final locale = ref.watch(localeProvider);

  switch (locale) {
    case AppLocale.zh:
      return AppStringsZh();
    case AppLocale.en:
      return AppStringsEn();
  }
});
