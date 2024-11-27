import 'package:cuentame_tesis/views/Login/login.form.dart';
import 'package:flutter/material.dart';
import '../../theme/decorations/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/images/gifts_decorator.png',
                          scale: 1.25,
                        ),
                      ),
                      bodyCompose(context),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget bodyCompose(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      headerCompose(context),
      formCompose(context),
      const Spacer()
    ],
  );
}

Widget headerCompose(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.4,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Image.asset(
        'assets/images/logo_complete.png',
        scale: 1.25,
      ),
    ),
  );
}

Widget formCompose(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32),
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Ingresa con tu correo y contraseña",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            const LoginForm(),
          ],
        ),
      ),
    ),
  );
}
