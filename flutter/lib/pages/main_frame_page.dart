import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/navigation_provider.dart';
import '../widgets/top_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/transaction_input_sheet.dart';
import 'bookkeeping_page.dart';
import 'asset_page.dart';
import 'profile_page.dart';

/// 主框架页面
class MainFramePage extends ConsumerWidget {
  const MainFramePage({super.key});

  void _showTransactionInputSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const TransactionInputSheet(),
      ),
    );
  }

  void _navigateToProfile(BuildContext context, WidgetRef ref) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const ProfilePage()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);

    // 页面列表
    final pages = [const BookkeepingPage(), const AssetPage()];

    return Scaffold(
      appBar: TopBar(onProfileTap: () => _navigateToProfile(context, ref)),
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: BottomNavBar(
        onAddTransaction: () => _showTransactionInputSheet(context),
      ),
    );
  }
}
