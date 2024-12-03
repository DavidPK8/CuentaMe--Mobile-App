import 'package:cuentame_tesis/components/loadScreen.dart';
import 'package:cuentame_tesis/model/user.model.dart';
import 'package:cuentame_tesis/views/Reset%20Password/reset_password.fetch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:cuentame_tesis/views/OTP/otp.controller.dart'; // Importamos OTPController

class ResetPasswordController extends GetxController {
  final ResetPasswordService _resetPasswordService = ResetPasswordService();
  final OTPController _otpControllerLogic = Get.put(OTPController()); // Instanciamos OTPController
  var isLoading = false.obs;

  // Variable para almacenar el OTP recibido como RxString
  var otp = "".obs;

  // Enviar correo de recuperación de contraseña
  Future<void> recuperarPassword({
    required String correo,
    required BuildContext context,
    required VoidCallback onSuccess,
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

  // Cambiar la contraseña utilizando el OTP almacenado
  Future<void> cambiarContrasena({
    required String nuevaContrasena,
    required String confirmContrasena,
    required String correo,
    required BuildContext context,
    required VoidCallback onSuccess,
  }) async {
    // Comprobación básica para la nueva contraseña
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

    Cliente cliente = Cliente(
        correo: correo,
        nombre: '',
        telefono: '',
        password: ''
    );

    try {
      // Realizar la solicitud de cambio de contraseña usando el OTP almacenado
      final response = await _resetPasswordService.cambiarContrasena(
        cliente.correo,
        nuevaContrasena,
        confirmContrasena,
      );

      if (response.statusCode == 200) {
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

  // Método para mostrar un Toast
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

  // Método para mostrar un diálogo de error
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
