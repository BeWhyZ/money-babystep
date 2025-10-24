/// 应用文本字符串 - 支持多语言
abstract class AppStrings {
  // 应用基础
  String get appName;

  // 导航
  String get navBookkeeping;
  String get navAsset;
  String get navProfile;

  // 记账页
  String get bookkeepingTitle;
  String get bookkeepingIncome;
  String get bookkeepingExpense;
  String get bookkeepingBalance;
  String get bookkeepingNoData;
  String get bookkeepingNoDataHint;
  String get bookkeepingToday;
  String get bookkeepingYesterday;

  // 资产页
  String get assetTitle;
  String get assetNetAsset;
  String get assetFinancialIndicators;
  String get assetTotalAssets;
  String get assetTotalLiabilities;
  String get assetSavingsRate;
  String get assetSavingsRateTarget;
  String get assetDebtRatio;
  String get assetDebtRatioTarget;
  String get assetNetAssetsGrowthRate;
  String get assetNetAssetsGrowthRateDesc;
  String get assetFreeCashFlow;
  String get assetFreeCashFlowDesc;
  String get assetEmergencyReserve;
  String get assetEmergencyReserveTarget;
  String get assetFinancialAdvice;
  String get assetAdviceSavingsLow;
  String get assetAdviceDebtHigh;
  String get assetAdviceEmergencyLow;
  String get assetAdviceHealthy;

  // 交易输入
  String get transactionExpense;
  String get transactionIncome;
  String get transactionAmount;
  String get transactionCategory;
  String get transactionSelectCategory;
  String get transactionSecondaryCategory;
  String get transactionNote;
  String get transactionNotePlaceholder;
  String get transactionComplete;
  String get transactionSuccess;
  String get transactionFailed;

  // 分类
  String get categoryFood;
  String get categoryShopping;
  String get categoryTransport;
  String get categoryTelecom;
  String get categoryMedical;
  String get categoryHome;
  String get categoryPension;
  String get categoryPet;
  String get categoryEntertainment;
  String get categorySalary;
  String get categoryBonus;
  String get categoryInvestment;
  String get categoryOther;

  // 我的页面
  String get profileTitle;
  String get profileUsername;
  String get profileDays;
  String get profileDataManagement;
  String get profileWechatImport;
  String get profileWechatImportDesc;
  String get profileAlipayImport;
  String get profileAlipayImportDesc;
  String get profileDataBackup;
  String get profileDataBackupDesc;
  String get profileDataRestore;
  String get profileDataRestoreDesc;
  String get profileSettings;
  String get profileCategoryManagement;
  String get profileCategoryManagementDesc;
  String get profileReminder;
  String get profileReminderDesc;
  String get profilePrivacy;
  String get profilePrivacyDesc;
  String get profileTheme;
  String get profileThemeDesc;
  String get profileLanguage;
  String get profileLanguageDesc;
  String get profileAbout;
  String get profileAboutUs;
  String get profileAboutContent;
  String get profileHelpFeedback;
  String get profileDevelopingHint;

  // 通用
  String get commonLoading;
  String get commonError;
  String get commonRetry;
  String get commonConfirm;
  String get commonCancel;
  String get commonEdit;
  String get commonDelete;
  String get commonSave;
}

/// 中文字符串
class AppStringsZh implements AppStrings {
  // 应用基础
  @override
  String get appName => '记账';

  // 导航
  @override
  String get navBookkeeping => '记账';
  @override
  String get navAsset => '资产';
  @override
  String get navProfile => '我的';

  // 记账页
  @override
  String get bookkeepingTitle => '记账';
  @override
  String get bookkeepingIncome => '收入';
  @override
  String get bookkeepingExpense => '支出';
  @override
  String get bookkeepingBalance => '结余';
  @override
  String get bookkeepingNoData => '暂无记账记录';
  @override
  String get bookkeepingNoDataHint => '点击右下角"+"开始记账';
  @override
  String get bookkeepingToday => '今天';
  @override
  String get bookkeepingYesterday => '昨天';

  // 资产页
  @override
  String get assetTitle => '资产';
  @override
  String get assetNetAsset => '净资产';
  @override
  String get assetFinancialIndicators => '财务指标';
  @override
  String get assetTotalAssets => '总资产';
  @override
  String get assetTotalLiabilities => '总负债';
  @override
  String get assetSavingsRate => '储蓄率';
  @override
  String get assetSavingsRateTarget => '建议目标: ≥20%';
  @override
  String get assetDebtRatio => '负债率';
  @override
  String get assetDebtRatioTarget => '建议目标: <50%';
  @override
  String get assetNetAssetsGrowthRate => '净资产增长率';
  @override
  String get assetNetAssetsGrowthRateDesc => '相比上月';
  @override
  String get assetFreeCashFlow => '自由现金流';
  @override
  String get assetFreeCashFlowDesc => '可用于投资和应急储备';
  @override
  String get assetEmergencyReserve => '应急储备充足度';
  @override
  String get assetEmergencyReserveTarget => '建议目标: 3-6个月';
  @override
  String get assetFinancialAdvice => '财务建议';
  @override
  String get assetAdviceSavingsLow => '💡 储蓄率偏低，建议控制开支，提高储蓄比例';
  @override
  String get assetAdviceDebtHigh => '⚠️ 负债率偏高，建议优先偿还债务';
  @override
  String get assetAdviceEmergencyLow => '🛡️ 应急储备不足，建议储备3-6个月的固定开支';
  @override
  String get assetAdviceHealthy => '✅ 财务状况良好，继续保持！';

