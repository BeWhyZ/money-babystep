/// 资产模型
class Asset {
  final int? id;
  final String name; // 资产名称（如：现金、银行卡、支付宝等）
  final double balance; // 余额
  final int type; // 0: 资产, 1: 负债
  final String? note; // 备注
  final DateTime createdAt;
  final DateTime? updatedAt;

  Asset({
    this.id,
    required this.name,
    required this.balance,
    required this.type,
    this.note,
    required this.createdAt,
    this.updatedAt,
  });

  /// 从数据库映射创建
  factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      id: map['id'] as int?,
      name: map['name'] as String,
      balance: map['balance'] as double,
      type: map['type'] as int,
      note: map['note'] as String?,
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
      'name': name,
      'balance': balance,
      'type': type,
      'note': note,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  /// 是否为资产
  bool get isAsset => type == 0;

  /// 是否为负债
  bool get isLiability => type == 1;

  /// 复制并更新部分字段
  Asset copyWith({
    int? id,
    String? name,
    double? balance,
    int? type,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Asset(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      type: type ?? this.type,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Asset{id: $id, name: $name, balance: $balance, type: $type}';
  }
}
