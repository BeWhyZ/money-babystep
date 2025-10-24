import 'package:flutter/material.dart';

/// 应用常量定义
class AppConstants {
  // 应用名称
  static const String appName = '记账';

  // 颜色主题 - 类微信风格
  static const Color primaryColor = Color(0xFF07C160); // 微信绿
  static const Color backgroundColor = Color(0xFFEDEDED);
  static const Color cardBackgroundColor = Colors.white;
  static const Color textPrimaryColor = Color(0xFF191919);
  static const Color textSecondaryColor = Color(0xFF888888);
  static const Color dividerColor = Color(0xFFE5E5E5);
  static const Color incomeColor = Color(0xFFFF6B6B);
  static const Color expenseColor = Color(0xFF07C160);

  // 一级分类定义（支出）
  static const List<CategoryInfo> expenseCategories = [
    CategoryInfo(id: 1, name: '餐饮', icon: Icons.restaurant),
    CategoryInfo(id: 2, name: '购物', icon: Icons.shopping_bag),
    CategoryInfo(id: 3, name: '交通', icon: Icons.directions_bus),
    CategoryInfo(id: 4, name: '通讯', icon: Icons.phone_android),
    CategoryInfo(id: 5, name: '医疗', icon: Icons.local_hospital),
    CategoryInfo(id: 6, name: '居家', icon: Icons.home),
    CategoryInfo(id: 7, name: '养老保险', icon: Icons.shield),
    CategoryInfo(id: 8, name: '宠物', icon: Icons.pets),
    CategoryInfo(id: 9, name: '娱乐', icon: Icons.sports_esports),
  ];

  // 一级分类定义（收入）
  static const List<CategoryInfo> incomeCategories = [
    CategoryInfo(id: 101, name: '工资', icon: Icons.work),
    CategoryInfo(id: 102, name: '奖金', icon: Icons.card_giftcard),
    CategoryInfo(id: 103, name: '投资收益', icon: Icons.trending_up),
    CategoryInfo(id: 104, name: '其他', icon: Icons.money),
  ];
}

/// 分类信息
class CategoryInfo {
  final int id;
  final String name;
  final IconData icon;

  const CategoryInfo({
    required this.id,
    required this.name,
    required this.icon,
  });
}

/// 交易类型枚举
enum TransactionType {
  expense, // 支出
  income, // 收入
}
