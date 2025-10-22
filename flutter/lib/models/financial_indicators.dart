/// 财务指标模型
class FinancialIndicators {
  final double totalAssets; // 总资产
  final double totalLiabilities; // 总负债
  final double netAssets; // 净资产 = 总资产 - 总负债
  final double monthlyIncome; // 月收入
  final double monthlyExpense; // 月支出
  final double monthlySavings; // 月储蓄 = 月收入 - 月支出
  final double savingsRate; // 储蓄率 = 月储蓄 / 月收入
  final double debtRatio; // 负债率 = 总负债 / 总资产
  final double netAssetsGrowthRate; // 净资产增长率
  final double freeCashFlow; // 自由现金流 = 月收入 - 月支出
  final double emergencyReserveMonths; // 应急储备月数

  FinancialIndicators({
    required this.totalAssets,
    required this.totalLiabilities,
    required this.monthlyIncome,
    required this.monthlyExpense,
    required this.netAssetsGrowthRate,
    required this.emergencyReserveMonths,
  }) : netAssets = totalAssets - totalLiabilities,
       monthlySavings = monthlyIncome - monthlyExpense,
       savingsRate = monthlyIncome > 0
           ? (monthlyIncome - monthlyExpense) / monthlyIncome
           : 0,
       debtRatio = totalAssets > 0 ? totalLiabilities / totalAssets : 0,
       freeCashFlow = monthlyIncome - monthlyExpense;

  /// 创建空指标
  factory FinancialIndicators.empty() {
    return FinancialIndicators(
      totalAssets: 0,
      totalLiabilities: 0,
      monthlyIncome: 0,
      monthlyExpense: 0,
      netAssetsGrowthRate: 0,
      emergencyReserveMonths: 0,
    );
  }

  /// 从数据计算指标（留空实现，供后续填充）
  factory FinancialIndicators.calculate({
    required double totalAssets,
    required double totalLiabilities,
    required double monthlyIncome,
    required double monthlyExpense,
    required double previousNetAssets,
    required double emergencyReserve,
    required double monthlyFixedExpense,
  }) {
    // TODO: 实现财务指标计算逻辑
    final netAssets = totalAssets - totalLiabilities;
    final netAssetsGrowthRate = previousNetAssets > 0
        ? (netAssets - previousNetAssets) / previousNetAssets
        : 0.0;
    final emergencyReserveMonths = monthlyFixedExpense > 0
        ? emergencyReserve / monthlyFixedExpense
        : 0.0;

    return FinancialIndicators(
      totalAssets: totalAssets,
      totalLiabilities: totalLiabilities,
      monthlyIncome: monthlyIncome,
      monthlyExpense: monthlyExpense,
      netAssetsGrowthRate: netAssetsGrowthRate,
      emergencyReserveMonths: emergencyReserveMonths,
    );
  }

  /// 储蓄率是否健康 (>= 20%)
  bool get isSavingsRateHealthy => savingsRate >= 0.2;

  /// 负债率是否健康 (< 50%)
  bool get isDebtRatioHealthy => debtRatio < 0.5;

  /// 应急储备是否充足 (3-6个月)
  bool get isEmergencyReserveSufficient =>
      emergencyReserveMonths >= 3 && emergencyReserveMonths <= 6;

  @override
  String toString() {
    return 'FinancialIndicators{totalAssets: $totalAssets, totalLiabilities: $totalLiabilities, savingsRate: $savingsRate}';
  }
}
