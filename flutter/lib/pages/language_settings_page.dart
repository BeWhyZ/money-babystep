import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../providers/locale_provider.dart';

/// 语言设置页面
class LanguageSettingsPage extends ConsumerWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final strings = ref.watch(stringsProvider);

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: Text(strings.profileLanguage),
        backgroundColor: AppConstants.cardBackgroundColor,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _LanguageItem(
            title: '简体中文',
            subtitle: 'Simplified Chinese',
            isSelected: currentLocale == AppLocale.zh,
            onTap: () {
              ref.read(localeProvider.notifier).state = AppLocale.zh;
            },
          ),
          const SizedBox(height: 12),
          _LanguageItem(
            title: 'English',
            subtitle: 'English',
            isSelected: currentLocale == AppLocale.en,
            onTap: () {
              ref.read(localeProvider.notifier).state = AppLocale.en;
            },
          ),
        ],
      ),
    );
  }
}

/// 语言选项组件
class _LanguageItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageItem({
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConstants.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? AppConstants.primaryColor
              : AppConstants.dividerColor,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected
                ? AppConstants.primaryColor
                : AppConstants.textPrimaryColor,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: AppConstants.textSecondaryColor,
          ),
        ),
        trailing: isSelected
            ? Icon(Icons.check_circle, color: AppConstants.primaryColor)
            : null,
        onTap: onTap,
      ),
    );
  }
}
