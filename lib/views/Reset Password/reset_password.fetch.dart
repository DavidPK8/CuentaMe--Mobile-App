import 'package:cuentame_tesis/api/constants/constants.api.dart';
import 'package:cuentame_tesis/model/user.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordService extends GetConnect {

  // Solicitar correo para la recuperación de la contraseña (sin cambios)
  Future<Response> recuperarPassword(Cliente cliente) async {
    const String endpoint = ApiRoutes.forgotPassword;

    try {
      final body = cliente.toJson();
      final headers = {'Content-Type': 'application/json'};

      debugPrint('Enviando solicitud a $endpoint');
      debugPrint('Datos enviados: ${body.toString()}');

      final response = await post(endpoint, body, headers: headers);

      if (response.statusCode == 200) {
        debugPrint('Correo enviado exitosamente');
      } else {
        debugPrint('Error al enviar el correo: ${response.statusCode} - ${response.statusText}');
      }

      return response;
    } catch (e) {
      debugPrint('Error en la solicitud: $e');
      return Response(statusCode: 500, statusText: "Error: $e", body: e.toString());
    }
  }

  // Verificar OTP (anteriormente verificarToken)
  Future<Response> verificarOtp(String otp) async {
    // Cambiamos al endpoint correcto para verificar el OTP
    final String endpoint = ApiRoutes.verifyToken(otp);

    try {
      final headers = {'Content-Type': 'application/json'};

      debugPrint('Enviando solicitud a $endpoint para verificar OTP.');

      final response = await get(endpoint, headers: headers);

      if (response.statusCode == 200) {
        debugPrint('OTP verificado exitosamente.');
      } else {
        debugPrint('Error al verificar el OTP: ${response.statusCode} - ${response.statusText}');
      }

      return response;
    } catch (e) {
      debugPrint('Error en la solicitud verificarOtp: $e');
      return Response(statusCode: 500, statusText: "Error: $e", body: e.toString());
    }
  }

  // Cambiar la contraseña (similar al método anterior, pero usando OTP)
  Future<Response> cambiarContrasena(String correo, String nuevaContrasena, String confirmContrasena) async {
    const String endpoint = ApiRoutes.changePasword;

    try {
      final body = {'correo': correo, "password": nuevaContrasena, "confirmpassword": confirmContrasena};
      final headers = {'Content-Type': 'application/json'};

      debugPrint('Enviando solicitud a $endpoint con $body');
      final response = await post(endpoint, body, headers: headers);
      return response;
    } catch (e) {
      debugPrint('Error en la solicitud cambiarContrasena: $e');
      return Response(statusCode: 500, statusText: "Error: $e", body: e.toString());
    }
  }
}