  // 交易输入
  @override
  String get transactionExpense => '支出';
  @override
  String get transactionIncome => '收入';
  @override
  String get transactionAmount => '金额';
  @override
  String get transactionCategory => '分类';
  @override
  String get transactionSelectCategory => '选择分类';
  @override
  String get transactionSecondaryCategory => '二级分类（可选）';
  @override
  String get transactionNote => '备注';
  @override
  String get transactionNotePlaceholder => '添加备注（可选）';
  @override
  String get transactionComplete => '完成';
  @override
  String get transactionSuccess => '记账成功';
  @override
  String get transactionFailed => '记账失败';

  // 分类
  @override
  String get categoryFood => '餐饮';
  @override
  String get categoryShopping => '购物';
  @override
  String get categoryTransport => '交通';
  @override
  String get categoryTelecom => '通讯';
  @override
  String get categoryMedical => '医疗';
  @override
  String get categoryHome => '居家';
  @override
  String get categoryPension => '养老保险';
  @override
  String get categoryPet => '宠物';
  @override
  String get categoryEntertainment => '娱乐';
  @override
  String get categorySalary => '工资';
  @override
  String get categoryBonus => '奖金';
  @override
  String get categoryInvestment => '投资收益';
  @override
  String get categoryOther => '其他';

  // 我的页面
  @override
  String get profileTitle => '我的';
  @override
  String get profileUsername => '用户名';
  @override
  String get profileDays => '记账 0 天';
  @override
  String get profileDataManagement => '数据管理';
  @override
  String get profileWechatImport => '微信账单导入';
  @override
  String get profileWechatImportDesc => '导入微信账单数据';
  @override
  String get profileAlipayImport => '支付宝账单导入';
  @override
  String get profileAlipayImportDesc => '导入支付宝账单数据';
  @override
  String get profileDataBackup => '数据备份';
  @override
  String get profileDataBackupDesc => '备份本地数据';
  @override
  String get profileDataRestore => '数据恢复';
  @override
  String get profileDataRestoreDesc => '从备份恢复数据';
  @override
  String get profileSettings => '设置';
  @override
  String get profileCategoryManagement => '分类管理';
  @override
  String get profileCategoryManagementDesc => '自定义收支分类';
  @override
  String get profileReminder => '记账提醒';
  @override
  String get profileReminderDesc => '设置每日记账提醒';
  @override
  String get profilePrivacy => '隐私设置';
  @override
  String get profilePrivacyDesc => '密码锁、指纹锁';
  @override
  String get profileTheme => '主题设置';
  @override
  String get profileThemeDesc => '切换应用主题';
  @override
  String get profileLanguage => '语言设置';
  @override
  String get profileLanguageDesc => '切换应用语言';
  @override
  String get profileAbout => '关于';
  @override
  String get profileAboutUs => '关于我们';
  @override
  String get profileAboutContent => '© 2024 记账\n一个简单易用的记账工具';
  @override
  String get profileHelpFeedback => '帮助与反馈';
  @override
  String get profileDevelopingHint => '功能开发中...';

  // 通用
  @override
  String get commonLoading => '加载中...';
  @override
  String get commonError => '加载失败';
  @override
  String get commonRetry => '重试';
  @override
  String get commonConfirm => '确认';
  @override
  String get commonCancel => '取消';
  @override
  String get commonEdit => '编辑';
  @override
  String get commonDelete => '删除';
  @override
  String get commonSave => '保存';
}

/// 英文字符串
class AppStringsEn implements AppStrings {
  // 应用基础
  @override
  String get appName => 'Bookkeeping';

  // 导航
  @override
  String get navBookkeeping => 'Bookkeeping';
  @override
  String get navAsset => 'Assets';
  @override
  String get navProfile => 'Profile';

  // 记账页
  @override
  String get bookkeepingTitle => 'Bookkeeping';
  @override
  String get bookkeepingIncome => 'Income';
  @override
  String get bookkeepingExpense => 'Expense';
  @override
  String get bookkeepingBalance => 'Balance';
  @override
  String get bookkeepingNoData => 'No records yet';
  @override
  String get bookkeepingNoDataHint => 'Tap "+" to start bookkeeping';
  @override
  String get bookkeepingToday => 'Today';
  @override
  String get bookkeepingYesterday => 'Yesterday';

