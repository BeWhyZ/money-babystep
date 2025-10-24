import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../providers/locale_provider.dart';

/// 顶部固定栏组件
class TopBar extends ConsumerWidget implements PreferredSizeWidget {
  final VoidCallback? onProfileTap;

  const TopBar({super.key, this.onProfileTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    return Container(
      color: AppConstants.cardBackgroundColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppConstants.cardBackgroundColor,
            border: Border(
              bottom: BorderSide(color: AppConstants.dividerColor, width: 0.5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 左侧"我的"按钮
              InkWell(
                onTap: onProfileTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 20,
                        color: AppConstants.textPrimaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        strings.navProfile,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppConstants.textPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 中间APP名称
              Text(
                strings.appName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.textPrimaryColor,
                ),
              ),

              // 右侧占位（保持对称）
              const SizedBox(width: 60),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
