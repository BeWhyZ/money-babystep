/// 应用文本字符串 - 基于索引的多语言支持
/// 格式：(中文, 英文)
///
/// 使用方式：
/// ```dart
/// // 方式 1: 使用扩展方法（推荐）
/// Text(AppStrings.appName.tr(context))
///
/// // 方式 2: 直接使用索引
/// Text(AppStrings.get(AppStrings.appName, locale.index))
/// ```
class AppStrings {
  // ==================== 应用基础 ====================
  static const appName = ('记账', 'Bookkeeping');

  // ==================== 导航 ====================
  static const navBookkeeping = ('记账', 'Bookkeeping');
  static const navAsset = ('资产', 'Assets');
  static const navProfile = ('我的', 'Profile');

  // ==================== 记账页 ====================
  static const bookkeepingTitle = ('记账', 'Bookkeeping');
  static const bookkeepingIncome = ('收入', 'Income');
  static const bookkeepingExpense = ('支出', 'Expense');
  static const bookkeepingBalance = ('结余', 'Balance');
  static const bookkeepingNoData = ('暂无记账记录', 'No records yet');
  static const bookkeepingNoDataHint = (
    '点击右下角"+"开始记账',
    'Tap "+" to start bookkeeping',
  );
  static const bookkeepingToday = ('今天', 'Today');
  static const bookkeepingYesterday = ('昨天', 'Yesterday');

  // ==================== 资产页 ====================
  static const assetTitle = ('资产', 'Assets');
  static const assetNetAsset = ('净资产', 'Net Assets');
  static const assetFinancialIndicators = ('财务指标', 'Financial Indicators');
  static const assetTotalAssets = ('总资产', 'Total Assets');
  static const assetTotalLiabilities = ('总负债', 'Total Liabilities');
  static const assetSavingsRate = ('储蓄率', 'Savings Rate');
  static const assetSavingsRateTarget = ('建议目标: ≥20%', 'Target: ≥20%');
  static const assetDebtRatio = ('负债率', 'Debt Ratio');
  static const assetDebtRatioTarget = ('建议目标: <50%', 'Target: <50%');
  static const assetNetAssetsGrowthRate = ('净资产增长率', 'Net Assets Growth Rate');
  static const assetNetAssetsGrowthRateDesc = (
    '相比上月',
    'Compared to last month',
  );
  static const assetFreeCashFlow = ('自由现金流', 'Free Cash Flow');
  static const assetFreeCashFlowDesc = (
    '可用于投资和应急储备',
    'Available for investment and emergency',
  );
  static const assetEmergencyReserve = ('应急储备充足度', 'Emergency Reserve');
  static const assetEmergencyReserveTarget = (
    '建议目标: 3-6个月',
    'Target: 3-6 months',
  );
  static const assetFinancialAdvice = ('财务建议', 'Financial Advice');
  static const assetAdviceSavingsLow = (
    '💡 储蓄率偏低，建议控制开支，提高储蓄比例',
    '💡 Low savings rate, consider reducing expenses',
  );
  static const assetAdviceDebtHigh = (
    '⚠️ 负债率偏高，建议优先偿还债务',
    '⚠️ High debt ratio, prioritize debt repayment',
  );
  static const assetAdviceEmergencyLow = (
    '🛡️ 应急储备不足，建议储备3-6个月的固定开支',
    '🛡️ Insufficient emergency fund, save 3-6 months expenses',
  );
  static const assetAdviceHealthy = (
    '✅ 财务状况良好，继续保持！',
    '✅ Financial health is good, keep it up!',
  );

  // ==================== 交易输入 ====================
  static const transactionExpense = ('支出', 'Expense');
  static const transactionIncome = ('收入', 'Income');
  static const transactionAmount = ('金额', 'Amount');
  static const transactionCategory = ('分类', 'Category');
  static const transactionSelectCategory = ('选择分类', 'Select Category');
  static const transactionSecondaryCategory = (
    '二级分类（可选）',
    'Subcategory (Optional)',
  );
  static const transactionNote = ('备注', 'Note');
  static const transactionNotePlaceholder = ('添加备注（可选）', 'Add note (optional)');
  static const transactionComplete = ('完成', 'Complete');
  static const transactionSuccess = ('记账成功', 'Transaction added');
  static const transactionFailed = ('记账失败', 'Transaction failed');

