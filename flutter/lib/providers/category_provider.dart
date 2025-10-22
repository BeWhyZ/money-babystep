import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category.dart';
import '../services/database_service.dart';

/// 分类数据提供者
final categoryProvider = FutureProvider<List<Category>>((ref) async {
  final dbService = DatabaseService();
  return await dbService.getAllCategories();
});

/// 支出分类提供者
final expenseCategoriesProvider = FutureProvider<List<Category>>((ref) async {
  final dbService = DatabaseService();
  return await dbService.getCategoriesByType(0);
});

/// 收入分类提供者
final incomeCategoriesProvider = FutureProvider<List<Category>>((ref) async {
  final dbService = DatabaseService();
  return await dbService.getCategoriesByType(1);
});
