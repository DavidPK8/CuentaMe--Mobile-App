import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class TokenManager {
  static final TokenManager _instance = TokenManager._internal();

  String _token = '';

  factory TokenManager() {
    return _instance;
  }

  TokenManager._internal();

  String get token => _token;

  set token(String newToken) {
    _token = newToken;
  }

  void clearToken() {
    _token = '';
  }

  // Método para obtener el userId desde el token
  String? getUserId() {
    if (_token.isNotEmpty) {
      try {
        // Decodificar el JWT y obtener el 'userId'
        Map<String, dynamic> decodedToken = JwtDecoder.decode(_token);
        return decodedToken['userId']; // O el nombre correcto del campo en el payload
      } catch (e) {
        if (kDebugMode) {
          print("Error al obtener el userId del token: $e");
        }
        return null;
      }
    }
    return null;
  }
}
