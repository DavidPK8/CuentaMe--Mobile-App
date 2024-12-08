import 'package:cuentame_tesis/model/boxes.model.dart';
import 'package:cuentame_tesis/utils/token.manager.dart';
import 'package:cuentame_tesis/views/Categories/Boxes/boxes.fetch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BoxesController extends GetxController {
  final BoxServices _boxServices = BoxServices();

  var isLoading = false.obs;
  var cajas = <Box>[].obs;  // Aquí cambiamos a una lista de objetos Box

  // Método para obtener las cajas
  Future<void> fetchBoxes() async {
    isLoading.value = true;
    final response = await _boxServices.fetchCajas();

    if (response.statusCode == 200) {
      // Suponiendo que la respuesta tiene una lista de cajas en el cuerpo
      List<Box> fetchedBoxes = (response.body as List).map((data) => Box.fromJson(data)).toList();
      cajas.value = fetchedBoxes;
    } else {
      // Manejar error
      print('Error al obtener las cajas: ${response.statusText}');
    }
    isLoading.value = false;
  }

  // Obtener una caja por su ID usando el TokenManager
  Future<void> fetchBoxById() async {
    String? boxId = TokenManager().getBoxId();

    if (boxId != null) {
      final response = await _boxServices.getBoxById(boxId);

      if (response.statusCode == 200) {
        debugPrint("Cajas obtenidas con éxito");
      } else {
        debugPrint("Error: ${response.statusCode}");
      }
    } else {
      debugPrint("No se encontró un ID de caja almacenado.");
    }
  }
}
