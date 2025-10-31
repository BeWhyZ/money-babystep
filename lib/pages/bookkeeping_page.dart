import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../constants/app_constants.dart';
import '../constants/app_strings.dart';
import '../models/transaction.dart';
import '../providers/transaction_provider.dart';
import '../providers/locale_provider.dart';

/// 记账页面
class BookkeepingPage extends ConsumerWidget {
  const BookkeepingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(localeProvider);
    final monthlyIncome = ref.watch(monthlyIncomeProvider);
    final monthlyExpense = ref.watch(monthlyExpenseProvider);
    final monthlyBalance = ref.watch(monthlyBalanceProvider);
    final transactionsAsync = ref.watch(transactionProvider);

    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      body: Column(
        children: [
          // 收支总览卡片
          _SummaryCard(
            income: monthlyIncome,
            expense: monthlyExpense,
            balance: monthlyBalance,
          ),

          const SizedBox(height: 8),

          // 交易明细列表
          Expanded(
            child: transactionsAsync.when(
              data: (transactions) {
                if (transactions.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 64,
                          color: AppConstants.textSecondaryColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppStrings.bookkeepingNoData.tr(language),
                          style: TextStyle(
                            fontSize: 16,
                            color: AppConstants.textSecondaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppStrings.bookkeepingNoDataHint.tr(language),
                          style: TextStyle(
                            fontSize: 14,
                            color: AppConstants.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return _TransactionList(transactions: transactions);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Consumer(
                  builder: (context, ref, _) {
                    final language = ref.watch(localeProvider);
                    return Text(
                      '${AppStrings.commonError.tr(language)}: $error',
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 收支总览卡片
class _SummaryCard extends ConsumerWidget {
  final double income;
  final double expense;
  final double balance;

  const _SummaryCard({
    required this.income,
    required this.expense,
    required this.balance,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(localeProvider);
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppConstants.cardBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // 月份标题
          Text(
            DateFormat('yyyy年MM月').format(DateTime.now()),
            style: TextStyle(
              fontSize: 14,
              color: AppConstants.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 16),

          // 结余
          Column(
            children: [
              Text(
                AppStrings.bookkeepingBalance.tr(language),
                style: TextStyle(
                  fontSize: 14,
                  color: AppConstants.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '¥${balance.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: balance >= 0
                      ? AppConstants.primaryColor
                      : AppConstants.incomeColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // 收入和支出
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      AppStrings.bookkeepingIncome.tr(language),
                      style: TextStyle(
                        fontSize: 14,
                        color: AppConstants.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '¥${income.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppConstants.incomeColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: 1, height: 40, color: AppConstants.dividerColor),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      AppStrings.bookkeepingExpense.tr(language),
                      style: TextStyle(
                        fontSize: 14,
                        color: AppConstants.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '¥${expense.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppConstants.expenseColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 交易明细列表
class _TransactionList extends ConsumerWidget {
  final List<Transaction> transactions;

  const _TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(localeProvider);
    // 按日期分组
    final groupedTransactions = <String, List<Transaction>>{};
    for (var transaction in transactions) {
      final dateKey = DateFormat(
        'yyyy-MM-dd',
      ).format(transaction.transactionDate);
      groupedTransactions.putIfAbsent(dateKey, () => []).add(transaction);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: groupedTransactions.length,
      itemBuilder: (context, index) {
        final dateKey = groupedTransactions.keys.elementAt(index);
        final dateTransactions = groupedTransactions[dateKey]!;
        final date = DateTime.parse(dateKey);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 日期标题
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                _formatDate(date, language),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.textSecondaryColor,
                ),
              ),
            ),

            // 当天的交易记录
            ...dateTransactions.map(
              (transaction) => _TransactionItem(transaction: transaction),
            ),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime date, Language language) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final transactionDate = DateTime(date.year, date.month, date.day);

    if (transactionDate == today) {
      return AppStrings.bookkeepingToday.tr(language);
    } else if (transactionDate == yesterday) {
      return AppStrings.bookkeepingYesterday.tr(language);
    } else {
      return DateFormat('MM月dd日 EEEE', 'zh_CN').format(date);
    }
  }
}

/// 交易记录项
class _TransactionItem extends StatelessWidget {
  final Transaction transaction;

  const _TransactionItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppConstants.cardBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // 分类图标
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: transaction.isExpense
                  ? AppConstants.expenseColor.withOpacity(0.1)
                  : AppConstants.incomeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              transaction.isExpense ? Icons.remove : Icons.add,
              color: transaction.isExpense
                  ? AppConstants.expenseColor
                  : AppConstants.incomeColor,
            ),
          ),

          const SizedBox(width: 12),

          // 分类名称和备注
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '分类 ${transaction.primaryCategoryId}', // TODO: 显示实际分类名称
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppConstants.textPrimaryColor,
                  ),
                ),
                if (transaction.note != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    transaction.note!,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppConstants.textSecondaryColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),

          // 金额
          Text(
            '${transaction.isExpense ? '-' : '+'}¥${transaction.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: transaction.isExpense
                  ? AppConstants.expenseColor
                  : AppConstants.incomeColor,
            ),
          ),
        ],
      ),
    );
  }
}
