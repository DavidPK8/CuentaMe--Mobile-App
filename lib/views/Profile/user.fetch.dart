import 'package:cuentame_tesis/api/constants/constants.api.dart';
import 'package:cuentame_tesis/utils/token.manager.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProfileService extends GetConnect {
  ProfileService() {
    httpClient.timeout = const Duration(seconds: 10);
  }

  // Método para obtener datos específicos del cliente
  Future<Map<String, dynamic>?> profileCliente() async {
    const String endpoint = ApiRoutes.profile;
    final bearerToken = TokenManager().token;

    try {
      final response = await get(
        endpoint,
        headers: {
          'Authorization': 'Bearer $bearerToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final perfil = response.body['perfil'];
        return {
          'nombre': perfil['nombre'],
          'correo': perfil['correo'],
          'telefono': perfil['telefono'],
        };
      } else {
        print('Error al obtener el perfil: ${response.statusText}');
        return null;
      }
    } catch (e) {
      print('Excepción al obtener el perfil: $e');
      return null;
    }
  }

  // Método para agregar una nueva dirección
  Future<Map<String, dynamic>?> addAddress(
      String callePrincipal,
      String calleSecundaria,
      String numeroCasa,
      String referencia,
      ) async {
    const String endpoint = ApiRoutes.addAddress;
    final bearerToken = TokenManager().token;
    final userId = TokenManager().userId; // Obtener el userId

    if (kDebugMode) {
      print('UserId: $userId'); // Imprimir el userId para depuración
    }

    // Construimos el cuerpo de la solicitud
    final body = {
      'usuario': userId,
      'callePrincipal': callePrincipal,
      'calleSecundaria': calleSecundaria,
      'numeroCasa': numeroCasa,
      'referencia': referencia,
    };

    try {
      // Realizamos la solicitud POST
      final response = await post(endpoint, body, headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json',
      });

      if (kDebugMode) {
        print('Código de estado de la respuesta: ${response.statusCode}');
        print('Mensaje de la respuesta: ${response.statusText}');
        print('Cuerpo de la respuesta: ${response.body}');
      }

      // Verificamos si la respuesta fue exitosa
      if (response.statusCode == 201) {
        if (kDebugMode) {
          print('Dirección agregada con éxito: ${response.body}');
        }
        return response.body; // Si fue exitosa, devolvemos el cuerpo de la respuesta
      } else {
        // Si la respuesta no es exitosa, imprimimos los detalles del error
        if (kDebugMode) {
          print('Error al agregar dirección:');
          print('Código de estado: ${response.statusCode}');
          print('Mensaje: ${response.statusText}');
          print('Cuerpo de la respuesta: ${response.body}');
        }
        return null; // Si falla, devolvemos null
      }
    } catch (e) {
      if (kDebugMode) {
        print('Excepción al agregar dirección: $e');
      }
      return null; // En caso de excepción, devolvemos null
    }
  }
}
