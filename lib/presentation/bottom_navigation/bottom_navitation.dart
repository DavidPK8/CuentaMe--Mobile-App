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
        backgroundColor: const Color.fromRGBO(133, 104, 173, 1),
        centerTitle: true,
        title: Image.asset(
          'assets/images/cuentame_logo.png', // Ruta de la imagen en tu proyecto
          height: 110, // Ajusta el tamaño de la imagen según sea necesario
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFD700), // Amarillo oscuro
              Color(0xFFFFF8DC), // Amarillo claro
            ],
          ),
        ),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: ClipRRect(
        child: Container(
          color: const Color.fromRGBO(133, 104, 173, 1),
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
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }
}