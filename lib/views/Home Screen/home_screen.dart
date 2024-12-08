import 'dart:math';
import 'package:cuentame_tesis/utils/token.manager.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../theme/decorations/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.shoppingList,
    required this.addToCart,
  });

  final List<Map<String, dynamic>> shoppingList;
  final Function(Map<String, dynamic>) addToCart;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> productos = [
    {
      "nombre": "Manicho 28gr",
      "descripcion": "Chocolate con leche, en barra, relleno con trozos de mani.",
      "precio": 0.50,
      "imagen": "https://tofuu.getjusto.com/orioneat-prod/br23dyqs7cwsJdZTx-1012379.jpg",
    },
    {
      "nombre": "Chocolates Bon O Bon (Caja x30)",
      "descripcion": "Caja de bobones rellenos de avellana con cubierta de chocolate.",
      "precio": 4.35,
      "imagen": "https://rosendoguaman.com.ec/wp-content/uploads/2020/05/7802225511513BONOBON30.png",
    },
    {
      "nombre": "Capibara Musculoso",
      "descripcion": "Peluche decorativo inspirado en el animal de moda mas tierno del mundo",
      "precio": 15.99,
      "imagen": "https://kokostation.com/wp-content/uploads/capibara-musculoso.webp",
    },
    {
      "nombre": "Flores tejidas",
      "descripcion": "Flores tejidas en lana, con diferentes motivos y colores.",
      "precio": 8.00,
      "imagen": "https://m.media-amazon.com/images/I/71EZ6MycaOL._AC_UF894,1000_QL80_.jpg",
    },
    {
      "nombre": "Caja de Dulces",
      "descripcion": "Caja de chocolates, caramelos y bombones.",
      "precio": 25.50,
      "imagen": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVUjXOkKhssD0XLf0IZk8lkNYRGtnFq5-1VA&s",
    },
    {
      "nombre": "Caja de Amor",
      "descripcion": "Caja de regalo con productos para sorprender a tu ser querido.",
      "precio": 50.00,
      "imagen": "https://i.pinimg.com/originals/3f/87/e1/3f87e1a525357e7e1f2cbd70ea30dcb4.jpg",
    },
  ];

  late List<Map<String, dynamic>> selectedItems;
  int cantidad = 1;
  final bool isLoggedIn = TokenManager().token.isNotEmpty;

  @override
  void initState() {
    super.initState();
    selectedItems = [...productos]..shuffle();
    selectedItems = selectedItems.take(6).toList(); // Tomar 4 elementos aleatorios
  }

  void _addToCart(Map<String, dynamic> product) {
    widget.addToCart(product);
  }

  void _showCajaDetails(BuildContext context, Map<String, dynamic> caja) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  caja["imagen"] ?? 'https://via.placeholder.com/150', // Imagen por defecto si es null
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Título y Precio
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    caja["nombre"] ?? "Producto sin nombre",  // Valor por defecto si es null
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "\$${(caja["precio"] ?? 0.0).toStringAsFixed(2)}",  // Si el precio es null, muestra 0.00
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Descripción
            Text(
              caja["descripcion"] ?? "Descripción no disponible",  // Valor por defecto si es null
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Contenido (si lo tiene)
            if (caja["contenido"] != null) ...[
              const Text(
                "Contenido:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (caja["contenido"] as List).length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return Text(
                    "- ${(caja["contenido"] as List)[index]}",
                    style: const TextStyle(fontSize: 14),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],

            // Divider
            const Divider(),

            // Botón Agregar al Carrito
            isLoggedIn
                ? Row(
              children: [
                IconButton(
                  icon: const Icon(EvaIcons.minus),
                  onPressed: () {
                    if (cantidad > 1) {
                      setState(() {
                        cantidad--;
                      });
                    }
                  },
                ),
                Text("$cantidad",
                    style: Theme.of(context).textTheme.labelMedium),
                IconButton(
                  icon: const Icon(EvaIcons.plus),
                  onPressed: () {
                    setState(() {
                      cantidad++;
                    });
                  },
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Aquí pasamos el producto y la cantidad
                    Map<String, dynamic> productWithQuantity = {
                      ...caja,
                      "cantidad": cantidad
                    };
                    _addToCart(productWithQuantity);
                    Navigator.pop(context); // Cerrar el modal
                  },
                  child: const Text("Agregar al carrito"),
                ),
              ],
            )
                : Text(
              "Para adquirir este producto, inicia sesión con tu cuenta.",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bienvenido/a"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: selectedItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final product = selectedItems[index];
            return GestureDetector(
              onTap: () => _showCajaDetails(context, product),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image.network(
                        product["imagen"] ?? 'https://via.placeholder.com/150',  // Imagen por defecto si es null
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            product["nombre"] ?? "Producto sin nombre",  // Valor por defecto si es null
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "\$${(product["precio"] ?? 0.0).toStringAsFixed(2)}",  // Precio por defecto si es null
                            style: const TextStyle(fontSize: 14),
                          ),
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