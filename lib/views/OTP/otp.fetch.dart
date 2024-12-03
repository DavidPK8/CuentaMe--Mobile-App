import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cuentame_tesis/api/constants/constants.api.dart';

class OTPService {

  // Metodo para verificar OTP
  Future<http.Response> verifyOTP(String correo, String otp, String action) async {
    final url = Uri.parse(ApiRoutes.verifyOTP);
    final headers = {'Content-Type': 'application/json'};
    final body = {
      'correo': correo,
      'otp': otp,
      'action': action, // Nuevo parámetro
    };

    try {
      print("Enviando solicitud POST a $url");
      print("Headers: $headers");
      print("Body: $body");

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      print("Respuesta recibida:");
      print("Estado: ${response.statusCode}");
      print("Cuerpo: ${response.body}");
      print("Headers: ${response.headers}");

      return response;
    } catch (e) {
      print("Excepción al realizar la solicitud: $e");
      rethrow;
    }
  }

  // Metodo para reenviar OTP
  Future<http.Response> resendOTP(String correo) async {
    final url = Uri.parse(ApiRoutes.sendnewOTP);
    final headers = {'Content-Type': 'application/json'};
    final body = {
      'correo': correo,
    };

    try {
      // Imprime datos antes de enviar la solicitud
      print("Enviando solicitud POST a $url");
      print("Headers: $headers");
      print("Body: $body");

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      // Imprime datos después de recibir la respuesta
      print("Respuesta recibida:");
      print("Estado: ${response.statusCode}");
      print("Cuerpo: ${response.body}");
      print("Headers: ${response.headers}");

      return response;
    } catch (e) {
      print("Excepción al realizar la solicitud: $e");
      rethrow; // Permite que otros manejen el error si es necesario
    }
  }
}
