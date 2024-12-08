import 'package:cuentame_tesis/api/constants/constants.api.dart';
import 'package:cuentame_tesis/utils/token.manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressService extends GetConnect {

  // Obtener direcciones desde el perfil del cliente
  Future<Response> fetchAddresses() async {
    const String endpoint = ApiRoutes.profile;
    final bearerToken = TokenManager().token;

    try {
      // Realizamos la solicitud GET
      final response = await get(endpoint, headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json',
      });

      // Imprimimos detalles de la respuesta para depuración
      debugPrint("Solicitud GET a $endpoint");
      debugPrint("Código de estado: ${response.statusCode}");
      debugPrint("Cuerpo de la respuesta: ${response.body}");

      return response;
    } catch (e) {
      debugPrint("Error al obtener direcciones: $e");
      return const Response(statusCode: 500, statusText: "Error al obtener direcciones");
    }
  }

  // Agregar una nueva dirección
  Future<Response> addAddress({
    required String alias,
    required String parroquia,
    required String callePrincipal,
    required String calleSecundaria,
    required String numeroCasa,
    required String referencia,
    required bool isDefault
  }) async {
    const String endpoint = ApiRoutes.addAddress;
    final bearerToken = TokenManager().token;
    final userId = TokenManager().userId;

    final body = {
      'usuario': userId,
      'alias': alias,
      'parroquia': parroquia,
      'callePrincipal': callePrincipal,
      'calleSecundaria': calleSecundaria,
      'numeroCasa': numeroCasa,
      'referencia': referencia,
      'predeterminada': isDefault
    };

    try {
      // Realizamos la solicitud POST
      final response = await post(endpoint, body, headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json',
      });

      // Imprimimos detalles de la respuesta para depuración
      debugPrint("Solicitud POST a $endpoint");
      debugPrint("Código de estado: ${response.statusCode}");
      debugPrint("Cuerpo de la respuesta: ${response.body}");

      return response;
    } catch (e) {
      debugPrint("Error al agregar dirección: $e");
      return const Response(statusCode: 500, statusText: "Error al agregar dirección");
    }
  }

  // Actualizar una dirección existente
  Future<Response> editAddress({
    required String direccionId,
    required String alias,
    required String parroquia,
    required String callePrincipal,
    required String calleSecundaria,
    required String numeroCasa,
    required String referencia,
    required bool? isDefault
  }) async {
    final String endpoint = '${ApiRoutes.editAddress}/$direccionId'; // Asegúrate de que el endpoint esté bien formado
    final bearerToken = TokenManager().token;

    final body = {
      'alias': alias,
      'parroquia': parroquia,
      'callePrincipal': callePrincipal,
      'calleSecundaria': calleSecundaria,
      'numeroCasa': numeroCasa,
      'referencia': referencia,
      'predeterminada': isDefault
    };

    try {
      // Realizamos la solicitud PUT
      final response = await put(endpoint, body, headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json',
      });

      // Imprimimos detalles de la respuesta para depuración
      debugPrint("Solicitud PUT a $endpoint");
      debugPrint("Código de estado: ${response.statusCode}");
      debugPrint("Cuerpo de la respuesta: ${response.body}");

      return response;
    } catch (e) {
      debugPrint("Error al actualizar la dirección: $e");
      return const Response(statusCode: 500, statusText: "Error al actualizar la dirección");
    }
  }

  // Eliminar una dirección existente
  Future<Response> deleteAddress(String direccionId) async {
    final String endpoint = '${ApiRoutes.deleteAddress}/$direccionId'; // Asegúrate de que el endpoint esté bien formado
    final bearerToken = TokenManager().token;

    try {
      // Realizamos la solicitud DELETE
      final response = await delete(endpoint, headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json',
      });

      // Imprimimos detalles de la respuesta para depuración
      debugPrint("Solicitud DELETE a $endpoint");
      debugPrint("Código de estado: ${response.statusCode}");
      debugPrint("Cuerpo de la respuesta: ${response.body}");

      return response;
    } catch (e) {
      debugPrint("Error al eliminar la dirección: $e");
      return const Response(statusCode: 500, statusText: "Error al eliminar la dirección");
    }
  }

}
