import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../providers/asset_provider.dart';
import '../widgets/financial_indicator_card.dart';

/// 资产页面
class AssetPage extends ConsumerWidget {
  const AssetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indicators = ref.watch(financialIndicatorsProvider);
    final totalAssets = ref.watch(totalAssetsProvider);
    final totalLiabilities = ref.watch(totalLiabilitiesProvider);
    final netAssets = ref.watch(netAssetsProvider);

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 净资产总览
            _NetAssetCard(netAssets: netAssets),

            const SizedBox(height: 24),

            // 财务指标标题
            Text(
              '财务指标',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppConstants.textPrimaryColor,
              ),
            ),

            const SizedBox(height: 12),

            // 总资产和总负债
            Row(
              children: [
                Expanded(
                  child: FinancialIndicatorCard(
                    title: '总资产',
                    value: '¥${totalAssets.toStringAsFixed(2)}',
                    icon: Icons.account_balance_wallet,
                    valueColor: AppConstants.primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FinancialIndicatorCard(
                    title: '总负债',
                    value: '¥${totalLiabilities.toStringAsFixed(2)}',
                    icon: Icons.credit_card,
                    valueColor: AppConstants.incomeColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 储蓄率
            FinancialIndicatorCard(
              title: '储蓄率',
              value: '${(indicators.savingsRate * 100).toStringAsFixed(1)}%',
              subtitle: '建议目标: ≥20%',
              icon: Icons.savings,
              valueColor: AppConstants.primaryColor,
              isHealthy: indicators.isSavingsRateHealthy,
            ),

            const SizedBox(height: 12),

            // 负债率
            FinancialIndicatorCard(
              title: '负债率',
              value: '${(indicators.debtRatio * 100).toStringAsFixed(1)}%',
              subtitle: '建议目标: <50%',
              icon: Icons.trending_down,
              valueColor: indicators.isDebtRatioHealthy
                  ? AppConstants.primaryColor
                  : AppConstants.incomeColor,
              isHealthy: indicators.isDebtRatioHealthy,
            ),

            const SizedBox(height: 12),

            // 净资产增长率
            FinancialIndicatorCard(
              title: '净资产增长率',
              value:
                  '${(indicators.netAssetsGrowthRate * 100).toStringAsFixed(1)}%',
              subtitle: '相比上月',
              icon: Icons.trending_up,
              valueColor: indicators.netAssetsGrowthRate >= 0
                  ? AppConstants.primaryColor
                  : AppConstants.incomeColor,
            ),

            const SizedBox(height: 12),

            // 自由现金流
            FinancialIndicatorCard(
              title: '自由现金流',
              value: '¥${indicators.freeCashFlow.toStringAsFixed(2)}',
              subtitle: '可用于投资和应急储备',
              icon: Icons.waterfall_chart,
              valueColor: indicators.freeCashFlow >= 0
                  ? AppConstants.primaryColor
                  : AppConstants.incomeColor,
            ),

            const SizedBox(height: 12),

            // 应急储备月数
            FinancialIndicatorCard(
              title: '应急储备充足度',
              value:
                  '${indicators.emergencyReserveMonths.toStringAsFixed(1)}个月',
              subtitle: '建议目标: 3-6个月',
              icon: Icons.emergency,
              valueColor: AppConstants.primaryColor,
              isHealthy: indicators.isEmergencyReserveSufficient,
            ),

            const SizedBox(height: 24),

            // 财务健康建议
            _FinancialAdviceCard(indicators: indicators),
          ],
        ),
      ),
    );
  }
}

/// 净资产总览卡片
class _NetAssetCard extends StatelessWidget {
  final double netAssets;

  const _NetAssetCard({required this.netAssets});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppConstants.primaryColor,
            AppConstants.primaryColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppConstants.primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.account_balance, color: Colors.white, size: 24),
              const SizedBox(width: 8),
              const Text(
                '净资产',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '¥${netAssets.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '总资产 - 总负债',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

/// 财务健康建议卡片
class _FinancialAdviceCard extends StatelessWidget {
  final indicators;

  const _FinancialAdviceCard({required this.indicators});

  @override
  Widget build(BuildContext context) {
    final List<String> advices = [];

    if (!indicators.isSavingsRateHealthy) {
      advices.add('💡 储蓄率偏低，建议控制开支，提高储蓄比例');
    }

    if (!indicators.isDebtRatioHealthy) {
      advices.add('⚠️ 负债率偏高，建议优先偿还债务');
    }

    if (!indicators.isEmergencyReserveSufficient) {
      advices.add('🛡️ 应急储备不足，建议储备3-6个月的固定开支');
    }

    if (advices.isEmpty) {
      advices.add('✅ 财务状况良好，继续保持！');
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppConstants.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppConstants.primaryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                size: 20,
                color: AppConstants.primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                '财务建议',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.textPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...advices.map(
            (advice) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                advice,
                style: TextStyle(
                  fontSize: 14,
                  color: AppConstants.textPrimaryColor,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
