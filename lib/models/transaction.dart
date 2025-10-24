/// 交易记录模型
class Transaction {
  final int? id;
  final double amount; // 金额
  final int type; // 0: 支出, 1: 收入
  final int primaryCategoryId; // 一级分类ID
  final int? secondaryCategoryId; // 二级分类ID（可选）
  final String? note; // 备注
  final DateTime transactionDate; // 交易日期
  final DateTime createdAt; // 创建时间
  final DateTime? updatedAt; // 更新时间

  Transaction({
    this.id,
    required this.amount,
    required this.type,
    required this.primaryCategoryId,
    this.secondaryCategoryId,
    this.note,
    required this.transactionDate,
    required this.createdAt,
    this.updatedAt,
  });

  /// 从数据库映射创建
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as int?,
      amount: map['amount'] as double,
      type: map['type'] as int,
      primaryCategoryId: map['primary_category_id'] as int,
      secondaryCategoryId: map['secondary_category_id'] as int?,
      note: map['note'] as String?,
      transactionDate: DateTime.parse(map['transaction_date'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }

  /// 转换为数据库映射
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'amount': amount,
      'type': type,
      'primary_category_id': primaryCategoryId,
      'secondary_category_id': secondaryCategoryId,
      'note': note,
      'transaction_date': transactionDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  /// 是否为支出
  bool get isExpense => type == 0;

  /// 是否为收入
  bool get isIncome => type == 1;

  /// 复制并更新部分字段
  Transaction copyWith({
    int? id,
    double? amount,
    int? type,
    int? primaryCategoryId,
    int? secondaryCategoryId,
    String? note,
    DateTime? transactionDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      primaryCategoryId: primaryCategoryId ?? this.primaryCategoryId,
      secondaryCategoryId: secondaryCategoryId ?? this.secondaryCategoryId,
      note: note ?? this.note,
      transactionDate: transactionDate ?? this.transactionDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Transaction{id: $id, amount: $amount, type: $type, date: $transactionDate}';
  }
}
