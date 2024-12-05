import 'package:cuentame_tesis/views/Profile/user.controller.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var profileData = {}.obs;

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