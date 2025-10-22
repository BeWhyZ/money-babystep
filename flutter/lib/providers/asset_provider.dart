import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/asset.dart';
import '../models/financial_indicators.dart';
import '../services/database_service.dart';
import 'transaction_provider.dart';

/// 资产列表提供者
class AssetNotifier extends StateNotifier<AsyncValue<List<Asset>>> {
  AssetNotifier() : super(const AsyncValue.loading()) {
    loadAssets();
  }

  final _dbService = DatabaseService();

  /// 加载所有资产
  Future<void> loadAssets() async {
    state = const AsyncValue.loading();
    try {
      final assets = await _dbService.getAllAssets();
      state = AsyncValue.data(assets);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 添加资产
  Future<void> addAsset(Asset asset) async {
    try {
      await _dbService.insertAsset(asset);
      await loadAssets();
    } catch (e) {
      // TODO: 错误处理
      rethrow;
    }
  }

  /// 更新资产
  Future<void> updateAsset(Asset asset) async {
    try {
      await _dbService.updateAsset(asset);
      await loadAssets();
    } catch (e) {
      // TODO: 错误处理
      rethrow;
    }
  }

  /// 删除资产
  Future<void> deleteAsset(int id) async {
    try {
      await _dbService.deleteAsset(id);
      await loadAssets();
    } catch (e) {
      // TODO: 错误处理
      rethrow;
    }
  }
}

/// 资产提供者
final assetProvider =
    StateNotifierProvider<AssetNotifier, AsyncValue<List<Asset>>>((ref) {
      return AssetNotifier();
    });

/// 总资产提供者
final totalAssetsProvider = Provider<double>((ref) {
  final assetsAsync = ref.watch(assetProvider);
  return assetsAsync.when(
    data: (assets) {
      return assets
          .where((a) => a.isAsset)
          .fold(0.0, (sum, a) => sum + a.balance);
    },
    loading: () => 0.0,
    error: (_, __) => 0.0,
  );
});

/// 总负债提供者
final totalLiabilitiesProvider = Provider<double>((ref) {
  final assetsAsync = ref.watch(assetProvider);
  return assetsAsync.when(
    data: (assets) {
      return assets
          .where((a) => a.isLiability)
          .fold(0.0, (sum, a) => sum + a.balance);
    },
    loading: () => 0.0,
    error: (_, __) => 0.0,
  );
});

/// 净资产提供者
final netAssetsProvider = Provider<double>((ref) {
  final totalAssets = ref.watch(totalAssetsProvider);
  final totalLiabilities = ref.watch(totalLiabilitiesProvider);
  return totalAssets - totalLiabilities;
});

/// 财务指标提供者
final financialIndicatorsProvider = Provider<FinancialIndicators>((ref) {
  final totalAssets = ref.watch(totalAssetsProvider);
  final totalLiabilities = ref.watch(totalLiabilitiesProvider);
  final monthlyIncome = ref.watch(monthlyIncomeProvider);
  final monthlyExpense = ref.watch(monthlyExpenseProvider);

  // TODO: 实现更完整的指标计算逻辑
  return FinancialIndicators.calculate(
    totalAssets: totalAssets,
    totalLiabilities: totalLiabilities,
    monthlyIncome: monthlyIncome,
    monthlyExpense: monthlyExpense,
    previousNetAssets: 0, // TODO: 从历史数据获取
    emergencyReserve: 0, // TODO: 从资产中计算
    monthlyFixedExpense: monthlyExpense, // TODO: 区分固定和可变支出
  );
});
