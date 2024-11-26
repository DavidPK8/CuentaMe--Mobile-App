class ApiRoutes{

  //Base URL
  static const String baseURL = "https://cuenta-me.up.railway.app/api";

  // User compose endpoint
  static const String userEndpoint = "$baseURL/user";

  // User endpoints
  static const String  login = "$userEndpoint/login";
  static const String  register = "$userEndpoint/registrarse";
  static const String  addAddress = "$userEndpoint/agregar-direccion";
  static const String  profile = "$userEndpoint/perfil";
  static const String  forgotPassword = "$userEndpoint/recuperar-password";
  static String verifyToken(String token) => "$userEndpoint/recuperar-password/$token";
  static String changePasword(String token) => "$userEndpoint/nuevo-password/$token";
  static const String  sendnewOTP = "$userEndpoint/enviar-otp";
  static const String  verifyOTP = "$userEndpoint/verificar-otp";
  static const String  logout = "$userEndpoint/logout";

  // Endpoints de las ordenes relacionadas con el usuario
  static const String orderEndpint = "$baseURL/ordenes";
  static String seeUserOrders(userId) => "$orderEndpint/cliente/$userId";

}