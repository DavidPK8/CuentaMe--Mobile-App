import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/utils/token.manager.dart';
import 'package:cuentame_tesis/views/Shopping%20Cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

// Modelo de Producto (simulando los productos)
List<Map<String, dynamic>> productos = [
  {
    "nombre": "Manicho 28gr",
    "descripcion": "Chocolate con leche, en barra, relleno con trozos de mani.",
    "precio": 0.50,
    "imagen":
        "https://tofuu.getjusto.com/orioneat-prod/br23dyqs7cwsJdZTx-1012379.jpg",
  },
  {
    "nombre": "Chocolates Bon O Bon (Caja x30)",
    "descripcion":
        "Caja de bobones rellenos de avellana con cubierta de chocolate.",
    "precio": 4.35,
    "imagen":
        "https://rosendoguaman.com.ec/wp-content/uploads/2020/05/7802225511513BONOBON30.png",
  },
  {
    "nombre": "Capibara Musculoso",
    "descripcion":
        "Peluche decorativo inspirado en el animal de moda mas tierno del mundo",
    "precio": 15.99,
    "imagen":
        "https://kokostation.com/wp-content/uploads/capibara-musculoso.webp",
  },
  {
    "nombre": "Flores tejidas",
    "descripcion": "Flores tejidas en lana, con diferentes motivos y colores.",
    "precio": 8.00,
    "imagen":
        "https://m.media-amazon.com/images/I/71EZ6MycaOL._AC_UF894,1000_QL80_.jpg",
  },
  {
    "nombre": "Lazos tejidos",
    "descripcion": "Lazos tejidos en crochet con diferentes motivos y colores.",
    "precio": 12.00,
    "imagen":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQnj8gXoq1qa3RG-oLwZgq7DnUUS4rIc2ocg&s",
  },
  {
    "nombre": "Bombones surtidos Nestle",
    "descripcion": "Funda de bombones surtidos de chocolate tradicional.",
    "precio": 15.90,
    "imagen":
        "https://143367421.cdn6.editmysite.com/uploads/1/4/3/3/143367421/s560829077226483196_p223_i6_w2880.jpeg?width=2560",
  },
  {
    "nombre": "Caja de bombones Ferrero Rocher",
    "descripcion":
        "Caja de chocolates Ferrero, de 300gr, con chocolates sutirdos con avellana y trozos de nuez.",
    "precio": 7.00,
    "imagen":
        "https://www.ferrero.com/ladm/sites/ferrero_ladm/files/2023-07/frocher_box_circle_quality.jpg?t=1732621316",
  }
];

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  String dropdownValue = 'Nombre';
  List<Map<String, dynamic>> productosOrdenados = productos;

  // Función para ordenar los productos
  void ordenarProductos(String criterio) {
    setState(() {
      if (criterio == 'Nombre') {
        productosOrdenados.sort((a, b) => a['nombre'].compareTo(b['nombre']));
      } else if (criterio == 'Precio') {
        productosOrdenados.sort((a, b) => a['precio'].compareTo(b['precio']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = TokenManager().token.isNotEmpty;

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            headerCompose(context, isLoggedIn),
            const SizedBox(
              height: 18,
            ),
            // Row para agregar "Ordenar por" y el Dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Text(
                    "Ordenar por: ",
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelLarge,
                  ),
                  const SizedBox(width: 25),
                  // Espacio entre el texto y el Dropdown
                  Expanded(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                          ordenarProductos(newValue);
                        }
                      },
                      items: <String>['Nombre', 'Precio']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  return ProductCard(producto: productos[index]);
                },
              ),
            ),
            const SizedBox(
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
}

  Widget headerCompose(BuildContext context, bool isLoggedIn) {
  late List<Map<String, dynamic>> _shoppingList = [];

  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.25,
    decoration: const BoxDecoration(
      color: AppColors.cardColor,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      boxShadow: [
        BoxShadow(color: Colors.black45),
      ],
      image: DecorationImage(
        image: AssetImage("assets/images/sweets_patern.png"),
        fit: BoxFit.cover,
      ),
    ),
    child: Stack(
      children: [
        isLoggedIn
            ? Positioned(
                right: 12,
                top: 12,
                child: IconButton.filledTonal(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return CartScreen(
                            shoppingList: _shoppingList,
                            onUpdate: (ip) {},
                          );
                        });
                  },
                  icon: const Icon(
                    EvaIcons.shopping_cart,
                    color: AppColors.primaryColor,
                    size: 22,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        Positioned(
          left: 12,
          top: 12,
          child: IconButton.filledTonal(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              EvaIcons.close_outline,
              color: AppColors.primaryColor,
              size: 22,
            ),
          ),
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Text(
              "Productos",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Widget para cada tarjeta de producto
class ProductCard extends StatelessWidget {
  final Map<String, dynamic> producto;

  const ProductCard({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Mostrar el ModalBottomSheet con los detalles del producto
        showModalBottomSheet(
          context: context,
          isScrollControlled:
              true, // Esto asegura que el modal se ajuste al contenido
          builder: (context) {
            return ProductDetailModal(producto: producto);
          },
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        child: Row(
          children: [
            Hero(
              tag: producto['nombre'],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  producto['imagen'],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      producto['nombre'],
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "\$${producto['precio'].toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ModalBottomSheet con los detalles del producto
class ProductDetailModal extends StatefulWidget {
  final Map<String, dynamic> producto;

  const ProductDetailModal({super.key, required this.producto});

  @override
  _ProductDetailModalState createState() => _ProductDetailModalState();
}

class _ProductDetailModalState extends State<ProductDetailModal> {
  int cantidad = 1;
  final bool isLoggedIn = TokenManager().token.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del producto
          Hero(
            tag: widget.producto['nombre'],
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.producto['imagen'],
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Titulo y Precio juntos
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  widget.producto['nombre'],
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                "\$${widget.producto['precio'].toStringAsFixed(2)}",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 25),

          // Descripción del producto
          Text(
            widget.producto['descripcion'],
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16),

          // Divider entre la descripción y los botones
          const Divider(),

          // Controles de cantidad y agregar al carrito
          isLoggedIn
              ? Row(
                  children: [
                    IconButton(
                      icon: const Icon(EvaIcons.minus),
                      onPressed: () {
                        if (cantidad > 1) {
                          setState(() {
                            cantidad--;
                          });
                        }
                      },
                    ),
                    Text("$cantidad",
                        style: Theme.of(context).textTheme.labelMedium),
                    IconButton(
                      icon: const Icon(EvaIcons.plus),
                      onPressed: () {
                        setState(() {
                          cantidad++;
                        });
                      },
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // Agregar al carrito
                        // Aquí puedes agregar el producto al carrito con la cantidad seleccionada
                      },
                      child: const Text("Agregar al carrito"),
                    ),
                  ],
                )
              : Text(
                  "Para adquirir este producto, inicia sesion con tu cuenta.",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                )
        ],
      ),
    );
  }
}
