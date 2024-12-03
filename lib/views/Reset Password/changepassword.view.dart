import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/views/Reset%20Password/success_change.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import necesario para usar Obx
import 'package:cuentame_tesis/views/Reset%20Password/reset_password.controller.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key, required this.correo});

  final String correo;

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final ResetPasswordController _controller = Get.put(ResetPasswordController());
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text('Recuperación de contraseña', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Estimado usuario, ${widget.correo}; para cambiar tu contraseña, recuerda que esta debe tener los siguientes caracteres para ser válida: ",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 10,),
                Text("- Tener mínimo 6 caracteres.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 10,),
                Text("- Poser al menos un número, una letra mayúscula y un caracter especial (%, &, @, etc.).",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24,),
                TextField(
                  controller: _newPasswordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Nueva contraseña',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Confirmar contraseña',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: FilledButton.tonal(
                    onPressed: () {
                      _controller.cambiarContrasena(
                        correo: widget.correo,
                        nuevaContrasena: _newPasswordController.text,
                        confirmContrasena: _confirmPasswordController.text,
                        context: context,
                        onSuccess: () {
                          // Redirigir a la pantalla de éxito
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SuccessChangePassword(),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('Cambiar Contraseña'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
