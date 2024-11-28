import 'package:cuentame_tesis/views/Login/login.form.dart';
import 'package:cuentame_tesis/views/Reset%20Password/reset_password.view.dart';
import 'package:flutter/material.dart';
import '../../theme/decorations/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            "Iniciar Sesión",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_ios_rounded, size: 18, color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
            // Fondo de imagen
            Positioned.fill(
              child: Image.asset(
                'assets/images/gifts_bg.png',
                scale: 2.5,
                fit: BoxFit.cover,
              ),
            ),
            // Contenido con scroll
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      children: [
                        // HeaderCompose ocupa exactamente el 50% de la pantalla
                        SizedBox(
                          height: constraints.maxHeight * 0.55,
                          child: headerCompose(context),
                        ),
                        // FormCompose se ajusta al contenido
                        formCompose(context),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget headerCompose(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Image.asset(
      'assets/images/logo_complete.png',
      scale: 1.25,
    ),
  );
}

Widget formCompose(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: const BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Ingresa con tu correo y contraseña",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 35),
          const LoginForm(),
          const SizedBox(height: 24),
          resetPasswordButton(context),
        ],
      ),
    ),
  );
}

Widget resetPasswordButton(BuildContext context) {
  return TextButton(
    onPressed: () {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return const ResetPasswordView();
        },
      );
    },
    child: Text(
      "¿Has olvidado tu contraseña?",
      style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.white),
    ),
  );
}
