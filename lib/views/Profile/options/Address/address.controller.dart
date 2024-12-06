import 'package:cuentame_tesis/views/Profile/options/Address/address.fetch.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddressController extends GetxController {
  final AddressService _addressService = AddressService();

  // Lista de direcciones observables
  var addresses = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  // Obtener direcciones del perfil
  Future<void> fetchAddresses() async {
    isLoading.value = true;

    try {
      final response = await _addressService.fetchAddresses();

      if (response.statusCode == 200) {
        final perfil = response.body['perfil'];
        addresses.value = (perfil['direccion'] as List<dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .toList();

        debugPrint("Direcciones obtenidas: ${addresses.value}");
      } else {
        debugPrint("Error al obtener direcciones: ${response.statusText}");
        Get.snackbar(
          "Error",
          "No se pudieron obtener las direcciones",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint("Excepción al obtener direcciones: $e");
      Get.snackbar(
        "Error",
        "Ocurrió un error al obtener las direcciones",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Agregar una nueva dirección
  Future<void> addAddress({
    required String alias,
    required String parroquia,
    required String callePrincipal,
    required String calleSecundaria,
    required String numeroCasa,
    required String referencia,
    required VoidCallback onSuccess,
  }) async {
    isLoading.value = true;

    try {
      final response = await _addressService.addAddress(
        alias: alias,
        parroquia: parroquia,
        callePrincipal: callePrincipal,
        calleSecundaria: calleSecundaria,
        numeroCasa: numeroCasa,
        referencia: referencia,
      );

      if (response.statusCode == 201) {
        debugPrint("Dirección agregada exitosamente: ${response.body}");
        onSuccess();
      } else {
        debugPrint("Error al agregar dirección: ${response.statusText}");
        Get.snackbar(
          "Error",
          "No se pudo agregar la dirección",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint("Excepción al agregar dirección: $e");
      Get.snackbar(
        "Error",
        "Ocurrió un error al agregar la dirección",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