  // 资产页
  @override
  String get assetTitle => 'Assets';
  @override
  String get assetNetAsset => 'Net Assets';
  @override
  String get assetFinancialIndicators => 'Financial Indicators';
  @override
  String get assetTotalAssets => 'Total Assets';
  @override
  String get assetTotalLiabilities => 'Total Liabilities';
  @override
  String get assetSavingsRate => 'Savings Rate';
  @override
  String get assetSavingsRateTarget => 'Target: ≥20%';
  @override
  String get assetDebtRatio => 'Debt Ratio';
  @override
  String get assetDebtRatioTarget => 'Target: <50%';
  @override
  String get assetNetAssetsGrowthRate => 'Net Assets Growth Rate';
  @override
  String get assetNetAssetsGrowthRateDesc => 'Compared to last month';
  @override
  String get assetFreeCashFlow => 'Free Cash Flow';
  @override
  String get assetFreeCashFlowDesc => 'Available for investment and emergency';
  @override
  String get assetEmergencyReserve => 'Emergency Reserve';
  @override
  String get assetEmergencyReserveTarget => 'Target: 3-6 months';
  @override
  String get assetFinancialAdvice => 'Financial Advice';
  @override
  String get assetAdviceSavingsLow =>
      '💡 Low savings rate, consider reducing expenses';
  @override
  String get assetAdviceDebtHigh =>
      '⚠️ High debt ratio, prioritize debt repayment';
  @override
  String get assetAdviceEmergencyLow =>
      '🛡️ Insufficient emergency fund, save 3-6 months expenses';
  @override
  String get assetAdviceHealthy => '✅ Financial health is good, keep it up!';

  // 交易输入
  @override
  String get transactionExpense => 'Expense';
  @override
  String get transactionIncome => 'Income';
  @override
  String get transactionAmount => 'Amount';
  @override
  String get transactionCategory => 'Category';
  @override
  String get transactionSelectCategory => 'Select Category';
  @override
  String get transactionSecondaryCategory => 'Subcategory (Optional)';
  @override
  String get transactionNote => 'Note';
  @override
  String get transactionNotePlaceholder => 'Add note (optional)';
  @override
  String get transactionComplete => 'Complete';
  @override
  String get transactionSuccess => 'Transaction added';
  @override
  String get transactionFailed => 'Transaction failed';

  // 分类
  @override
  String get categoryFood => 'Food';
  @override
  String get categoryShopping => 'Shopping';
  @override
  String get categoryTransport => 'Transport';
  @override
  String get categoryTelecom => 'Telecom';
  @override
  String get categoryMedical => 'Medical';
  @override
  String get categoryHome => 'Home';
  @override
  String get categoryPension => 'Pension';
  @override
  String get categoryPet => 'Pet';
  @override
  String get categoryEntertainment => 'Entertainment';
  @override
  String get categorySalary => 'Salary';
  @override
  String get categoryBonus => 'Bonus';
  @override
  String get categoryInvestment => 'Investment';
  @override
  String get categoryOther => 'Other';

  // 我的页面
  @override
  String get profileTitle => 'Profile';
  @override
  String get profileUsername => 'Username';
  @override
  String get profileDays => '0 days';
  @override
  String get profileDataManagement => 'Data Management';
  @override
  String get profileWechatImport => 'WeChat Import';
  @override
  String get profileWechatImportDesc => 'Import WeChat bills';
  @override
  String get profileAlipayImport => 'Alipay Import';
  @override
  String get profileAlipayImportDesc => 'Import Alipay bills';
  @override
  String get profileDataBackup => 'Data Backup';
  @override
  String get profileDataBackupDesc => 'Backup local data';
  @override
  String get profileDataRestore => 'Data Restore';
  @override
  String get profileDataRestoreDesc => 'Restore from backup';
  @override
  String get profileSettings => 'Settings';
  @override
  String get profileCategoryManagement => 'Category Management';
  @override
  String get profileCategoryManagementDesc => 'Customize categories';
  @override
  String get profileReminder => 'Reminder';
  @override
  String get profileReminderDesc => 'Set daily reminder';
  @override
  String get profilePrivacy => 'Privacy';
  @override
  String get profilePrivacyDesc => 'Password, fingerprint lock';
  @override
  String get profileTheme => 'Theme';
  @override
  String get profileThemeDesc => 'Switch app theme';
  @override
  String get profileLanguage => 'Language';
  @override
  String get profileLanguageDesc => 'Switch language';
  @override
  String get profileAbout => 'About';
  @override
  String get profileAboutUs => 'About Us';
  @override
  String get profileAboutContent =>
      '© 2024 Bookkeeping\nA simple bookkeeping tool';
  @override
  String get profileHelpFeedback => 'Help & Feedback';
  @override
  String get profileDevelopingHint => 'Under development...';

  // 通用
  @override
  String get commonLoading => 'Loading...';
  @override
  String get commonError => 'Load failed';
  @override
  String get commonRetry => 'Retry';
  @override
  String get commonConfirm => 'Confirm';
  @override
  String get commonCancel => 'Cancel';
  @override
  String get commonEdit => 'Edit';
  @override
  String get commonDelete => 'Delete';
  @override
  String get commonSave => 'Save';
}
