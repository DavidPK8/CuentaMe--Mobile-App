import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/utils/token.manager.dart';
import 'package:cuentame_tesis/views/Categories/Boxes/boxes.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../model/boxes.model.dart';

class BoxesView extends StatefulWidget {
  BoxesView({super.key});

  @override
  State<BoxesView> createState() => _BoxesViewState();
}

class _BoxesViewState extends State<BoxesView> {
  final BoxesController _controller = Get.put(BoxesController());  // Usamos GetX para acceder al controlador

// Valor seleccionado del dropdown
  String selectedOrder = 'Nombre';

  // Función para ordenar los productos
  void ordenarProductos(String criterio) {
    setState(() {
      if (criterio == 'Nombre') {
        _controller.cajas.sort((a, b) => a.nombre.compareTo(b.nombre));  // Ordenar por nombre
      } else if (criterio == 'Precio') {
        _controller.cajas.sort((a, b) => a.precio.compareTo(b.precio));  // Ordenar por precio
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.fetchBoxes();  // Llamamos a la función para obtener las cajas cuando la vista se carga
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
                            ordenarProductos(selectedOrder);  // Ordenar cajas según el criterio seleccionado
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // ListView para mostrar las cajas
            Expanded(
              child: Obx(() {
                // Mostrar un indicador de carga mientras se obtienen las cajas
                if (_controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Verifica si hay cajas y muestra las tarjetas
                if (_controller.cajas.isEmpty) {
                  return const Center(child: Text('No se encontraron cajas.'));
                }

                return ListView.builder(
                  itemCount: _controller.cajas.length,
                  itemBuilder: (context, index) {
                    return CajaCard(caja: _controller.cajas[index]);
                  },
                );
              }),
            ),
            const SizedBox(width: 25),
          ],
        ),
      ),
    );
  }
}

// Header del screen
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
            onPressed: () {},
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
  final Box caja;  // Cambiar a Box en lugar de Map<String, dynamic>

  const CajaCard({super.key, required this.caja});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Mostrar el ModalBottomSheet con los detalles de la caja
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return CajaDetailModal(caja: caja);
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
              tag: caja.nombre,  // Usar nombre como tag
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
                      "\$${caja.precio.toStringAsFixed(2)}",  // Mostrar precio usando el objeto Box
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

class CajaDetailModal extends StatefulWidget {
  final Box caja;  // Cambiar a Box en lugar de Map<String, dynamic>

  const CajaDetailModal({super.key, required this.caja});

  @override
  _CajaDetailModalState createState() => _CajaDetailModalState();
}

class _CajaDetailModalState extends State<CajaDetailModal> {
  final bool isLoggedIn = TokenManager().token.isNotEmpty;
  int cantidad = 1;

  @override
  Widget build(BuildContext context) {
    // Cambiar a widget.caja.contenido si es una propiedad de Box
    List<String> contenido = widget.caja.descripcion.split(','); // Cambiar si `contenido` está en otra propiedad

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen de la caja
            Hero(
              tag: widget.caja.nombre,  // Usar el nombre de la caja como el tag
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.caja.imagen,  // Usar la propiedad imagen de Box
                  height: 250,
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
                    widget.caja.nombre,  // Usar nombre de Box
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                Text(
                  "\$${widget.caja.precio.toStringAsFixed(2)}",  // Usar precio de Box
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Descripción
            Text(
              widget.caja.descripcion,  // Usar descripción de Box
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),

            // Contenido
            Text(
              "Contenido:",  // Usar el contenido según sea necesario
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: contenido.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.circle, size: 10, color: AppColors.primaryColor),
                  title: Text(
                    contenido[index],  // Usar contenido de la descripción
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              },
            ),

            const Divider(),

            // Controles de cantidad y botón
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
                    // Lógica para agregar al carrito
                  },
                  child: const Text("Agregar al carrito"),
                ),
              ],
            )
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
}
