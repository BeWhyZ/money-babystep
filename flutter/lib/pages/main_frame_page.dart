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
class MainFramePage extends ConsumerStatefulWidget {
  const MainFramePage({super.key});

  @override
  ConsumerState<MainFramePage> createState() => _MainFramePageState();
}

class _MainFramePageState extends ConsumerState<MainFramePage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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

  void _navigateToProfile(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const ProfilePage()));
  }

  void _onPageChanged(int index) {
    ref.read(navigationIndexProvider.notifier).state = index;
  }

  void _onNavTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // 监听导航状态变化（用于底部导航栏点击）
    ref.listen<int>(navigationIndexProvider, (previous, next) {
      if (next != _pageController.page?.round()) {
        _onNavTap(next);
      }
    });

    // 页面列表
    final pages = [const BookkeepingPage(), const AssetPage()];

    return Scaffold(
      appBar: TopBar(onProfileTap: () => _navigateToProfile(context)),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: pages,
      ),
      bottomNavigationBar: BottomNavBar(
        onAddTransaction: () => _showTransactionInputSheet(context),
      ),
    );
  }
}
