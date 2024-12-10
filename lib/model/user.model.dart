class Cliente {
  final String nombre;
  final String correo;
  final String telefono;
  final String password;
  final String direccion;

  Cliente({
    required this.nombre,
    required this.correo,
    required this.telefono,
    required this.password,
    required this.direccion,
  });

  Map<String, dynamic> toJson() {
    return {
      "nombre": nombre,
      "correo": correo,
      "telefono": telefono,
      "password": password,
      "direccion": direccion, // Puede ser null
    };
  }
}
