import 'package:cuentame_tesis/views/Reset%20Password/reset_password.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String? _otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cambiar Contraseña")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Verificación OTP", style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            _otpVerificationForm(),
            const SizedBox(height: 32),
            if (_otp != null && _otp!.isNotEmpty) ...[
              Text("Ingresa la nueva contraseña", style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              _passwordChangeForm(),
            ]
          ],
        ),
      ),
    );
  }

  Widget _otpVerificationForm() {
    return Column(
      children: [
        // Si el OTP no ha sido verificado, mostrar el campo de entrada y el botón
        if (_otp == null || _otp!.isEmpty) ...[
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
          ElevatedButton(
            onPressed: () {
              // Simulamos la verificación del OTP
              setState(() {
                _otp = _otpController.text;
              });
            },
            child: const Text("Verificar OTP"),
          ),
        ],

        // Si el OTP ha sido verificado, mostrar el mensaje de éxito
        if (_otp != null && _otp!.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text(
            "Código verificado",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ],
    );
  }

  Widget _passwordChangeForm() {
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
        ElevatedButton(
          onPressed: _changePassword,
          child: const Text("Cambiar Contraseña"),
        ),
      ],
    );
  }

  void _changePassword() {
    // Verificamos si las contraseñas coinciden
    if (_newPasswordController.text == _confirmPasswordController.text) {
      // Llamamos a la lógica del controlador para cambiar la contraseña
      // Asegúrate de enviar el OTP junto con la nueva contraseña
      String nuevaContrasena = _newPasswordController.text;

      // Usamos el ResetPasswordController para cambiar la contraseña
      final resetPasswordController = Get.put(ResetPasswordController()); // Obtener instancia del controlador

      resetPasswordController.cambiarContrasena(// El OTP ya debería haber sido verificado y almacenado
        nuevaContrasena: nuevaContrasena,
        context: context,
      );
    } else {
      _showToast("Las contraseñas no coinciden.");
    }
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
