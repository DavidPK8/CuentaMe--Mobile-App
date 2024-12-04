import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/utils/token.manager.dart';
import 'package:cuentame_tesis/views/Goodbye%20Screen/goodbye.view.dart';
import 'package:cuentame_tesis/views/Login/login.view.dart';
import 'package:cuentame_tesis/views/Register/register.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Verificar si hay un token para decidir qué mostrar
    final bool isLoggedIn = TokenManager().token.isNotEmpty;

    return Scaffold(
      body: isLoggedIn ? sessionProfileCompose(context) : nonSessionProfileCompose(context),
    );
  }
}

Widget nonSessionProfileCompose(BuildContext context) {
  return Stack(
    children: [
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: SvgPicture.asset(
          'assets/vectors/undraw_gift_re_qr17.svg',
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.height * 0.4,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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

Widget pinItem(IconData icon, String text, BuildContext context) {
  return Column(
    children: [
      IconButton.filledTonal(
        onPressed: null,
        icon: Icon(
          icon,
          color: AppColors.primaryColor,
          size: 22,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget sessionProfileCompose(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.account_circle,
          size: 120,
          color: AppColors.primaryColor,
        ),
        const SizedBox(height: 16),
        Text(
          "¡Bienvenido de nuevo!",
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text("Cerrar Sesión", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primaryColor)),
                    content: Text("¿Deseas cerrar tu sesión en esta aplicación?", style: Theme.of(context).textTheme.bodyLarge,),
                    actions: [
                      TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: const Text("Cancelar")
                      ),
                      FilledButton(
                          onPressed: () {
                            // Acción para cerrar sesión
                            TokenManager().clearToken();

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const GoodByeView()),
                            );
                          },
                          child: const Text("Salir")
                      )
                    ],
                  );
                }
            );
          },
          child: const Text("Cerrar sesión"),
        ),
      ],
    ),
  );
}


