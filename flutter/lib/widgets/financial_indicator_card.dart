import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// 财务指标卡片组件
class FinancialIndicatorCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color? valueColor;
  final bool isHealthy;

  const FinancialIndicatorCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.valueColor,
    this.isHealthy = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppConstants.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题行
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20, color: AppConstants.textSecondaryColor),
                const SizedBox(width: 8),
              ],
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: AppConstants.textSecondaryColor,
                ),
              ),
              const Spacer(),
              // 健康状态指示器
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isHealthy ? Colors.green : Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 数值
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: valueColor ?? AppConstants.textPrimaryColor,
            ),
          ),

          // 副标题
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 12,
                color: AppConstants.textSecondaryColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
