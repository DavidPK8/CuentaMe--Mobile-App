import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/views/OTP/otp.view.dart';
import 'package:cuentame_tesis/views/Reset%20Password/reset_password.controller.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _resetKey = GlobalKey<FormState>();
  final ResetPasswordController _resetPasswordController = ResetPasswordController();

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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
              child: Text("Ingresa tu correo electrónico para recibr el enlace de recuperación de tu contraseña Cuenta-Me.",
                  style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 18,),
            emailCompose(context),
            Image.asset('assets/images/gifts_decorator.png')
          ],
        ),
      ),
    );
  }

  Widget emailCompose(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: _resetKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            emailInput(),
            const SizedBox(height: 32,),
            submitButton(context)
          ],
        ),
      ),
    );
  }

  TextFormField emailInput() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: "Correo electrónico",
        labelStyle: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 14
        ),
        border: OutlineInputBorder(
          gapPadding: 5,
        ),
        prefixIcon: Icon(
          Icons.email_rounded,
          color: AppColors.primaryColor,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'El correo no puede estar vacío';
        } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zAolA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
          return 'Ingrese un correo válido';
        }
        return null;
      },
      style: Theme.of(context).textTheme.labelMedium,
    );
  }

  FilledButton submitButton(BuildContext context) {
    return FilledButton(
      onPressed: () {
        if (_resetKey.currentState?.validate() ?? false) {
          _resetPasswordController.recuperarPassword(
            correo: _emailController.text,
            context: context,
            onSuccess: () async {
              // Aquí es donde se debería navegar explícitamente
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => OTPView(
                    correo: _emailController.text,
                    action: "resetPassword",
                  ),
                ),
              );
            },
          );
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(EvaIcons.email_outline, size: 20),
          const SizedBox(width: 12),
          Text(
            "Solicitar correo de recuperación",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
