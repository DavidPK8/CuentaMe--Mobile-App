class TokenManager {
  static final TokenManager _instance = TokenManager._internal();

  String token = '';
  String _userId = ''; // Propiedad para almacenar el userId
  String _nombre = ''; // Nueva propiedad para almacenar el nombre del usuario
  String? _boxId;

  factory TokenManager() {
    return _instance;
  }

  TokenManager._internal();

  // Getters y setters para el userId
  String get userId => _userId;

  set userId(String newUserId) {
    _userId = newUserId;
  }

  // Getters y setters para el nombre
  String get nombre => _nombre;

  set nombre(String newNombre) {
    _nombre = newNombre;
  }

  // Método para limpiar los datos de sesión
  void clear() {
    token = '';
    _userId = '';
    _nombre = ''; // Limpiamos también el nombre
  }

  // Método para verificar si el usuario está logueado
  bool isLoggedIn() => token.isNotEmpty && _userId.isNotEmpty && _nombre.isNotEmpty;

  // Método para obtener el ID de la caja almacenada
  String? getBoxId() {
    return _boxId;
  }

  // Método para almacenar el ID de la caja
  void setBoxId(String boxId) {
    _boxId = boxId;
  }
}
