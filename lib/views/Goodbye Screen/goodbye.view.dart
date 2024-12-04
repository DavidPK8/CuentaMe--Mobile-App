import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class GoodByeView extends StatelessWidget {
  const GoodByeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Agregar un retraso de 8 segundos para cerrar la aplicación después de que se muestra la pantalla.
    Future.delayed(const Duration(seconds: 8), () {
      SystemNavigator.pop(); // Cerrar la aplicación
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Column(
            children: [
              // Imagen en la parte superior
              Image.asset(
                'assets/images/logo_alt.png',
                scale: 2.5,
              ),
              const SizedBox(height: 40), // Espacio entre la imagen y el texto

              // Contenido centrado
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Muchas gracias por elegirnos",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8), // Espacio entre los textos
                        Text(
                          "¡Regresa pronto!",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(color: Colors.white),
                            const SizedBox(width: 25),
                            Text(
                              "Cerrando sesión...",
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Imagen pegada al fondo inferior
              SvgPicture.asset(
                'assets/vectors/undraw_takeout_boxes_ap54.svg',
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.3, // Ajusta el tamaño según sea necesario
              ),
            ],
          ),
        ),
      ),
    );
  }
}
