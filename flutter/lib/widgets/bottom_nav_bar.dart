import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../providers/navigation_provider.dart';

/// 底部导航栏组件
class BottomNavBar extends ConsumerWidget {
  final VoidCallback onAddTransaction;

  const BottomNavBar({super.key, required this.onAddTransaction});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);

    return Container(
      decoration: BoxDecoration(
        color: AppConstants.cardBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              // 记账导航按钮
              Expanded(
                child: _NavButton(
                  icon: Icons.book_outlined,
                  label: '记账',
                  isSelected: currentIndex == 0,
                  onTap: () {
                    ref.read(navigationIndexProvider.notifier).state = 0;
                  },
                ),
              ),

              // 资产导航按钮
              Expanded(
                child: _NavButton(
                  icon: Icons.account_balance_wallet_outlined,
                  label: '资产',
                  isSelected: currentIndex == 1,
                  onTap: () {
                    ref.read(navigationIndexProvider.notifier).state = 1;
                  },
                ),
              ),

              // 快捷记账按钮
              Container(
                width: 72,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: InkWell(
                    onTap: onAddTransaction,
                    customBorder: const CircleBorder(),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppConstants.primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppConstants.primaryColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 导航按钮组件
class _NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? AppConstants.primaryColor
        : AppConstants.textSecondaryColor;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
