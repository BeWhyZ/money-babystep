import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transaction.dart';
import '../services/database_service.dart';

/// 交易记录列表提供者
class TransactionNotifier extends StateNotifier<AsyncValue<List<Transaction>>> {
  TransactionNotifier() : super(const AsyncValue.loading()) {
    loadTransactions();
  }

  final _dbService = DatabaseService();

  /// 加载所有交易记录
  Future<void> loadTransactions() async {
    state = const AsyncValue.loading();
    try {
      final transactions = await _dbService.getAllTransactions();
      state = AsyncValue.data(List<Transaction>.from(transactions));
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 添加交易记录
  Future<void> addTransaction(Transaction transaction) async {
    try {
      await _dbService.insertTransaction(transaction);
      await loadTransactions();
    } catch (e) {
      // TODO: 错误处理
      rethrow;
    }
  }

  /// 更新交易记录
  Future<void> updateTransaction(Transaction transaction) async {
    try {
      await _dbService.updateTransaction(transaction);
      await loadTransactions();
    } catch (e) {
      // TODO: 错误处理
      rethrow;
    }
  }

  /// 删除交易记录
  Future<void> deleteTransaction(int id) async {
    try {
      await _dbService.deleteTransaction(id);
      await loadTransactions();
    } catch (e) {
      // TODO: 错误处理
      rethrow;
    }
  }

  /// 根据日期范围加载交易记录
  Future<void> loadTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    state = const AsyncValue.loading();
    try {
      final transactions = await _dbService.getTransactionsByDateRange(
        startDate,
        endDate,
      );
      state = AsyncValue.data(List<Transaction>.from(transactions));
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

/// 交易记录提供者
final transactionProvider =
    StateNotifierProvider<TransactionNotifier, AsyncValue<List<Transaction>>>((
      ref,
    ) {
      return TransactionNotifier();
    });

/// 月度收入统计提供者
final monthlyIncomeProvider = Provider<double>((ref) {
  final transactionsAsync = ref.watch(transactionProvider);
  return transactionsAsync.when(
    data: (transactions) {
      final now = DateTime.now();
      final startOfMonth = DateTime(now.year, now.month, 1);
      final endOfMonth = DateTime(now.year, now.month + 1, 0);

      return transactions
          .where(
            (t) =>
                t.isIncome &&
                t.transactionDate.isAfter(startOfMonth) &&
                t.transactionDate.isBefore(endOfMonth),
          )
          .fold(0.0, (sum, t) => sum + t.amount);
    },
    loading: () => 0.0,
    error: (_, __) => 0.0,
  );
});

/// 月度支出统计提供者
final monthlyExpenseProvider = Provider<double>((ref) {
  final transactionsAsync = ref.watch(transactionProvider);
  return transactionsAsync.when(
    data: (transactions) {
      final now = DateTime.now();
      final startOfMonth = DateTime(now.year, now.month, 1);
      final endOfMonth = DateTime(now.year, now.month + 1, 0);

      return transactions
          .where(
            (t) =>
                t.isExpense &&
                t.transactionDate.isAfter(startOfMonth) &&
                t.transactionDate.isBefore(endOfMonth),
          )
          .fold(0.0, (sum, t) => sum + t.amount);
    },
    loading: () => 0.0,
    error: (_, __) => 0.0,
  );
});

/// 月度结余提供者
final monthlyBalanceProvider = Provider<double>((ref) {
  final income = ref.watch(monthlyIncomeProvider);
  final expense = ref.watch(monthlyExpenseProvider);
  return income - expense;
});
