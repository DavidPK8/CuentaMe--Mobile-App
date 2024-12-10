class Producto {
  final String nombre;
  final String descripcion;
  final int stock;
  final double precio;
  final String imagen;  // Imagen es opcional, puede ser null

  Producto({
    required this.nombre,
    required this.descripcion,
    required this.stock,
    required this.precio,
    required this.imagen,  // Imagen puede ser null
  });

  // Método para crear un objeto Producto desde un Map
  factory Producto.fromMap(Map<String, dynamic> json) {
    return Producto(
      nombre: json['nombre'] ?? '',  // Nombre es obligatorio
      descripcion: json['descripcion'] ?? '',  // Descripción es obligatoria
      stock: json['stock'] ?? 0,  // Stock es obligatorio
      precio: (json['precio'] ?? 0.0).toDouble(),  // Convertir precio a double
      imagen: json['imagen'],  // Imagen es opcional
    );
  }

  // Método para convertir el objeto Producto a un Map
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'stock': stock,
      'precio': precio,
      'imagen': imagen,  // Imagen puede ser null
    };
  }
}
