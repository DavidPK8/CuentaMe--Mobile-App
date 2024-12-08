import 'package:cuentame_tesis/components/IconHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.shoppingList, required this.onUpdate});

  final List<Map<String, dynamic>> shoppingList;
  final ValueChanged<List<Map<String, dynamic>>> onUpdate;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<Map<String, dynamic>> _shoppingList;

  @override
  void initState() {
    super.initState();
    _shoppingList = List.from(widget.shoppingList);
  }

  void _removeItem(int index) {
    setState(() {
      _shoppingList.removeAt(index); // Elimina el producto
    });
    widget.onUpdate(_shoppingList); // Actualiza la lista
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      child: _shoppingList.isEmpty ? emptyCart() : nonEmptyCart(),
    );
  }

  Widget headerCompose(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Iconheader(title: "Tu Carrito", icon: Icons.shopping_cart),
        IconButton(
          onPressed: () {
            setState(() {
              _shoppingList.clear();
            });
            widget.onUpdate(_shoppingList.cast<Map<String, dynamic>>());
          },
          icon: const Icon(Icons.delete_rounded),
          tooltip: "Limpiar carrito",
        ),
      ],
    );
  }

  Widget nonEmptyCart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Column(
        children: [
          headerCompose(context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListView.builder(
                itemCount: _shoppingList.length,
                itemBuilder: (context, index) {
                  var product = _shoppingList[index];
                  /*return ListTile(
                    title: Text(product['name']), // Accede al valor 'name' del mapa
                    subtitle: Text("${product['price']}"), // Muestra el precio
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeItem(index),
                    ),
                  );*/
                  return ProductCard(product: product);
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Total: \$0.00", style: Theme.of(context).textTheme.headlineMedium),
              FilledButton.tonal(
                  onPressed: (){},
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.payments_rounded),
                      SizedBox(width: 12,),
                      Text("Pagar")
                    ],
                  )
              )
            ],
          )
        ],
      ),
    );
  }

  Widget emptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/vectors/undraw_empty_cart_co35.svg', width: 200),
          const SizedBox(height: 45),
          Text(
            "¡Oh no, tu carrito está vacío!",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          Text(
            "Agrega productos a tu carrito y visualízalos aquí.",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 45),
          FilledButton.tonal(
            onPressed: () => Navigator.pop(context),
            child: const Text("Empezar a comprar"),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Imagen
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: product['image'] != null
                  ? Image.network(
                product['image'] ?? '',  // Imagen predeterminada en caso de null
                scale: 2.5,
              )
                  : const Icon(Icons.image_not_supported),  // Icono si no hay imagen
            ),
            // Texto y precio
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre del producto
                  Text(
                    product['name'] ?? 'Producto sin nombre',  // Valor por defecto
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Descripción del producto
                  Text(
                    product['description'] ?? 'Descripción no disponible',  // Valor por defecto
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2, // Limitar a 2 líneas
                  ),
                ],
              ),
            ),
            // Precio
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                product['price']?.toString() ?? 'Precio no disponible',  // Asegurar que no sea null
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}