import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/utils/token.manager.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class BoxesView extends StatefulWidget {
  BoxesView({super.key});

  @override
  State<BoxesView> createState() => _BoxesViewState();
}

class _BoxesViewState extends State<BoxesView> {
  // Lista de cajas con datos de ejemplo
  List<Map<String, dynamic>> cajas = [
    {
      "nombre": "Caja de Dulces",
      "descripcion": "Caja de chocolates, caramelos y bombones.",
      "contenido": ["Chocolates", "Caramelos", "Bombones"],
      "precio": 25.50,
      "imagen": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVUjXOkKhssD0XLf0IZk8lkNYRGtnFq5-1VA&s",
    },
    {
      "nombre": "Caja de Navidad",
      "descripcion": "Caja de regalo con productos navideños.",
      "contenido": ["Árbol de Navidad", "Taza navideña", "Galletas"],
      "precio": 35.00,
      "imagen": "https://i.pinimg.com/736x/61/58/44/6158449f20425f91701b51cac9fde28f.jpg",
    },
    {
      "nombre": "Caja de Fiesta",
      "descripcion": "Caja con artículos para una fiesta.",
      "contenido": ["Globos", "Vasos", "Platos"],
      "precio": 18.75,
      "imagen": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgQ6F4yIbHkd12w-60_7u8vStS639uug4V6Q&s",
    },
    {
      "nombre": "Caja de Sorpresas",
      "descripcion": "Caja con diferentes productos de regalo sorpresa.",
      "contenido": ["Juguetes", "Accesorios", "Artículos de papelería"],
      "precio": 40.00,
      "imagen": "https://i.pinimg.com/736x/20/00/ae/2000ae3c34959519c4c8f17df9e1356e.jpg",
    },
    {
      "nombre": "Caja de Amor",
      "descripcion": "Caja de regalo con productos para sorprender a tu ser querido.",
      "contenido": ["Perfume", "Rosa", "Chocolates"],
      "precio": 50.00,
      "imagen": "https://i.pinimg.com/originals/3f/87/e1/3f87e1a525357e7e1f2cbd70ea30dcb4.jpg",
    },
  ];

  // Valor seleccionado del dropdown
  String selectedOrder = 'Nombre';

  // Función para ordenar los productos
  void ordenarProductos(String criterio) {
    setState(() {
      if (criterio == 'Nombre') {
        cajas.sort((a, b) => a['nombre'].compareTo(b['nombre']));
      } else if (criterio == 'Precio') {
        cajas.sort((a, b) => a['precio'].compareTo(b['precio']));
      }
    });
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
            // ListView para mostrar las cajas
            Expanded(
              child: ListView.builder(
                itemCount: cajas.length,
                itemBuilder: (context, index) {
                  return CajaCard(caja: cajas[index]);
                },
              ),
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

// Widget para cada tarjeta de caja
class CajaCard extends StatelessWidget {
  final Map<String, dynamic> caja;

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
              tag: caja['nombre'],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  caja['imagen'],
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
                      caja['nombre'],
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "\$${caja['precio'].toStringAsFixed(2)}",
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

// ModalBottomSheet con los detalles de la caja
class CajaDetailModal extends StatefulWidget {
  final Map<String, dynamic> caja;

  const CajaDetailModal({super.key, required this.caja});

  @override
  _CajaDetailModalState createState() => _CajaDetailModalState();
}

class _CajaDetailModalState extends State<CajaDetailModal> {
  final bool isLoggedIn = TokenManager().token.isNotEmpty;
  int cantidad = 1;

  @override
  Widget build(BuildContext context) {
    final List<String> contenido = widget.caja['contenido'];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen de la caja
            Hero(
              tag: widget.caja['nombre'],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.caja['imagen'],
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
                    widget.caja['nombre'],
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                Text(
                  "\$${widget.caja['precio'].toStringAsFixed(2)}",
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
              widget.caja['descripcion'],
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),

            // Contenido
            Text(
              "Contenido:",
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
                    contenido[index],
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