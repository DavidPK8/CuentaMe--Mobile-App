import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/views/Login/login.view.dart';
import 'package:cuentame_tesis/views/Register/register.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: nonSessionProfileCompose(context)
    );
  }
}

Widget nonSessionProfileCompose(BuildContext context) {
  return Stack(
    children: [
      // Imagen de fondo anclada en la parte inferior
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: SvgPicture.asset(
          'assets/vectors/undraw_gift_re_qr17.svg',
          fit: BoxFit.contain, // Asegura que la imagen no se recorte
          height: MediaQuery.of(context).size.height * 0.4, // Ajusta la altura
        ),
      ),
      // Contenido principal en la parte superior
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Espaciador para empujar el contenido hacia arriba
            const SizedBox(height: 32),
            Text(
              "Inicia sesión para obtener una experiencia personalizada y conocer más sobre nuestros productos.",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: pinItem(EvaIcons.gift_outline, "Regalos a tu elección", context),
                ),
                Flexible(
                  child: pinItem(EvaIcons.shopping_bag_outline, "Personalización dinámica", context),
                ),
                Flexible(
                  child: pinItem(EvaIcons.car_outline, "Facilidades de entrega", context),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text("Iniciar Sesión"),
                ),
                const SizedBox(height: 16),
                FilledButton.tonal(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: const Text("Regístrate"),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget pinItem(IconData icon, String text, BuildContext context){
  return Column(
    children: [
      IconButton.filledTonal(
          onPressed: null,
          icon: Icon(icon, color: AppColors.primaryColor, size: 22,)
      ),
      const SizedBox(height: 8,),
      Text(text, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center,)
    ],
  );
}

Widget sessionprofileCompose(){
  return Column(
    children: [],
  );
}
