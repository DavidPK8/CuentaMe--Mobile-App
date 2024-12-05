import 'package:cuentame_tesis/utils/token.manager.dart';
import 'package:get/get.dart';

import '../../api/constants/constants.api.dart';

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
        // Extrae los campos necesarios
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
}
