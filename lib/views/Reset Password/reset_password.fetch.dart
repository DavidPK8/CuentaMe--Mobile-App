import 'package:cuentame_tesis/api/constants/constants.api.dart';
import 'package:cuentame_tesis/model/user.model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ResetPasswordService extends GetConnect{

  Future<Response> recuperarPassword(Cliente cliente) async{

    const String endpoint = ApiRoutes.forgotPassword;

    try{

      final body = cliente.toJson();
      final headers = {'Content-Type': 'application/json'};

      debugPrint('Enviando solicitud a $endpoint');
      debugPrint('Datos enviados: ${body.toString()}');

      final response = await get(endpoint, query: body, headers: headers);

      if (response.statusCode == 200){
        debugPrint('Registro exitoso');
      } else {
        // Detallar el error si no es 200 OK
        debugPrint('Error en el registro: ${response.statusCode} - ${response.statusText}');
        debugPrint('Cuerpo de la respuesta: ${response.body}');
        debugPrint('Encabezados de la respuesta: ${response.headers}');
      }

      return response;

    }catch (e){
      // En caso de error, devolver un Response con un código 500 y detalles completos del error
      debugPrint('Error en la solicitud: $e');
      return Response(statusCode: 500, statusText: "Error: $e", body: e.toString());
    }
  }
}
