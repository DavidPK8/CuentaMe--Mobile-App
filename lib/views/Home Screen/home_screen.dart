// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_element

import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/theme/texts/widget_text.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  late String formattedDate = '';  // Inicialización con valor vacío

  @override
  void initState() {
    super.initState();
    _initializeDate();
  }

  Future<void> _initializeDate() async {
    await initializeDateFormatting('es_ES', null);
    DateTime now = DateTime.now();
    String dayOfWeek = DateFormat('EEEE', 'es_ES').format(now);
    String month = DateFormat('MMMM', 'es_ES').format(now);

    setState(() {
      formattedDate = '${_capitalize(dayOfWeek)}, ${now.day} de ${_capitalize(month)} ${now.year}';
    });
  }

  String _capitalize(String input) => input[0].toUpperCase() + input.substring(1);

  @override
  Widget build(BuildContext context) {

    void _addToCart(Map<String, dynamic> product) {
      widget.addToCart(product);
    }

    return Scaffold(
      appBar: AppBar(
        leading: const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.transparent,  // Reduzca el radio para que sea más pequeño
          child: Icon(Icons.person_2_rounded, size: 25), // Puedes ajustar el tamaño del icono también si es necesario
        ),
        backgroundColor: Colors.transparent,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,  // Alinea los textos hacia el inicio
          crossAxisAlignment: CrossAxisAlignment.start,  // Alinea los textos hacia el inicio
          children: [
            Text(
              "Bienvenido/a, usuario",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Text(
              formattedDate.isEmpty ? 'Cargando fecha...' : formattedDate,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
        leadingWidth: 60,  // Ajusta el ancho del área para el leading (avatar)
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: CustomScrollView(
          slivers: [
            // SliverToBoxAdapter para el título
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15), // Espaciado debajo del título
                child: Text(
                  "Nuestros Productos",
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,  // Ajusta el tamaño del texto
                  ),
                ),
              ),
            ),

            // SliverGrid para mostrar los productos
            SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
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
                              product['image'], // URL de la imagen del producto
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                WidgetText(
                                  text: product['name'],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.colorBlack,
                                  textAlign: TextAlign.center,
                                ),
                                WidgetText(
                                  text: 'Precio: ${product['price']}',
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.colorBlack,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: products.length,  // Número de productos
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,  // Dos columnas en el grid
                crossAxisSpacing: 10,  // Espaciado entre columnas
                mainAxisSpacing: 10,  // Espaciado entre filas
                childAspectRatio: 0.8,  // Relación de aspecto de cada ítem
              ),
            ),
          ],
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