  // ==================== 分类 ====================
  static const categoryFood = ('餐饮', 'Food');
  static const categoryShopping = ('购物', 'Shopping');
  static const categoryTransport = ('交通', 'Transport');
  static const categoryTelecom = ('通讯', 'Telecom');
  static const categoryMedical = ('医疗', 'Medical');
  static const categoryHome = ('居家', 'Home');
  static const categoryPension = ('养老保险', 'Pension');
  static const categoryPet = ('宠物', 'Pet');
  static const categoryEntertainment = ('娱乐', 'Entertainment');
  static const categorySalary = ('工资', 'Salary');
  static const categoryBonus = ('奖金', 'Bonus');
  static const categoryInvestment = ('投资收益', 'Investment');
  static const categoryOther = ('其他', 'Other');

  // ==================== 我的页面 ====================
  static const profileTitle = ('我的', 'Profile');
  static const profileUsername = ('用户名', 'Username');
  static const profileDays = ('记账 0 天', '0 days');
  static const profileDataManagement = ('数据管理', 'Data Management');
  static const profileWechatImport = ('微信账单导入', 'WeChat Import');
  static const profileWechatImportDesc = ('导入微信账单数据', 'Import WeChat bills');
  static const profileAlipayImport = ('支付宝账单导入', 'Alipay Import');
  static const profileAlipayImportDesc = ('导入支付宝账单数据', 'Import Alipay bills');
  static const profileDataBackup = ('数据备份', 'Data Backup');
  static const profileDataBackupDesc = ('备份本地数据', 'Backup local data');
  static const profileDataRestore = ('数据恢复', 'Data Restore');
  static const profileDataRestoreDesc = ('从备份恢复数据', 'Restore from backup');
  static const profileSettings = ('设置', 'Settings');
  static const profileCategoryManagement = ('分类管理', 'Category Management');
  static const profileCategoryManagementDesc = (
    '自定义收支分类',
    'Customize categories',
  );
  static const profileReminder = ('记账提醒', 'Reminder');
  static const profileReminderDesc = ('设置每日记账提醒', 'Set daily reminder');
  static const profilePrivacy = ('隐私设置', 'Privacy');
  static const profilePrivacyDesc = ('密码锁、指纹锁', 'Password, fingerprint lock');
  static const profileTheme = ('主题设置', 'Theme');
  static const profileThemeDesc = ('切换应用主题', 'Switch app theme');
  static const profileLanguage = ('语言设置', 'Language');
  static const profileLanguageDesc = ('切换应用语言', 'Switch language');
  static const profileAbout = ('关于', 'About');
  static const profileAboutUs = ('关于我们', 'About Us');
  static const profileAboutContent = (
    '© 2024 记账\n一个简单易用的记账工具',
    '© 2024 Bookkeeping\nA simple bookkeeping tool',
  );
  static const profileHelpFeedback = ('帮助与反馈', 'Help & Feedback');
  static const profileDevelopingHint = ('功能开发中...', 'Under development...');

  // ==================== 通用 ====================
  static const commonLoading = ('加载中...', 'Loading...');
  static const commonError = ('加载失败', 'Load failed');
  static const commonRetry = ('重试', 'Retry');
  static const commonConfirm = ('确认', 'Confirm');
  static const commonCancel = ('取消', 'Cancel');
  static const commonEdit = ('编辑', 'Edit');
  static const commonDelete = ('删除', 'Delete');
  static const commonSave = ('保存', 'Save');
}

/// 语言枚举
enum Language {
  /// 中文
  zh(code: 0, displayName: '中文', englishName: 'Chinese'),

  /// 英文
  en(code: 1, displayName: 'English', englishName: 'English');

  const Language({
    required this.code,
    required this.displayName,
    required this.englishName,
  });

  /// 语言代码（用于访问 tuple）
  /// 0 = 中文, 1 = 英文
  final int code;

  /// 语言显示名称（本地化）
  final String displayName;

  /// 语言英文名称
  final String englishName;
}

/// Record 扩展方法 - 提供便捷的多语言访问
extension LocalizedStringExt on (String, String) {
  /// 根据语言枚举获取文本
  String tr(Language language) {
    return language.code == 0 ? $1 : $2;
  }

  /// 中文
  String get zh => $1;

  /// 英文
  String get en => $2;
}
