import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transaction.dart' as model;
import '../models/category.dart';
import '../models/asset.dart';

/// 数据库服务
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _database;

  /// 获取数据库实例
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// 初始化数据库
  Future<Database> _initDatabase() async {
    // TODO: 实现数据库初始化逻辑
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'money_babystep.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// 创建数据库表
  Future<void> _onCreate(Database db, int version) async {
    // TODO: 实现表创建逻辑

    // 创建交易记录表
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount REAL NOT NULL,
        type INTEGER NOT NULL,
        primary_category_id INTEGER NOT NULL,
        secondary_category_id INTEGER,
        note TEXT,
        transaction_date TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT
      )
    ''');

    // 创建分类表
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        parent_id INTEGER,
        icon_name TEXT,
        type INTEGER NOT NULL,
        FOREIGN KEY (parent_id) REFERENCES categories (id)
      )
    ''');

    // 创建资产表
    await db.execute('''
      CREATE TABLE assets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        balance REAL NOT NULL,
        type INTEGER NOT NULL,
        note TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT
      )
    ''');

    // 创建索引
    await db.execute(
      'CREATE INDEX idx_transactions_date ON transactions(transaction_date)',
    );
    await db.execute('CREATE INDEX idx_categories_type ON categories(type)');
    await db.execute('CREATE INDEX idx_assets_type ON assets(type)');
  }

  /// 数据库升级
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // TODO: 实现数据库升级逻辑
  }

  // ==================== 交易记录相关操作 ====================

  /// 插入交易记录
  Future<int> insertTransaction(model.Transaction transaction) async {
    // TODO: 实现插入逻辑
    final db = await database;
    return await db.insert('transactions', transaction.toMap());
  }

  /// 更新交易记录
  Future<int> updateTransaction(model.Transaction transaction) async {
    // TODO: 实现更新逻辑
    final db = await database;
    return await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  /// 删除交易记录
  Future<int> deleteTransaction(int id) async {
    // TODO: 实现删除逻辑
    final db = await database;
    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  /// 获取所有交易记录
  Future<List<model.Transaction>> getAllTransactions() async {
    // TODO: 实现查询逻辑
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'transactions',
      orderBy: 'transaction_date DESC',
    );
    return List.generate(
      maps.length,
      (i) => model.Transaction.fromMap(maps[i]),
    );
  }

  /// 根据日期范围获取交易记录
  Future<List<model.Transaction>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    // TODO: 实现查询逻辑
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'transactions',
      where: 'transaction_date BETWEEN ? AND ?',
      whereArgs: [startDate.toIso8601String(), endDate.toIso8601String()],
      orderBy: 'transaction_date DESC',
    );
    return List.generate(
      maps.length,
      (i) => model.Transaction.fromMap(maps[i]),
    );
  }

  // ==================== 分类相关操作 ====================

  /// 插入分类
  Future<int> insertCategory(Category category) async {
    // TODO: 实现插入逻辑
    final db = await database;
    return await db.insert('categories', category.toMap());
  }

  /// 获取所有分类
  Future<List<Category>> getAllCategories() async {
    // TODO: 实现查询逻辑
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('categories');
    return List.generate(maps.length, (i) => Category.fromMap(maps[i]));
  }

  /// 根据类型获取分类
  Future<List<Category>> getCategoriesByType(int type) async {
    // TODO: 实现查询逻辑
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'categories',
      where: 'type = ?',
      whereArgs: [type],
    );
    return List.generate(maps.length, (i) => Category.fromMap(maps[i]));
  }

  // ==================== 资产相关操作 ====================

  /// 插入资产
  Future<int> insertAsset(Asset asset) async {
    // TODO: 实现插入逻辑
    final db = await database;
    return await db.insert('assets', asset.toMap());
  }

  /// 更新资产
  Future<int> updateAsset(Asset asset) async {
    // TODO: 实现更新逻辑
    final db = await database;
    return await db.update(
      'assets',
      asset.toMap(),
      where: 'id = ?',
      whereArgs: [asset.id],
    );
  }

  /// 删除资产
  Future<int> deleteAsset(int id) async {
    // TODO: 实现删除逻辑
    final db = await database;
    return await db.delete('assets', where: 'id = ?', whereArgs: [id]);
  }

  /// 获取所有资产
  Future<List<Asset>> getAllAssets() async {
    // TODO: 实现查询逻辑
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('assets');
    return List.generate(maps.length, (i) => Asset.fromMap(maps[i]));
  }

  /// 根据类型获取资产
  Future<List<Asset>> getAssetsByType(int type) async {
    // TODO: 实现查询逻辑
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'assets',
      where: 'type = ?',
      whereArgs: [type],
    );
    return List.generate(maps.length, (i) => Asset.fromMap(maps[i]));
  }

  /// 关闭数据库
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
