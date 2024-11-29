import 'package:cuentame_tesis/components/loadScreen.dart';
import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/views/Reset%20Password/reset_password.controller.dart';
import 'package:cuentame_tesis/views/Reset%20Password/success_change.view.dart';
import 'package:flutter/material.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final ResetPasswordController _controller = ResetPasswordController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String? _otp;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.primaryColor,
            title: Text(
              "Cambiar Contraseña",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white
              )
            ,)
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Verificación OTP", style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 16),
                Text(
                  "Ingresa el código de esis dígitos que se te ha enviado a tu dirección de correo electrónico. Recueda que este código tiene validéz de 15 minutos.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16),
                _otpVerificationForm(context, _controller),
                const SizedBox(height: 32),
                if (_otp != null && _otp!.isNotEmpty) ...[
                  Text("Ingresa la nueva contraseña", style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 16),
                  Text(
                    "Tu nueva contraseña debe contener las siguientes características",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 8),
                  Text("* Más de 6 carcateres para mayor seguridad", style: Theme.of(context).textTheme.bodyMedium,),
                  const SizedBox(height: 4),
                  Text("* Mayúsculas, minúsuclas y números.", style: Theme.of(context).textTheme.bodyMedium,),
                  const SizedBox(height: 16),
                  _passwordChangeForm(context, _controller),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _otpVerificationForm(BuildContext context, ResetPasswordController controller) {
    return Column(
      children: [
        // Mostrar el campo de entrada y botón solo si no se está cargando ni se ha verificado el OTP
        if (!controller.isLoading.value && (controller.otp == null || controller.otp!.isEmpty)) ...[
          TextFormField(
            controller: _otpController,
            decoration: const InputDecoration(
              labelText: "Código de verificación",
              prefixIcon: Icon(Icons.security),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          FilledButton.tonal(
            onPressed: () async {
              final otpIngresado = _otpController.text;
              if (otpIngresado.isNotEmpty) {
                await controller.verificarOtp(
                  otp: otpIngresado,
                  context: context,
                  onSuccess: () {
                    // Sincronizar el estado del widget con el controlador
                    setState(() {
                      _otp = controller.otp; // Opcional: Si necesitas mostrarlo localmente
                    });
                  },
                );
              }
            },
            child: const Text("Verificar OTP"),
          ),
        ],

        // Mostrar indicador de progreso mientras se verifica el OTP
        if (controller.isLoading.value) ...[
          const SizedBox(height: 16),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ],

        // Mostrar mensaje de éxito si el OTP ha sido verificado
        if (!controller.isLoading.value && controller.otp != null && controller.otp!.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Center(
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle_outline_rounded, size: 35, color: Colors.green),
                      const SizedBox(height: 12),
                      Text(
                        "Código verificado",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }


  Widget _passwordChangeForm(BuildContext context, ResetPasswordController controller) {
    return Column(
      children: [
        TextFormField(
          controller: _newPasswordController,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            labelText: "Nueva Contraseña",
            suffixIcon: IconButton(
              icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: !_isConfirmPasswordVisible,
          decoration: InputDecoration(
            labelText: "Confirmar Contraseña",
            suffixIcon: IconButton(
              icon: Icon(_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              },
            ),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 32),
        FilledButton.tonal(
          onPressed: () async {
            // Validar contraseñas
            final newPassword = _newPasswordController.text;
            final confirmPassword = _confirmPasswordController.text;

            if (newPassword != confirmPassword) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Las contraseñas no coinciden")),
              );
              return;
            }

            if (newPassword.length < 6) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("La contraseña debe tener al menos 6 caracteres")),
              );
              return;
            }

            // Verificar que el OTP esté disponible en el controlador
            if (controller.otp == null || controller.otp!.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("El OTP no está verificado. Inténtalo de nuevo.")),
              );
              return;
            }

            // Llamar al método cambiarContrasena del controlador
            await controller.cambiarContrasena(
              nuevaContrasena: newPassword,
              confirmContrasena: confirmPassword,
              context: context,
              onSuccess: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SuccessChangePassword()
                    )
                );
              }
            );
          },
          child: const Text("Cambiar Contraseña"),
        ),
      ],
    );
  }
}
