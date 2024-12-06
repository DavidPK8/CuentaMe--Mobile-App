import 'dart:ui';
import 'package:cuentame_tesis/views/Profile/user.fetch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var profileData = {}.obs;
  var addressList = <Map<String, dynamic>>[].obs; // Lista para almacenar las direcciones

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  void fetchProfile() async {
    try {
      isLoading(true);
      final data = await ProfileService().profileCliente();
      if (data != null) {
        profileData.value = data;
      }
    } catch (e) {
      Get.snackbar("Error", "No se pudo cargar el perfil");
    } finally {
      isLoading(false);
    }
  }
}
