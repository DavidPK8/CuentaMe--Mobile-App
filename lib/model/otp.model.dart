import 'package:cuentame_tesis/model/user.model.dart';

class OTP {
  final String otp;
  final String correo;

  // Constructor que recibe el OTP y un objeto Cliente para extraer el correo.
  OTP({required this.otp, required Cliente cliente}) : correo = cliente.correo;

  // Método para convertir a JSON si es necesario.
  Map<String, dynamic> toJson() {
    return {
      "otp": otp,
      "correo": correo,
    };
  }

  @override
  String toString() {
    return 'OTP: $otp, Correo: $correo';
  }
}
