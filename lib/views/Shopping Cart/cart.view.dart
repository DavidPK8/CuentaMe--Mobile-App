import 'package:cuentame_tesis/views/Shopping%20Cart/cart.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/utils/token.manager.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:get/get.dart';
import 'package:cuentame_tesis/views/Login/login.view.dart';
import 'package:cuentame_tesis/views/Register/register.view.dart';
import 'package:cuentame_tesis/model/producto.model.dart'; // Asegúrate de importar el modelo Producto
import 'package:cuentame_tesis/model/boxes.model.dart'; // Asegúrate de importar el modelo Box

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = TokenManager().token.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: isLoggedIn ? buildCartView(context) : nonSessionCart(context),
    );
  }

  // Vista cuando el carrito está vacío
  Widget emptyCartView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/vectors/undraw_empty_cart_co35.svg', // Cambia esta imagen si lo prefieres
            width: 250,
          ),
          const SizedBox(height: 20),
          Text(
            "Tu carrito está vacío.",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () {
              // Aquí puedes redirigir al usuario a la tienda u otra página
            },
            child: const Text("Ir a la tienda"),
          ),
        ],
      ),
    );
  }

  // Vista principal del carrito
  Widget buildCartView(BuildContext context) {
    final CartController cartController = Get.find<CartController>(); // Usamos Get.find() para acceder al controlador

    // Usamos un Obx() para reaccionar a los cambios en el carrito
    return Obx(() {
      if (cartController.cartItems.isEmpty) {
        // Si no hay elementos en el carrito, mostramos la vista de carrito vacío
        return emptyCartView(context);
      } else {
        // Si hay productos en el carrito, se mostraría la lista de productos
        return CustomScrollView(
          slivers: [
            SliverAppBar.medium(
              centerTitle: true,
              title: Row(
                children: [
                  const Icon(EvaIcons.shopping_cart, size: 24),
                  const SizedBox(width: 18),
                  Text(
                    "Lista de Compras",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    EvaIcons.trash_2_outline,
                    size: 22,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    // Limpiar el carrito
                    cartController.clearCart();  // Asegúrate de que el controlador tenga este método
                  },
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  // Obtener el producto del carrito
                  dynamic item = cartController.cartItems[index]; // Usamos dynamic para manejar tanto Box como Producto

                  return ListTile(
                    leading: Image.network(
                      item is Producto ? item.imagen : item.imagen, // Usa propiedades comunes
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item is Producto ? item.nombre : item.nombre),
                    subtitle: Text("\$${item is Producto ? item.precio.toStringAsFixed(2) : item.precio.toStringAsFixed(2)}"),
                    trailing: IconButton(
                      icon: const Icon(EvaIcons.trash_2_outline),
                      onPressed: () {
                        // Eliminar del carrito (maneja la eliminación según el tipo)
                        if (item is Producto) {
                          cartController.removeFromCart(item); // Eliminar Producto
                        } else if (item is Box) {
                          cartController.removeFromCart(item); // Eliminar Box
                        }
                      },
                    ),
                  );
                },
                childCount: cartController.cartItems.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total: ",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Obx(() {
                      return Text(
                        "\$${cartController.total.toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    });
  }

  // Vista cuando no hay sesión iniciada
  Center nonSessionCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/vectors/undraw_notify_re_65on.svg',
            width: 350,
          ),
          const SizedBox(height: 50),
          Text(
            "Para acceder a esta funcionalidad, inicia sesión o regístrate con tu correo electrónico.",
            style: Theme.of(context).textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text("Iniciar Sesión"),
              ),
              const SizedBox(width: 18),
              FilledButton.tonal(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: const Text("Regístrate"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
