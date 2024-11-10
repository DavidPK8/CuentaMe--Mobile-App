import 'package:cuentame_tesis/authentication/auth_provider.dart';
import 'package:cuentame_tesis/decorations/app_colors.dart';
import 'package:cuentame_tesis/decorations/texts/widget_text.dart';
import 'package:cuentame_tesis/presentation/screens/login_screen.dart';
import 'package:cuentame_tesis/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {'name': 'Producto 1', 'image': 'https://via.placeholder.com/150', 'price': '\$10', 'description': 'Descripcion del producto 1...'},
    {'name': 'Producto 2', 'image': 'https://via.placeholder.com/150', 'price': '\$15', 'description': 'Descripcion del producto 2...'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

void _showAuthDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: WidgetText(
          text: 'Cuenta Requerida',
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.colorBlack,
          textAlign: TextAlign.center,
        ),
        content: WidgetText(
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
                    MaterialPageRoute(builder: (context) => LoginScreen()), // Redirige a inicio de sesión
                  );
                },
                child: Text(
                  'Inicio de sesión',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cierra el diálogo
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()), // Redirige a registrarse
                  );
                },
                child: Text(
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


  void _showProductDetails(BuildContext context, Map<String, dynamic> product) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: WidgetText(text: product['name'], fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.colorWhite, textAlign: TextAlign.center),
        backgroundColor: AppColors.primaryColor,
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,  // Ancho de la ventana de diálogo
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                product['image'],
                height: 200,  // Tamaño de la imagen
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              WidgetText(text: 'Precio: ${product['price']}', fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.colorWhite, textAlign: TextAlign.center),
              SizedBox(height: 10),
              WidgetText(text: product['description'], fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.colorWhite, textAlign: TextAlign.center),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),  // Bordes redondeados
          side: BorderSide(
            color: Colors.black,  // Color del borde
            width: 1.25,  // Grosor del borde
          ),
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
              icon: Icon(Icons.add_shopping_cart, color: AppColors.colorWhite),
              label: WidgetText(text: 'Añadir al Carrito', fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.colorWhite, textAlign: TextAlign.center),
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
