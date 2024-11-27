import 'package:cuentame_tesis/views/OTP/otp.fetch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';// Asegúrate de importar tu servicio

class OTPController extends GetxController {
  final OTPService _otpService = OTPService();

  // Campos observables para manejar el estado
  var isLoading = false.obs;
  var isVerified = false.obs;
  var errorMessage = ''.obs;

  // Método para verificar OTP
  Future<void> verifyOTP({
    required String correo,
    required String otp,
    required BuildContext context,
    required VoidCallback onSuccess,  // Llamar a esta función cuando la verificación sea exitosa
  }) async {
    isLoading.value = true;  // Mostrar indicador de carga

    try {
      final response = await _otpService.verifyOTP(correo, otp);

      isLoading.value = false;  // Ocultar indicador de carga

      if (response.isOk) {
        // OTP verificado exitosamente
        onSuccess();  // Ejecutar función en caso de éxito (por ejemplo, ir a la siguiente pantalla)
      } else {
        // Error en la verificación
        isVerified.value = false;
        errorMessage.value = response.statusText ?? "Error desconocido";
        toastification.show(
          context: context,
          type: ToastificationType.error,
          title: const Text("Error en la verificación"),
          description: Text(errorMessage.value),
          alignment: Alignment.topCenter,
          autoCloseDuration: const Duration(seconds: 4),
          primaryColor: Colors.red,
          backgroundColor: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          closeOnClick: true,
          pauseOnHover: false,
        );
      }
    } catch (e) {
      isLoading.value = false;  // Ocultar indicador de carga
      errorMessage.value = e.toString();
      toastification.show(
        context: context,
        type: ToastificationType.error,
        title: const Text("Error"),
        description: Text("Ocurrió un error inesperado: $errorMessage"),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 4),
        primaryColor: Colors.red,
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        closeOnClick: true,
        pauseOnHover: false,
      );
      print('Excepción inesperada: $e');
    }
  }
}
