import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// 我的页面
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('我的'),
        backgroundColor: AppConstants.cardBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),

            // 用户头像和信息
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppConstants.cardBackgroundColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // 头像
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppConstants.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 36,
                      color: AppConstants.primaryColor,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // 用户信息
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '用户名',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.textPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '记账 0 天',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppConstants.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 编辑按钮
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: AppConstants.textSecondaryColor,
                    ),
                    onPressed: () {
                      // TODO: 编辑用户信息
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 数据导入
            _SectionTitle(title: '数据管理'),
            _MenuItem(
              icon: Icons.upload_file,
              title: '微信账单导入',
              subtitle: '导入微信账单数据',
              onTap: () {
                // TODO: 实现微信账单导入
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('微信账单导入功能开发中...')));
              },
            ),
            _MenuItem(
              icon: Icons.account_balance,
              title: '支付宝账单导入',
              subtitle: '导入支付宝账单数据',
              onTap: () {
                // TODO: 实现支付宝账单导入
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('支付宝账单导入功能开发中...')),
                );
              },
            ),
            _MenuItem(
              icon: Icons.backup,
              title: '数据备份',
              subtitle: '备份本地数据',
              onTap: () {
                // TODO: 实现数据备份
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('数据备份功能开发中...')));
              },
            ),
            _MenuItem(
              icon: Icons.restore,
              title: '数据恢复',
              subtitle: '从备份恢复数据',
              onTap: () {
                // TODO: 实现数据恢复
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('数据恢复功能开发中...')));
              },
            ),

            const SizedBox(height: 24),

            // 设置
            _SectionTitle(title: '设置'),
            _MenuItem(
              icon: Icons.category,
              title: '分类管理',
              subtitle: '自定义收支分类',
              onTap: () {
                // TODO: 分类管理
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('分类管理功能开发中...')));
              },
            ),
            _MenuItem(
              icon: Icons.notifications,
              title: '记账提醒',
              subtitle: '设置每日记账提醒',
              onTap: () {
                // TODO: 记账提醒设置
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('记账提醒功能开发中...')));
              },
            ),
            _MenuItem(
              icon: Icons.lock,
              title: '隐私设置',
              subtitle: '密码锁、指纹锁',
              onTap: () {
                // TODO: 隐私设置
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('隐私设置功能开发中...')));
              },
            ),
            _MenuItem(
              icon: Icons.palette,
              title: '主题设置',
              subtitle: '切换应用主题',
              onTap: () {
                // TODO: 主题设置
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('主题设置功能开发中...')));
              },
            ),

            const SizedBox(height: 24),

            // 关于
            _SectionTitle(title: '关于'),
            _MenuItem(
              icon: Icons.info,
              title: '关于我们',
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: AppConstants.appName,
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2024 小步记账\n一个简单易用的记账工具',
                );
              },
            ),
            _MenuItem(
              icon: Icons.help,
              title: '帮助与反馈',
              onTap: () {
                // TODO: 帮助与反馈
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('帮助与反馈功能开发中...')));
              },
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

/// 分组标题
class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppConstants.textSecondaryColor,
        ),
      ),
    );
  }
}

/// 菜单项
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppConstants.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppConstants.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 22, color: AppConstants.primaryColor),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppConstants.textPrimaryColor,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: TextStyle(
                  fontSize: 13,
                  color: AppConstants.textSecondaryColor,
                ),
              )
            : null,
        trailing: Icon(
          Icons.chevron_right,
          color: AppConstants.textSecondaryColor,
        ),
        onTap: onTap,
      ),
    );
  }
}
