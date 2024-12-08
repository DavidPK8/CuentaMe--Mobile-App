import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/views/Categories/Boxes/boxes.view.dart';
import 'package:cuentame_tesis/views/Categories/Personalized%20Boxes/personalized_boxes.view.dart';
import 'package:cuentame_tesis/views/Categories/Products/products.view.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "Catálogo",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: cardCompose(
                context,
                "Productos",
                "assets/images/sweets_patern.png",
                const ProductsView(), // Ruta personalizada
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: cardCompose(
                context,
                "Cajas de regalo",
                "assets/images/gifts_bg_2.png",
                BoxesView(), // Ruta personalizada
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: cardCompose(
                context,
                "Personaliza tu caja",
                "assets/images/gifts_bg_3.png",
                const PersonalizedBoxesView(), // Ruta personalizada
              ),
            ),
          ),
        ],
      ),
    );
  }
}


Widget cardCompose(BuildContext context, String title, String path, Widget destination) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => destination,
        ),
      );
    },
    child: Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        children: [
          Hero(
            tag: title, // El tag debe ser único para cada tarjeta
            child: SizedBox.expand( // Ocupa todo el espacio del contenedor padre
              child: Image.asset(
                path,
                fit: BoxFit.cover, // Imagen se ajusta al contenedor
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.black, shadows: [
                  const Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 4.0,
                    color: Colors.black54,
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
