import 'package:cuentame_tesis/api/constants/constants.api.dart';
import 'package:cuentame_tesis/model/user.model.dart';
import 'package:cuentame_tesis/utils/token.manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginService extends GetConnect {
  Future<Response> loginCliente(Cliente cliente) async {
    const String endpoint = ApiRoutes.login;

    try {
      // Serializamos el cliente a JSON
      final body = cliente.toJson();
      // Aseguramos que el encabezado esté configurado correctamente
      final headers = {'Content-Type': 'application/json'};

      debugPrint('Enviando solicitud a $endpoint');
      debugPrint('Datos enviados: ${body.toString()}');

      // Realizamos la solicitud POST
      final response = await post(endpoint, body, headers: headers);

      // Verificamos la respuesta de la API
      if (response.statusCode == 200) {
        debugPrint('Inicio de sesión exitoso');

        // Extraer el token y el ID del usuario del cuerpo de la respuesta
        final token = response.body['token'];
        final userId = response.body['usuario']['id'];

        if (token != null && userId != null) {
          // Almacenar el token y el userId en TokenManager
          TokenManager().token = token;
          TokenManager().userId = userId;

          debugPrint('Token almacenado: $token');
          debugPrint('ID de usuario almacenado: $userId');
        } else {
          debugPrint('Token o ID de usuario no presente en la respuesta.');
        }
      } else {
        // Detallar el error si no es 200 OK
        debugPrint('Error en el inicio de sesión: ${response.statusCode} - ${response.statusText}');
        debugPrint('Cuerpo de la respuesta: ${response.body}');
        debugPrint('Encabezados de la respuesta: ${response.headers}');
      }

      return response;
    } catch (e) {
      // En caso de error, devolver un Response con un código 500 y detalles completos del error
      debugPrint('Error en la solicitud: $e');
      return Response(statusCode: 500, statusText: "Error: $e", body: e.toString());
    }
  }
}
