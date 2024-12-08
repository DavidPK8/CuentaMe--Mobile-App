import 'package:cuentame_tesis/api/constants/constants.api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoxServices extends GetConnect {

  Future<Response> fetchCajas() async {
    const String endpoint = ApiRoutes.listBoxes;

    try {
      final response = await get(endpoint, headers: {
        'Content-Type': 'application/json',
      });

      debugPrint("Solicitud GET a $endpoint");
      debugPrint("Código de estado: ${response.statusCode}");
      debugPrint("Cuerpo de la respuesta: ${response.body}");

      return response;

    } catch (e) {
      debugPrint("Error al obtener las cajas: $e");
      return const Response(statusCode: 500, statusText: "Error al obtener cajas");
    }
  }

  // Método para obtener una caja por su ID
  Future<Response> getBoxById(String boxId) async {

    final String endpoint = ApiRoutes.listBoxbyId(boxId);

    try {
      final response = await get(endpoint, headers: {
        'Content-Type': 'application/json',
      });

      debugPrint("Solicitud GET a $endpoint");
      debugPrint("Código de estado: ${response.statusCode}");
      debugPrint("Cuerpo de la respuesta: ${response.body}");

      return response;

    } catch (e) {
      debugPrint("Error al obtener la caja: $e");
      return const Response(statusCode: 500, statusText: "Error al obtener la caja");
    }
  }
}
