import 'package:cuentame_tesis/model/user.model.dart';
import 'package:cuentame_tesis/views/Register/register.fetch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class RegisterController extends GetxController {
  final ClienteService _clienteService = ClienteService();

  // Campos observables para manejar el estado
  var isLoading = false.obs;
  var isPasswordVisible = true.obs;
  var isPasswordMatch = true.obs;

  // Alternar visibilidad de contraseñas
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Verificar coincidencia de contraseñas
  void checkPasswordMatch(String password, String confirmPassword) {
    isPasswordMatch.value = password == confirmPassword;
  }

  // Registrar cliente
  Future<void> registrarCliente({
    required String nombre,
    required String correo,
    required String telefono,
    required String password,
    String? direccion,
    required BuildContext context,
    required VoidCallback onSuccess,// Contexto proporcionado desde la UI
  }) async {
    // Validar campos vacíos
    if (nombre.isEmpty || correo.isEmpty || telefono.isEmpty || password.isEmpty) {
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

    // Verificar si la contraseña es suficientemente fuerte
    if (password.length < 6) {
      toastification.show(
        context: context,
        type: ToastificationType.warning,
        title: const Text("Contraseña corta"),
        description: const Text("La contraseña debe tener al menos 6 caracteres."),
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

    isLoading.value = true; // Mostrar indicador de carga

    // Crear el cliente
    Cliente cliente = Cliente(
      nombre: nombre,
      correo: correo,
      telefono: telefono,
      password: password,
      direccion: direccion,
    );

    isLoading.value = false; // Oculta el indicador de carga

    try {
      final response = await _clienteService.registrarCliente(cliente);

      isLoading.value = false; // Ocultar el indicador de carga

      if (response.isOk) {
        // Manejo exitoso
        toastification.show(
          context: context,
          type: ToastificationType.success,
          title: const Text("Registro exitoso"),
          description: const Text("El cliente ha sido registrado correctamente."),
          alignment: Alignment.topCenter,
          autoCloseDuration: const Duration(seconds: 4),
          primaryColor: Colors.green,
          backgroundColor: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          closeOnClick: true,
          pauseOnHover: false,
        );
        onSuccess();
      } else {
        // Manejo de errores de la respuesta
        toastification.show(
          context: context,
          type: ToastificationType.error,
          title: const Text("Error en el registro"),
          description: Text(response.statusText ?? "Error desconocido."),
          alignment: Alignment.topCenter,
          autoCloseDuration: const Duration(seconds: 4),
          primaryColor: Colors.red,
          backgroundColor: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          closeOnClick: true,
          pauseOnHover: false,
        );
        print('Error: ${response.statusCode ?? "Error desconocido"}');
      }
    } catch (e) {
      // Capturar cualquier excepción inesperada
      isLoading.value = false; // Ocultar indicador de carga
      toastification.show(
        context: context,
        type: ToastificationType.error,
        title: const Text("Error"),
        description: Text("Ocurrió un error inesperado: $e"),
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
