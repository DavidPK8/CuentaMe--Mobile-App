import 'package:cuentame_tesis/authentication/auth_provider.dart';
import 'package:cuentame_tesis/presentation/screens/login_screen.dart';
import 'package:cuentame_tesis/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {'name': 'Producto 1', 'image': 'https://via.placeholder.com/150', 'price': '\$10'},
    {'name': 'Producto 2', 'image': 'https://via.placeholder.com/150', 'price': '\$15'},
  ];

  void _showAuthDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cuenta requerida'),
          content: Text('Necesitas una cuenta para añadir productos al carrito.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()), // Redirige a inicio de sesión
                );
              },
              child: Text('Inicio de sesión'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()), // Redirige a inicio de sesión
                );
              },
              child: Text('Registrarse'),
            ),
          ],
        );
      },
    );
  }

  void _showProductDetails(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(product['name']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(product['image']),
              SizedBox(height: 10),
              Text('Precio: ${product['price']}'),
              SizedBox(height: 10),
              Text('Descripción del producto...'),
            ],
          ),
          actions: [
            Center(
              child: TextButton.icon(
                onPressed: () {
                  final authProvider = Provider.of<AuthProvider>(context, listen: false);
                  if (authProvider.isAuthenticated) {
                    // Añadir el producto al carrito
                    Navigator.of(context).pop();
                  } else {
                    // Mostrar el diálogo de autenticación
                    _showAuthDialog(context);
                  }
                },
                icon: Icon(Icons.add_shopping_cart, color: Colors.white),
                label: Text('Añadir al Carrito', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () => _showProductDetails(context, product),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name'],
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(product['price']),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
