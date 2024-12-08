
class TokenManager {
  static final TokenManager _instance = TokenManager._internal();

  String _token = '';
  String _userId = ''; // Nueva propiedad para almacenar el userId

  factory TokenManager() {
    return _instance;
  }

  TokenManager._internal();

  // Getters y setters para el token
  String get token => _token;

  set token(String newToken) {
    _token = newToken;
  }

  void clearToken() {
    _token = '';
    _userId = ''; // También limpiamos el userId
  }

  // Getters y setters para el userId
  String get userId => _userId;

  set userId(String newUserId) {
    _userId = newUserId;
  }

  // Método para verificar si el token o el userId están disponibles
  bool isLoggedIn() => _token.isNotEmpty && _userId.isNotEmpty;
}
