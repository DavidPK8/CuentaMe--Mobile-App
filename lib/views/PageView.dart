// ignore_for_file: file_names

import 'package:cuentame_tesis/components/SalmonBottomNav.dart';
import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/views/Basic_Views/cart_screen.dart';
import 'package:cuentame_tesis/views/Basic_Views/home_screen.dart';
import 'package:cuentame_tesis/views/User_Screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

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
      const Center(child: Text("Catálogo", style: TextStyle(fontSize: 24))),
      const Center(child: Text("Ofertas", style: TextStyle(fontSize: 24))),
      const UserProfileScreen(),
    ];
  }

  void onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        extendBody: true,
        body: PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: _pagesCompose,
        ),
        floatingActionButton: _currentIndex == 3
            ? null
            : floatComposeCart(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: Salmonbottomnav(
          currentIndex: _currentIndex,
          ontabChanged: onTabSelected,
        ),
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
                  shoppingList: _shoppingList, // Debe ser List<Map<String, dynamic>>
                  onUpdate: (updatedList) {
                    setState(() {
                      _shoppingList = updatedList; // Actualiza con el tipo correcto
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
                '${_shoppingList.length}', // Muestra la cantidad de productos
                style: const TextStyle(fontSize: 8, color: Colors.white),
              )
            ),
          ),
      ],
    );
  }
}
