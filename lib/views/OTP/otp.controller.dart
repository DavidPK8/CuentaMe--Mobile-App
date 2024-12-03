import 'dart:convert';

import 'package:cuentame_tesis/views/OTP/otp.fetch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class OTPController extends GetxController {
  final OTPService _otpService = OTPService();

  // Campos observables para manejar el estado
  var isLoading = false.obs;
  var isVerified = false.obs;
  var errorMessage = ''.obs;
  var isResendingOTP = false.obs; // Para manejar el estado del reenviado de OTP

  // Dentro de OTPController
  var otp = "".obs; // Variable para almacenar el OTP verificado

  // Verificar OTP
  Future<void> verifyOTP({
    required String correo,
    required String otpInput,
    required String action, // Nuevo parámetro
    required BuildContext context,
    required VoidCallback onSuccess,
  }) async {
    isLoading.value = true;

    try {
      final response = await _otpService.verifyOTP(correo, otpInput, action);

      isLoading.value = false;

      if (response.statusCode == 200) {
        // Si la verificación es exitosa
        if (action == "verifyAccount") {
          isVerified.value = true;
          onSuccess();
          _showToast(context, "Cuenta verificada exitosamente", isError: false);
        } else if (action == "resetPassword") {
            onSuccess();
          _showToast(
              context, "OTP verificado. Procede a cambiar tu contraseña",
              isError: false);
        }

        onSuccess();
      } else {
        isVerified.value = false;

        // Asigna mensaje del backend si existe
        errorMessage.value = _parseErrorMessage(response.body) ??
            response.reasonPhrase ??
            "Error desconocido";

        // Log detallado para debugging
        print("Error al verificar OTP:");
        print("Estado: ${response.statusCode}");
        print("Cuerpo: ${response.body}");
        print("Headers: ${response.headers}");

        _showToast(context, errorMessage.value);
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();

      // Log de excepción
      print("Excepción al verificar OTP: $e");

      _showToast(context, "Ocurrió un error inesperado: $errorMessage");
    }
  }

  // Método para reenviar OTP
  Future<void> resendOTP({
    required String correo,
    required BuildContext context,
    required VoidCallback onResendSuccess,
  }) async {
    isResendingOTP.value = true;

    try {
      final response = await _otpService.resendOTP(correo);

      isResendingOTP.value = false;

      if (response.statusCode == 200) {
        onResendSuccess();
        _showToast(context, "OTP reenviado exitosamente", isError: false);
      } else {
        errorMessage.value = _parseErrorMessage(response.body) ??
            response.reasonPhrase ??
            "Error desconocido";

        // Log detallado para debugging
        print("Error al reenviar OTP:");
        print("Estado: ${response.statusCode}");
        print("Cuerpo: ${response.body}");
        print("Headers: ${response.headers}");

        _showToast(context, errorMessage.value);
      }
    } catch (e) {
      isResendingOTP.value = false;
      errorMessage.value = e.toString();

      // Log de excepción
      print("Excepción al reenviar OTP: $e");

      _showToast(context, "Ocurrió un error inesperado: $errorMessage");
    }
  }

  // Método para extraer mensaje de error desde el cuerpo de la respuesta
  String? _parseErrorMessage(String? responseBody) {
    try {
      final Map<String, dynamic> decoded = responseBody != null
          ? jsonDecode(responseBody)
          : {};
      return decoded['msg'] as String?;
    } catch (e) {
      print("Error al parsear mensaje de error: $e");
      return null;
    }
  }

  // Método privado para mostrar notificaciones
  void _showToast(BuildContext context, String message, {bool isError = true}) {
    toastification.show(
      context: context,
      type: isError ? ToastificationType.error : ToastificationType.success,
      title: Text(isError ? "Error" : "Éxito"),
      description: Text(message),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 4),
      primaryColor: isError ? Colors.red : Colors.green,
      backgroundColor: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      closeOnClick: true,
      pauseOnHover: false,
    );
  }
}
