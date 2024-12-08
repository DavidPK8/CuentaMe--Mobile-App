class Box {
  final String id;
  final String nombre;
  final String descripcion;
  final int stock;
  final double precio;
  final String imagen;
  final int v;

  Box({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.stock,
    required this.precio,
    required this.imagen,
    required this.v,
  });

  // Método para crear un objeto Box desde un JSON
  factory Box.fromJson(Map<String, dynamic> json) {
    return Box(
      id: json['_id'] ?? '', // El ID es el _id en el JSON
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      stock: json['stock'] ?? 0,
      precio: (json['precio'] ?? 0.0).toDouble(),
      imagen: json['imagen'] ?? '',
      v: json['__v'] ?? 0,
    );
  }

  // Método para convertir el objeto Box a un Map (por si necesitas enviarlo en una solicitud POST o similar)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'stock': stock,
      'precio': precio,
      'imagen': imagen,
      '__v': v,
    };
  }
}
