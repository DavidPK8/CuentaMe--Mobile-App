import 'package:cuentame_tesis/utils/token.manager.dart';
import 'package:cuentame_tesis/views/Categories/categories.view.dart';
import 'package:cuentame_tesis/views/Offer%20View/offers.view.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cuentame_tesis/components/SalmonBottomNav.dart';
import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/views/Shopping%20Cart/cart_screen.dart';
import 'package:cuentame_tesis/views/Profile/profile.screen.dart';
import 'package:cuentame_tesis/views/Home%20Screen/home_screen.dart';

class ComposePageView extends StatefulWidget {
  const ComposePageView({super.key});

  @override
  State<ComposePageView> createState() => _ComposePageViewState();
}

class _ComposePageViewState extends State<ComposePageView> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  late List<Map<String, dynamic>> _shoppingList = [];
  late List<Widget> _pagesCompose;
  final bool isLoggedIn = TokenManager().token.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _pagesCompose = [
      HomeScreen(
        shoppingList: _shoppingList,
        addToCart: (product) {
          setState(() {
            _shoppingList.add(product);
          });
        },
      ),
      const CategoriesView(),
      const OffersView(),
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
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            // Bloquea cualquier evento de desplazamiento horizontal
            return scrollNotification is ScrollUpdateNotification &&
                scrollNotification.metrics.axis == Axis.horizontal;
          },
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
      ),
      floatingActionButton: isLoggedIn ? _currentIndex == 3
          ? null
          : floatComposeCart(context) : const SizedBox.shrink(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Salmonbottomnav(
        currentIndex: _currentIndex,
        ontabChanged: onTabSelected,
      ),
    );
  }

  Widget floatComposeCart(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return CartScreen(
                  shoppingList: _shoppingList,
                  onUpdate: (updatedList) {
                    setState(() {
                      _shoppingList = updatedList;
                    });
                  },
                );
              },
            );
          },
          backgroundColor: AppColors.primaryColor,
          child: const Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        ),
        if (_shoppingList.isNotEmpty)
          Positioned(
            right: 5,
            top: 5,
            child: badges.Badge(
              badgeContent: Text(
                '${_shoppingList.length}',
                style: const TextStyle(fontSize: 8, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
