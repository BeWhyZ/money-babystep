import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../providers/locale_provider.dart';
import 'language_settings_page.dart';

/// 我的页面
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = ref.watch(stringsProvider);
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: Text(strings.profileTitle),
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
                          strings.profileUsername,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.textPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          strings.profileDays,
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
            _SectionTitle(title: strings.profileDataManagement),
            _MenuItem(
              icon: Icons.upload_file,
              title: strings.profileWechatImport,
              subtitle: strings.profileWechatImportDesc,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(strings.profileDevelopingHint)),
                );
              },
            ),
            _MenuItem(
              icon: Icons.account_balance,
              title: strings.profileAlipayImport,
              subtitle: strings.profileAlipayImportDesc,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(strings.profileDevelopingHint)),
                );
              },
            ),
            _MenuItem(
              icon: Icons.backup,
              title: strings.profileDataBackup,
              subtitle: strings.profileDataBackupDesc,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(strings.profileDevelopingHint)),
                );
              },
            ),
            _MenuItem(
              icon: Icons.restore,
              title: strings.profileDataRestore,
              subtitle: strings.profileDataRestoreDesc,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(strings.profileDevelopingHint)),
                );
              },
            ),

            const SizedBox(height: 24),

            // 设置
            _SectionTitle(title: strings.profileSettings),
            _MenuItem(
              icon: Icons.category,
              title: strings.profileCategoryManagement,
              subtitle: strings.profileCategoryManagementDesc,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(strings.profileDevelopingHint)),
                );
              },
            ),
            _MenuItem(
              icon: Icons.notifications,
              title: strings.profileReminder,
              subtitle: strings.profileReminderDesc,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(strings.profileDevelopingHint)),
                );
              },
            ),
            _MenuItem(
              icon: Icons.lock,
              title: strings.profilePrivacy,
              subtitle: strings.profilePrivacyDesc,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(strings.profileDevelopingHint)),
                );
              },
            ),
            _MenuItem(
              icon: Icons.palette,
              title: strings.profileTheme,
              subtitle: strings.profileThemeDesc,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(strings.profileDevelopingHint)),
                );
              },
            ),
            _MenuItem(
              icon: Icons.language,
              title: strings.profileLanguage,
              subtitle: strings.profileLanguageDesc,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LanguageSettingsPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // 关于
            _SectionTitle(title: strings.profileAbout),
            _MenuItem(
              icon: Icons.info,
              title: strings.profileAboutUs,
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: strings.appName,
                  applicationVersion: '1.0.0',
                  applicationLegalese: strings.profileAboutContent,
                );
              },
            ),
            _MenuItem(
              icon: Icons.help,
              title: strings.profileHelpFeedback,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(strings.profileDevelopingHint)),
                );
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
