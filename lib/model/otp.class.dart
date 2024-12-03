class OTPStorage {
  static String otp = "";  // Variable estática para almacenar el OTP

  static void setOTP(String newOtp) {
    otp = newOtp;  // Método para actualizar el OTP
  }

  static String getOTP() {
    return otp;  // Método para obtener el OTP almacenado
  }

  static void clearOTP() {
    otp = "";  // Limpiar OTP cuando ya no sea necesario
  }
}
