import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/utils/token.manager.dart';
import 'package:cuentame_tesis/views/Categories/Boxes/boxes.controller.dart';
import 'package:cuentame_tesis/views/Shopping%20Cart/cart.controller.dart';
import 'package:cuentame_tesis/views/Shopping%20Cart/cart.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../model/boxes.model.dart';

class BoxesView extends StatefulWidget {
  const BoxesView({super.key});

  @override
  State<BoxesView> createState() => _BoxesViewState();
}

class _BoxesViewState extends State<BoxesView> {
  final BoxesController _controller = Get.put(BoxesController());
  String selectedOrder = 'Nombre';

  void ordenarProductos(String criterio) {
    setState(() {
      if (criterio == 'Nombre') {
        _controller.cajas.sort((a, b) => a.nombre.compareTo(b.nombre));
      } else if (criterio == 'Precio') {
        _controller.cajas.sort((a, b) => a.precio.compareTo(b.precio));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.fetchBoxes();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = TokenManager().token.isNotEmpty;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            headerCompose(context, isLoggedIn),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Ordenar Por: ",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: DropdownButton<String>(
                      value: selectedOrder,
                      items: <String>['Nombre', 'Precio']
                          .map((String value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                          .toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedOrder = newValue;
                            ordenarProductos(selectedOrder);
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Obx(() {
                if (_controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (_controller.cajas.isEmpty) {
                  return const Center(child: Text('No se encontraron cajas.'));
                }
                return ListView.builder(
                  itemCount: _controller.cajas.length,
                  itemBuilder: (context, index) {
                    return CajaCard(
                      caja: _controller.cajas[index],
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

Widget headerCompose(BuildContext context, bool isLoggedIn) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.25,
    decoration: const BoxDecoration(
      color: AppColors.cardColor,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      boxShadow: [
        BoxShadow(color: Colors.black45),
      ],
      image: DecorationImage(
        image: AssetImage("assets/images/gifts_bg_2.png"),
        fit: BoxFit.cover,
      ),
    ),
    child: Stack(
      children: [
        isLoggedIn
            ? Positioned(
          right: 12,
          top: 12,
          child: IconButton.filledTonal(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return const CartScreen(); // Aquí mostramos el carrito como un bottom sheet
                },
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                isScrollControlled: true, // Permite que el contenido tenga un tamaño dinámico
              );
            },
            icon: const Icon(
              EvaIcons.shopping_cart,
              color: AppColors.primaryColor,
              size: 22,
            ),
          ),
        )
            : const SizedBox.shrink(),
        Positioned(
          left: 12,
          top: 12,
          child: IconButton.filledTonal(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              EvaIcons.close_outline,
              color: AppColors.primaryColor,
              size: 22,
            ),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Text(
              "Cajas de regalo",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class CajaCard extends StatelessWidget {
  final Box caja;

  const CajaCard({super.key, required this.caja});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return CajaDetailModal(
              caja: caja,
            );
          },
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        child: Row(
          children: [
            Hero(
              tag: caja.nombre,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  caja.imagen,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      caja.nombre,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "\$${caja.precio.toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CajaDetailModal extends StatelessWidget {
  final Box caja;

  const CajaDetailModal({super.key, required this.caja});

  @override
  Widget build(BuildContext context) {
    // Usar Get.find para obtener la instancia del controlador CartController
    final CartController cartController = Get.put(CartController());
    final bool isLoggedIn = TokenManager().token.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Imagen del producto ajustada
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              caja.imagen,
              height: 200, // Aquí limitamos la altura de la imagen
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),

          // Precio del producto
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Título del producto
              Flexible(
                child: Text(
                  caja.nombre,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 25),
              Text(
                "\$${caja.precio.toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor, // Color verde para el precio
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text("Descripción", style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.start,),

          const SizedBox(height: 12),
          // Descripción
          Text(
            caja.descripcion, // Asumiendo que tienes una descripción en la caja
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 16),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isLoggedIn ?
              FilledButton.tonal(
                  onPressed: () {
                    cartController.addToCart(caja);  // Agregar al carrito
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${caja.nombre} agregado al carrito")),
                    );
                  },
                  child: const Text("Agregar al carrito")
              )
                  :
                  Flexible(
                    child: Text("Para adquirir este producto, inicia sesión con tu cuenta.",
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,),
                  )
            ],
          )
        ],
      ),
    );
  }
}
