import 'package:cuentame_tesis/components/loadScreen.dart';
import 'package:cuentame_tesis/model/user.model.dart';
import 'package:cuentame_tesis/views/Reset%20Password/reset_password.fetch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class ResetPasswordController extends GetxController {
  final ResetPasswordService _resetPasswordService = ResetPasswordService();
  var isLoading = false.obs;

  // Variable para almacenar el OTP recibido
  String? otp;

  // Enviar correo de recuperación de contraseña (sin cambios)
  Future<void> recuperarPassword({
    required String correo,
    required BuildContext context, required VoidCallback onSuccess,
  }) async {
    if (correo.isEmpty) {
      _showToast(
        context,
        ToastificationType.warning,
        "Campos incompletos",
        "Por favor, completa todos los campos obligatorios.",
      );
      return;
    }

    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(correo)) {
      _showToast(
        context,
        ToastificationType.warning,
        "Correo inválido",
        "Por favor ingresa un correo válido.",
      );
      return;
    }

    isLoading.value = true;

    Cliente cliente = Cliente(
        correo: correo,
        nombre: '',
        telefono: '',
        password: ''
    );

    try {
      final response = await _resetPasswordService.recuperarPassword(cliente);

      if (response.statusCode == 200) {

        await Future.delayed(const Duration(milliseconds: 500));

        onSuccess();

      } else {
        _showErrorDialog(
          context,
          "Error",
          response.body['msg'] ?? "Error al enviar el correo.",
        );
      }
    } catch (e) {
      _showToast(
        context,
        ToastificationType.error,
        "Error inesperado",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verificarOtp({
    required String otp,
    required BuildContext context,
    required VoidCallback onSuccess,
  }) async {
    isLoading.value = true;

    try {
      final response = await _resetPasswordService.verificarOtp(otp);

      if (response.statusCode == 200) {
        // Aquí asumimos que el backend confirma la validez del OTP y retorna éxito.
        this.otp = otp; // Guardamos el OTP validado
        print("OTP verificado y almacenado: $otp");

        _showSuccessDialog(
          context,
          "OTP válido",
          "Continúa para restablecer tu contraseña.",
        );

        await Future.delayed(const Duration(seconds: 2));
        onSuccess();
      } else {
        _showErrorDialog(
          context,
          "OTP inválido",
          response.body['msg'] ?? "El OTP no es válido o ha expirado.",
        );
      }
    } catch (e) {
      _showToast(
        context,
        ToastificationType.error,
        "Error inesperado",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> cambiarContrasena({
    required String nuevaContrasena,
    required String confirmContrasena,
    required BuildContext context,
    required VoidCallback onSuccess
  }) async {
    if (nuevaContrasena.isEmpty || nuevaContrasena.length < 6) {
      _showToast(
        context,
        ToastificationType.warning,
        "Contraseña inválida",
        "La contraseña debe tener al menos 6 caracteres.",
      );
      return;
    }

    isLoading.value = true;

    try {
      print("OTP almacenado antes de cambiar contraseña: $otp");

      // Verificar que el OTP esté disponible
      if (otp == null || otp!.isEmpty) {
        _showToast(
          context,
          ToastificationType.error,
          "OTP no verificado",
          "Por favor, verifica el OTP antes de cambiar la contraseña.",
        );
        return;
      }

      // Realizar la solicitud de cambio de contraseña
      final response = await _resetPasswordService.cambiarContrasena(otp!, nuevaContrasena, confirmContrasena);

      if (response.statusCode == 200) {

       Navigator.pushReplacement(
           context,
          MaterialPageRoute(
              builder: (context) => const Loadscreen(description: 'Espere mientras cambiamos su contraseña...')
          )
       );

        await Future.delayed(const Duration(milliseconds: 800));

        onSuccess();

      } else {
        _showErrorDialog(
          context,
          "Error",
          response.body['msg'] ?? "Error al cambiar la contraseña.",
        );
      }
    } catch (e) {
      _showToast(
        context,
        ToastificationType.error,
        "Error inesperado",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Método para mostrar un Toast (sin cambios)
  void _showToast(BuildContext context, ToastificationType type, String title, String description) {
    toastification.show(
      context: context,
      type: type,
      title: Text(title),
      description: Text(description),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 4),
      primaryColor: type == ToastificationType.error ? Colors.red : Colors.green,
      backgroundColor: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      closeOnClick: true,
      pauseOnHover: false,
    );
  }

  // Método para mostrar un diálogo de éxito (sin cambios)
  void _showSuccessDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Icon(Icons.check_circle, color: Colors.green),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Entendido"),
            ),
          ],
        );
      },
    );
  }

  // Método para mostrar un diálogo de error (sin cambios)
  void _showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Icon(Icons.error, color: Colors.red),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Entendido"),
            ),
          ],
        );
      },
    );
  }
}
