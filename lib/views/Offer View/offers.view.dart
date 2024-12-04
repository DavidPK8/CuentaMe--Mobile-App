import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Imagen en la parte inferior
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                'assets/vectors/undraw_gifts_0ceh.svg',
                width: MediaQuery.of(context).size.width * 0.8, // Ajustar tamaño según el ancho de la pantalla
                fit: BoxFit.contain,
              ),
            ),
            // Contenido centrado
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Descubre nuestras ofertas más importantes",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  Text(
                    "Próximamente",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
