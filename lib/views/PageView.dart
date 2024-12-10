import 'package:cuentame_tesis/components/SalmonBottomNav.dart';
import 'package:cuentame_tesis/utils/token.manager.dart';
import 'package:cuentame_tesis/views/Shopping%20Cart/cart.view.dart';
import 'package:flutter/material.dart';
import 'package:cuentame_tesis/views/Home%20Screen/home_screen.dart';
import 'package:cuentame_tesis/views/Categories/categories.view.dart';
import 'package:cuentame_tesis/views/Profile/profile.screen.dart';

class ComposePageView extends StatefulWidget {
  const ComposePageView({super.key});

  @override
  State<ComposePageView> createState() => _ComposePageViewState();
}

class _ComposePageViewState extends State<ComposePageView> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  late List<Widget> _pagesCompose;
  final bool isLoggedIn = TokenManager().token.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _pagesCompose = [
      const HomeScreen(),
      const CategoriesView(),
      const CartScreen(),
      const UserProfileScreen(),
    ];
  }

  void onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
    _controller.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: PageView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(), // Deshabilita el deslizamiento
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: _pagesCompose,
        ),
      ),
      bottomNavigationBar: Salmonbottomnav(currentIndex: _currentIndex, ontabChanged: onTabSelected),
    );
  }
}
