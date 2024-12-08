import 'package:cuentame_tesis/views/Profile/options/Address/address.fetch.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddressController extends GetxController {
  final AddressService _addressService = AddressService();

  // Lista de direcciones observables
  var addresses = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  // Obtener direcciones del perfil
  Future<void> fetchAddresses() async {
    isLoading.value = true;

    try {
      final response = await _addressService.fetchAddresses();

      if (response.statusCode == 200) {
        final perfil = response.body['perfil'];

        // Mapeamos las direcciones para incluir todos los campos
        addresses.value = (perfil['direccion'] as List<dynamic>)
            .map((e) => {
          '_id': e['_id'], // Extraemos el ID de cada dirección
          'alias': e['alias'],
          'parroquia': e['parroquia'],
          'callePrincipal': e['callePrincipal'],
          'calleSecundaria': e['calleSecundaria'],
          'numeroCasa': e['numeroCasa'],
          'referencia': e['referencia'],
          'usuario': e['usuario'],
          'Predeterminada': e['isDefault']// Usuario asociado (opcional)
        })
            .toList();
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
    required bool isDefault
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
        isDefault: isDefault
      );

      if (response.statusCode == 201) {
        debugPrint("Dirección agregada exitosamente: ${response.body}");
        await fetchAddresses(); // Actualizar lista de direcciones
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

  Future<void> deleteAddress({
    required String direccionID,
    required VoidCallback onSuccess,
  }) async {
    isLoading.value = true;

    try {
      // Verificar si el ID tiene el formato correcto de un ObjectId
      bool isValidObjectId(String id) {
        return RegExp(r'^[0-9a-fA-F]{24}$').hasMatch(id);
      }

      // Verificar que el direccionID tiene el formato correcto (24 caracteres hexadecimales)
      if (!isValidObjectId(direccionID)) {
        debugPrint("ID de dirección inválido: $direccionID");
        return;
      }

      final response = await _addressService.deleteAddress(direccionID);

      if (response.statusCode == 200) {
        debugPrint("Dirección eliminada exitosamente: ${response.body}");
        await fetchAddresses(); // Actualizar lista de direcciones
        onSuccess();
      } else {
        debugPrint("Error al eliminar la dirección: ${response.statusText}");
        Get.snackbar(
          "Error",
          "No se pudo eliminar la dirección",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint("Excepción al eliminar dirección: $e");
      Get.snackbar(
        "Error",
        "Ocurrió un error al eliminar la dirección",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Actualizar una dirección existente
  Future<void> editAddress({
    required String direccionId,
    required String alias,
    required String parroquia,
    required String callePrincipal,
    required String calleSecundaria,
    required String numeroCasa,
    required String referencia,
    required bool isDefault,
    required VoidCallback onSuccess,
  }) async {
    isLoading.value = true;

    try {
      final response = await _addressService.editAddress(
        direccionId: direccionId,
        alias: alias,
        parroquia: parroquia,
        callePrincipal: callePrincipal,
        calleSecundaria: calleSecundaria,
        numeroCasa: numeroCasa,
        referencia: referencia,
        isDefault: isDefault
      );

      if (response.statusCode == 200) {
        debugPrint("Dirección actualizada exitosamente: ${response.body}");
        await fetchAddresses(); // Actualizar lista de direcciones
        onSuccess();
      } else {
        debugPrint("Error al actualizar la dirección: ${response.statusText}");
        Get.snackbar(
          "Error",
          "No se pudo actualizar la dirección",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      debugPrint("Excepción al actualizar dirección: $e");
      Get.snackbar(
        "Error",
        "Ocurrió un error al actualizar la dirección",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}