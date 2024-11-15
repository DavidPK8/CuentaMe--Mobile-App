import 'package:cuentame_tesis/app/decorations/app_colors.dart';
import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/customize_product_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/order_status_screen.dart';
import '../screens/user_profile_screen.dart';

class BottomNavitation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavitation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    CustomizeProductScreen(),
    CartScreen(),
    OrderStatusScreen(),
    UserProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Image.asset(
          'assets/images/cuentame_logo_main.png', 
          height: 115, 
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundcolor_1, 
              AppColors.backgroundcolor_2, 
            ],
          ),
        ),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: ClipRRect(
        child: Container(
          color: AppColors.primaryColor,
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
              BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Personalizar'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Carrito'),
              BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Estado'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: Colors.yellow,
            unselectedItemColor: AppColors.colorWhite,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}