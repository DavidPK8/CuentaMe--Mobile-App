import 'package:cuentame_tesis/model/boxes.model.dart';
import 'package:cuentame_tesis/model/producto.model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  // Lista observable que almacena los productos y cajas del carrito
  var cartItems = <dynamic>[].obs;

  // Función para agregar al carrito (tanto Producto como Box)
  void addToCart(dynamic item) {
    // Verifica si el item ya está en el carrito
    bool exists = cartItems.any((cartItem) => cartItem == item);
    if (!exists) {
      // Si el item no está en el carrito, se agrega
      cartItems.add(item);
    }
  }

  // Función para eliminar un item del carrito
  void removeFromCart(dynamic item) {
    // Elimina el item del carrito si existe
    cartItems.removeWhere((cartItem) => cartItem == item);
  }

  // Función para vaciar el carrito
  void clearCart() {
    cartItems.clear();
  }

  // Obtener el total del carrito
  double get total {
    double sum = 0.0;
    for (var cartItem in cartItems) {
      if (cartItem is Producto) {
        sum += cartItem.precio;
      } else if (cartItem is Box) {
        sum += cartItem.precio;
      }
    }
    return sum;
  }

  // Obtener la cantidad total de artículos en el carrito
  int get itemCount {
    return cartItems.length; // La cantidad total es el tamaño de la lista
  }
}
