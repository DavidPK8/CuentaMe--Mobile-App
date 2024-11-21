// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_element

import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/theme/texts/widget_text.dart';
import 'package:cuentame_tesis/views/User_Screens/login_screen.dart';
import 'package:cuentame_tesis/views/User_Screens/register_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key, required this.shoppingList, required this.addToCart});
  final List<Map<String, dynamic>> shoppingList;
  final Function(Map<String, dynamic>) addToCart;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> products = [
    {'name': 'Producto 1', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$10', 'description': 'Descripcion del producto 1...'},
    {'name': 'Producto 2', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$15', 'description': 'Descripcion del producto 2...'},    {'name': 'Producto 1', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$10', 'description': 'Descripcion del producto 1...'},
    {'name': 'Producto 2', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$15', 'description': 'Descripcion del producto 2...'},    {'name': 'Producto 1', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$10', 'description': 'Descripcion del producto 1...'},
    {'name': 'Producto 2', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$15', 'description': 'Descripcion del producto 2...'},    {'name': 'Producto 1', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$10', 'description': 'Descripcion del producto 1...'},
    {'name': 'Producto 2', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$15', 'description': 'Descripcion del producto 2...'},    {'name': 'Producto 1', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$10', 'description': 'Descripcion del producto 1...'},
    {'name': 'Producto 2', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$15', 'description': 'Descripcion del producto 2...'},    {'name': 'Producto 1', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$10', 'description': 'Descripcion del producto 1...'},
    {'name': 'Producto 2', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$15', 'description': 'Descripcion del producto 2...'},    {'name': 'Producto 1', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$10', 'description': 'Descripcion del producto 1...'},
    {'name': 'Producto 2', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$15', 'description': 'Descripcion del producto 2...'},    {'name': 'Producto 1', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$10', 'description': 'Descripcion del producto 1...'},
    {'name': 'Producto 2', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$15', 'description': 'Descripcion del producto 2...'},    {'name': 'Producto 1', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$10', 'description': 'Descripcion del producto 1...'},
    {'name': 'Producto 2', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$15', 'description': 'Descripcion del producto 2...'},    {'name': 'Producto 1', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$10', 'description': 'Descripcion del producto 1...'},
    {'name': 'Producto 2', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$15', 'description': 'Descripcion del producto 2...'},    {'name': 'Producto 1', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$10', 'description': 'Descripcion del producto 1...'},
    {'name': 'Producto 2', 'image': 'https://www.shutterstock.com/image-vector/cute-pikachu-face-characters-on-260nw-2450936679.jpg', 'price': '\$15', 'description': 'Descripcion del producto 2...'},
  ];

  @override
  Widget build(BuildContext context) {

    void _addToCart(Map<String, dynamic> product) {
      widget.addToCart(product);
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () => _showProductDetails(
                context,
                product,
                    (product) => _addToCart(product), // Callback para agregar al carrito
              ),
              child: Card(
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image.network(
                        product['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          WidgetText(text: product['name'], fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.colorBlack, textAlign: TextAlign.center),
                          WidgetText(text: 'Precio: ${product['price']}', fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.colorBlack, textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void _showProductDetails(
    BuildContext context,
    Map<String, dynamic> product,
    Function(Map<String, dynamic>) addToCartCallback,
    ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: WidgetText(
          text: product['name'],
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.colorWhite,
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.primaryColor,
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                product['image'],
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              WidgetText(
                text: 'Precio: ${product['price']}',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.colorWhite,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              WidgetText(
                text: product['description'],
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.colorWhite,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: Colors.black,
            width: 1.25,
          ),
        ),
        actions: [
          Center(
            child: TextButton.icon(
              onPressed: () {
                addToCartCallback(product);
                Navigator.pop(context); // Cerrar el diálogo
              },
              icon: const Icon(Icons.add_shopping_cart, color: AppColors.colorWhite),
              label: const WidgetText(
                text: 'Añadir al Carrito',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.colorWhite,
                textAlign: TextAlign.center,
              ),
              style: TextButton.styleFrom(
                backgroundColor: AppColors.cartColor,
              ),
            ),
          ),
        ],
      );
    },
  );
}

void _showAuthDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const WidgetText(
          text: 'Cuenta Requerida',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.colorBlack,
          textAlign: TextAlign.center,
        ),
        content: const WidgetText(
          text: 'Necesitas una cuenta para añadir productos al carrito.',
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: AppColors.colorBlack,
          textAlign: TextAlign.center,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribuye los botones a los extremos
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cierra el diálogo
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()), // Redirige a inicio de sesión
                  );
                },
                child: const Text(
                  'Inicio de sesión',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cierra el diálogo
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()), // Redirige a registrarse
                  );
                },
                child: const Text(
                  'Registrarse',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}


