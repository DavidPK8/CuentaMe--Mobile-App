import 'package:cuentame_tesis/model/user.model.dart';
import 'package:cuentame_tesis/views/Login/login.fetch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class LoginController extends GetxController{

  final LoginService _loginService = LoginService();

  // Campos observables para manejar el estado
  var isLoading = false.obs;
  var isPasswordVisible = true.obs;

  // Alternar visibilidad de contraseñas
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> loginCLiente({
    required String correo,
    required String password,
    required BuildContext context,
    required VoidCallback onSuccess,
  }) async {
    if (correo.isEmpty || password.isEmpty){
      toastification.show(
        context: context,
        type: ToastificationType.warning,
        title: const Text("Campos incompletos"),
        description: const Text("Por favor, completa todos los campos obligatorios."),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 4),
        primaryColor: Colors.orange,
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        closeOnClick: true,
        pauseOnHover: false,
      );
      return;
    }

    // Verificar si el correo es válido (puedes hacerlo dentro de tu controlador)
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zAolA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(correo)) {
      toastification.show(
        context: context,
        type: ToastificationType.warning,
        title: const Text("Correo inválido"),
        description: const Text("Por favor ingresa un correo válido."),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 4),
        primaryColor: Colors.orange,
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        closeOnClick: true,
        pauseOnHover: false,
      );
      return;
    }

    isLoading.value = true;

    try{

      final Cliente cliente = Cliente(
          nombre: '',
          correo: correo,
          telefono: '',
          password: password
      );

      final response = await _loginService.loginCLiente(cliente);

      if (response.statusCode == 200) {
        debugPrint("Inicio de sesión exitoso: ${response.body}");
        onSuccess();
      } else {
        toastification.show(
          context: context,
          type: ToastificationType.error,
          title: const Text("Error de inicio de sesión"),
          description: Text(response.body?['message'] ?? "Usuario y/o contraseña incorrectos"),
          alignment: Alignment.topCenter,
          autoCloseDuration: const Duration(seconds: 4),
          primaryColor: Colors.red,
          backgroundColor: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          closeOnClick: true,
          pauseOnHover: false,
        );

        onSuccess();
      }
    } catch (e) {
      debugPrint("Error al iniciar sesión: $e");
      toastification.show(
        context: context,
        type: ToastificationType.error,
        title: const Text("Error inesperado"),
        description: Text(e.toString()),
        alignment: Alignment.topCenter,
        autoCloseDuration: const Duration(seconds: 4),
        primaryColor: Colors.red,
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        closeOnClick: true,
        pauseOnHover: false,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
