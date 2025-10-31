import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transaction.dart';
import '../src/bindings/signals/signals.dart';
import 'bill_provider.dart';

/// 将 Bill (Rust) 转换为 Transaction (UI 模型)
Transaction _billToTransaction(Bill bill) {
  return Transaction(
    id: bill.id.toInt(),
    amount: bill.amount,
    type: 0, // TODO: 根据 tagIdLv1 判断是支出(0)还是收入(1)
    primaryCategoryId: bill.tagIdLv1.toInt(),
    secondaryCategoryId: bill.tagIdLv2.toInt(),
    note: null, // Bill 暂时没有 note 字段
    transactionDate: DateTime.fromMillisecondsSinceEpoch(
      bill.createAtSec.toInt() * 1000,
    ),
    createdAt: DateTime.fromMillisecondsSinceEpoch(
      bill.createAtSec.toInt() * 1000,
    ),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(
      bill.updateAtSec.toInt() * 1000,
    ),
  );
}

/// 交易记录提供者（基于新的 billListProvider）
final transactionProvider = Provider<AsyncValue<List<Transaction>>>((ref) {
  final billsAsync = ref.watch(billListProvider);

  return billsAsync.when(
    data: (bills) {
      // 将 Bill 列表转换为 Transaction 列表
      final transactions = bills
          .map((bill) => _billToTransaction(bill))
          .toList();

      // 按日期倒序排列（最新的在前面）
      transactions.sort(
        (a, b) => b.transactionDate.compareTo(a.transactionDate),
      );

      return AsyncValue.data(transactions);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
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
