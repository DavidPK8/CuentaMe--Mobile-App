import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:flutter/material.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Recupera tu contraseña", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primaryColor)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
              child: Text("Ingresa tu correo electrónico para recibr el enlace de recuperación de tu contraseña Cuenta-Me.",
                  style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,
              ),
            ),
            Image.asset('assets/images/gifts_decorator.png')
          ],
        ),
      ),
    );
  }
}
