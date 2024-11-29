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
        otp = response.body['otp'];  // Asumiendo que el OTP viene en la respuesta
        _showSuccessDialog(
          context,
          "Correo enviado",
          "Revisa tu bandeja de entrada para continuar con el proceso.",
        );

        await Future.delayed(const Duration(milliseconds: 300));

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
        // Guardamos el OTP en el controlador solo cuando la verificación es exitosa
        this.otp = otp;
        print("OTP verificado y guardado: $otp");  // Asegúrate de que este print se ejecute.

        _showSuccessDialog(
          context,
          "OTP válido",
          "Continúa para restablecer tu contraseña.",
        );

        await Future.delayed(const Duration(seconds: 2));

        onSuccess();  // Navegar o cambiar la UI según el flujo
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
    required BuildContext context,
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
      // Debug: Imprimir el valor del OTP para verificar que está almacenado correctamente
      print("OTP almacenado en cambiarContrasena: $otp");

      // Verificamos que el OTP esté almacenado
      if (otp == null || otp!.isEmpty) {
        _showToast(
          context,
          ToastificationType.error,
          "OTP no verificado",
          "Por favor, verifica el OTP antes de cambiar la contraseña.",
        );
        return;
      }

      // Realizamos la solicitud de cambio de contraseña con el OTP verificado
      final response = await _resetPasswordService.cambiarContrasena(otp!, nuevaContrasena);  // Enviamos el OTP almacenado

      if (response.statusCode == 200) {
        _showSuccessDialog(
          context,
          "Contraseña actualizada",
          "Tu contraseña ha sido cambiada exitosamente.",
        );

        await Future.delayed(const Duration(milliseconds: 300));

        Navigator.pop(context);
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
