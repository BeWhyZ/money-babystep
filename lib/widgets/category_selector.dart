import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// 分类选择器组件
class CategorySelector extends StatefulWidget {
  final bool isExpense;
  final int? selectedPrimaryCategoryId;
  final int? selectedSecondaryCategoryId;
  final Function(int primaryId, int? secondaryId) onCategorySelected;

  const CategorySelector({
    super.key,
    required this.isExpense,
    this.selectedPrimaryCategoryId,
    this.selectedSecondaryCategoryId,
    required this.onCategorySelected,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int? _selectedPrimaryId;
  // ignore: unused_field
  int? _selectedSecondaryId;

  @override
  void initState() {
    super.initState();
    _selectedPrimaryId = widget.selectedPrimaryCategoryId;
    _selectedSecondaryId = widget.selectedSecondaryCategoryId;
  }

  List<CategoryInfo> get _categories {
    return widget.isExpense
        ? AppConstants.expenseCategories
        : AppConstants.incomeCategories;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 一级分类标题
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            '选择分类',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppConstants.textPrimaryColor,
            ),
          ),
        ),

        // 一级分类网格
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            final isSelected = _selectedPrimaryId == category.id;

            return _CategoryItem(
              icon: category.icon,
              label: category.name,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  _selectedPrimaryId = category.id;
                  _selectedSecondaryId = null; // 重置二级分类
                });
                widget.onCategorySelected(category.id, null);
              },
            );
          },
        ),

        // TODO: 二级分类选择（可选）
        // 当选中一级分类后，显示该分类下的二级分类
        if (_selectedPrimaryId != null) ...[
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '二级分类（可选）',
              style: TextStyle(
                fontSize: 14,
                color: AppConstants.textSecondaryColor,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // TODO: 显示二级分类列表
        ],
      ],
    );
  }
}

/// 分类项组件
class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? AppConstants.primaryColor.withOpacity(0.1)
              : AppConstants.cardBackgroundColor,
          border: Border.all(
            color: isSelected
                ? AppConstants.primaryColor
                : AppConstants.dividerColor,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected
                  ? AppConstants.primaryColor
                  : AppConstants.textSecondaryColor,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? AppConstants.primaryColor
                    : AppConstants.textPrimaryColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
