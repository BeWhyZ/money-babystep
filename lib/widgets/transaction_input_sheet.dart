import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../constants/app_constants.dart';
import '../providers/bill_provider.dart';
import 'category_selector.dart';

/// 记账输入底部弹窗
class TransactionInputSheet extends ConsumerStatefulWidget {
  const TransactionInputSheet({super.key});

  @override
  ConsumerState<TransactionInputSheet> createState() =>
      _TransactionInputSheetState();
}

class _TransactionInputSheetState extends ConsumerState<TransactionInputSheet> {
  TransactionType _type = TransactionType.expense;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  int? _selectedPrimaryCategoryId;
  int? _selectedSecondaryCategoryId;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  bool get _canSubmit {
    return _amountController.text.isNotEmpty &&
        double.tryParse(_amountController.text) != null &&
        _selectedPrimaryCategoryId != null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _submit() async {
    if (!_canSubmit) return;

    final amount = double.parse(_amountController.text);

    // 使用 Rust API 创建账单
    // TODO: 从用户会话中获取实际的 userId 和 bookId
    ref
        .read(createBillProvider.notifier)
        .createBill(
          userId: 1, // 临时硬编码
          bookId: 1, // 临时硬编码
          amount: amount,
          tagIdLv1: _selectedPrimaryCategoryId!,
          tagIdLv2: _selectedSecondaryCategoryId ?? _selectedPrimaryCategoryId!,
        );
  }

  @override
  Widget build(BuildContext context) {
    // 监听创建账单的状态变化
    ref.listen<CreateBillState>(createBillProvider, (previous, next) {
      if (next.status == CreateBillStatus.success) {
        // 成功后关闭弹窗并显示提示
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('记账成功'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      } else if (next.status == CreateBillStatus.error) {
        // 显示错误提示
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('记账失败: ${next.errorMessage}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    final createBillState = ref.watch(createBillProvider);
    final isSubmitting = createBillState.status == CreateBillStatus.loading;

    return Container(
      decoration: BoxDecoration(
        color: AppConstants.backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 顶部拖拽条
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppConstants.dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // 支出/收入切换
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _TypeButton(
                      label: '支出',
                      isSelected: _type == TransactionType.expense,
                      color: AppConstants.expenseColor,
                      onTap: () {
                        setState(() {
                          _type = TransactionType.expense;
                          _selectedPrimaryCategoryId = null;
                          _selectedSecondaryCategoryId = null;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _TypeButton(
                      label: '收入',
                      isSelected: _type == TransactionType.income,
                      color: AppConstants.incomeColor,
                      onTap: () {
                        setState(() {
                          _type = TransactionType.income;
                          _selectedPrimaryCategoryId = null;
                          _selectedSecondaryCategoryId = null;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 金额输入
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppConstants.cardBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text(
                    '¥',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}'),
                        ),
                      ],
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.textPrimaryColor,
                      ),
                      decoration: const InputDecoration(
                        hintText: '0.00',
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 分类选择
            CategorySelector(
              isExpense: _type == TransactionType.expense,
              selectedPrimaryCategoryId: _selectedPrimaryCategoryId,
              selectedSecondaryCategoryId: _selectedSecondaryCategoryId,
              onCategorySelected: (primaryId, secondaryId) {
                setState(() {
                  _selectedPrimaryCategoryId = primaryId;
                  _selectedSecondaryCategoryId = secondaryId;
                });
              },
            ),

            const SizedBox(height: 16),

            // 日期和备注
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // 日期选择
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppConstants.cardBackgroundColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 20,
                            color: AppConstants.textSecondaryColor,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            DateFormat('yyyy年MM月dd日').format(_selectedDate),
                            style: TextStyle(
                              fontSize: 14,
                              color: AppConstants.textPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 备注输入
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppConstants.cardBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _noteController,
                      decoration: InputDecoration(
                        hintText: '添加备注（可选）',
                        hintStyle: TextStyle(
                          color: AppConstants.textSecondaryColor,
                        ),
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.edit_note,
                          color: AppConstants.textSecondaryColor,
                        ),
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 提交按钮
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: (_canSubmit && !isSubmitting) ? _submit : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryColor,
                    disabledBackgroundColor: AppConstants.dividerColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          '完成',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// 类型按钮组件
class _TypeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _TypeButton({
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? color : AppConstants.cardBackgroundColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? color : AppConstants.dividerColor,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppConstants.textPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
