import 'package:cuentame_tesis/model/producto.model.dart';
import 'package:cuentame_tesis/utils/token.manager.dart';
import 'package:cuentame_tesis/views/Goodbye%20Screen/goodbye.view.dart';
import 'package:cuentame_tesis/views/Shopping%20Cart/cart.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../theme/decorations/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Ahora tenemos una lista de objetos Producto
  final List<Producto> productos = [
    Producto(
      nombre: "Manicho 28gr",
      descripcion: "Chocolate con leche, en barra, relleno con trozos de mani.",
      stock: 100,
      precio: 0.50,
      imagen: "https://tofuu.getjusto.com/orioneat-prod/br23dyqs7cwsJdZTx-1012379.jpg",
    ),
    Producto(
      nombre: "Chocolates Bon O Bon (Caja x30)",
      descripcion: "Caja de bobones rellenos de avellana con cubierta de chocolate.",
      stock: 200,
      precio: 4.35,
      imagen: "https://rosendoguaman.com.ec/wp-content/uploads/2020/05/7802225511513BONOBON30.png",
    ),
    Producto(
      nombre: "Capibara Musculoso",
      descripcion: "Peluche decorativo inspirado en el animal de moda mas tierno del mundo",
      stock: 50,
      precio: 15.99,
      imagen: "https://kokostation.com/wp-content/uploads/capibara-musculoso.webp",
    ),
    Producto(
      nombre: "Flores tejidas",
      descripcion: "Flores tejidas en lana, con diferentes motivos y colores.",
      stock: 80,
      precio: 8.00,
      imagen: "https://m.media-amazon.com/images/I/71EZ6MycaOL._AC_UF894,1000_QL80_.jpg",
    ),
    Producto(
      nombre: "Caja de Dulces",
      descripcion: "Caja de chocolates, caramelos y bombones.",
      stock: 150,
      precio: 25.50,
      imagen: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVUjXOkKhssD0XLf0IZk8lkNYRGtnFq5-1VA&s",
    ),
    Producto(
      nombre: "Caja de Amor",
      descripcion: "Caja de regalo con productos para sorprender a tu ser querido.",
      stock: 60,
      precio: 50.00,
      imagen: "https://i.pinimg.com/originals/3f/87/e1/3f87e1a525357e7e1f2cbd70ea30dcb4.jpg",
    ),
  ];

  late List<Producto> selectedItems;
  final bool isLoggedIn = TokenManager().token.isNotEmpty;
  String nombreUsuario = TokenManager().nombre;

  @override
  void initState() {
    super.initState();
    selectedItems = [...productos]..shuffle();
    selectedItems = selectedItems.take(6).toList(); // Tomar 6 elementos aleatorios
  }

  void _showCajaDetails(BuildContext context, Producto producto) {
    final CartController cartController = Get.put(CartController());

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
                  producto.imagen,
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
                    producto.nombre,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "\$${producto.precio.toStringAsFixed(2)}",
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
              producto.descripcion,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Agregar al carrito
            isLoggedIn
                ? FilledButton.tonal(
                onPressed: () {
                  cartController.addToCart(producto); // Agregar al carrito
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${producto.nombre} agregado al carrito")),
                  );
                },
                child: const Text("Agregar al carrito"))
                : Text(
              "Para adquirir este producto, inicia sesión con tu cuenta.",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            centerTitle: true,
            title: Text(
              "Nuestros Productos",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              isLoggedIn ? _logoutButton(context) : const SizedBox.shrink()
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: selectedItems.length,
                itemBuilder: (context, index) {
                  final producto = selectedItems[index];
                  return GestureDetector(
                    onTap: () => _showCajaDetails(context, producto),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Image.network(
                              producto.imagen,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  producto.nombre,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "\$${producto.precio.toStringAsFixed(2)}",
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
          ),
        ],
      ),
    );
  }
}

Widget _logoutButton(BuildContext context) {
  return IconButton.filledTonal(
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Cerrar Sesión",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primaryColor),
            ),
            content: Text(
              "¿Deseas cerrar tu sesión en esta aplicación?",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),
              FilledButton(
                onPressed: () {
                  TokenManager().clear();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const GoodByeView()),
                  );
                },
                child: const Text("Salir"),
              ),
            ],
          );
        },
      );
    },
    icon: const Icon(EvaIcons.log_out_outline, size: 22),
  );
}
