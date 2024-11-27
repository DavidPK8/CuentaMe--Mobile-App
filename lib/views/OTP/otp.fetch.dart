import 'package:cuentame_tesis/api/constants/constants.api.dart';
import 'package:get/get.dart';

class OTPService extends GetConnect {
  Future<Response> verifyOTP(String correo, String otp) async {
    const String endpoint = ApiRoutes.verifyOTP;  // Sustituir con el endpoint real

    try {
      final response = await post(
        endpoint,
        {"correo": correo, "otp": otp},  // Los datos que el servidor espera
        headers: {'Content-Type': 'application/json'},
      );
      return response;
    } catch (e) {
      return Response(statusCode: 500, statusText: "Error: $e");
    }
  }
}
