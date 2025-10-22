/// 分类模型
class Category {
  final int id;
  final String name;
  final int? parentId; // null表示一级分类，非null表示二级分类
  final String? iconName;
  final int type; // 0: 支出, 1: 收入

  Category({
    required this.id,
    required this.name,
    this.parentId,
    this.iconName,
    required this.type,
  });

  /// 从数据库映射创建
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      name: map['name'] as String,
      parentId: map['parent_id'] as int?,
      iconName: map['icon_name'] as String?,
      type: map['type'] as int,
    );
  }

  /// 转换为数据库映射
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'parent_id': parentId,
      'icon_name': iconName,
      'type': type,
    };
  }

  /// 是否为一级分类
  bool get isPrimary => parentId == null;

  /// 是否为支出分类
  bool get isExpense => type == 0;

  /// 是否为收入分类
  bool get isIncome => type == 1;

  @override
  String toString() {
    return 'Category{id: $id, name: $name, parentId: $parentId, type: $type}';
  }
}
