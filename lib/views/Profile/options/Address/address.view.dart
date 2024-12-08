import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/views/Address/add_address.view.dart';
import 'package:cuentame_tesis/views/Profile/options/Address/address.controller.dart';
import 'package:cuentame_tesis/views/Profile/options/Address/edit_address.view.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressController addressController = Get.put(AddressController());

    // Cargar direcciones al abrir la vista
    addressController.fetchAddresses();

    final theme = Theme.of(context).textTheme;
    const primaryColor = AppColors.primaryColor;

    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: true, // Permite ajustar la vista con el teclado
        appBar: AppBar(
          title: Text(
            "Mis direcciones",
            style: theme.titleLarge?.copyWith(color: Colors.white),
          ),
          backgroundColor: primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          actions: addressController.addresses.isEmpty
              ? [
            IconButton(
              tooltip: "Recargar vista",
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: () async {
                await addressController.fetchAddresses(); // Actualiza la vista
              },
            ),
          ]
              : [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddAddressView()),
                );
              },
              tooltip: "Nueva dirección",
              icon: const Icon(EvaIcons.plus_circle_outline,
                  color: Colors.white),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await addressController.fetchAddresses(); // Refresca las direcciones
          },
          child: addressController.isLoading.value
              ? const Center(child: CircularProgressIndicator()) // Indicador de carga
              : addressController.addresses.isEmpty
              ? LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: constraints.maxHeight,
                  child: nonAddressCompose(context),
                ),
              );
            },
          )
              : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: addressController.addresses.length,
            itemBuilder: (context, index) {
              final address = addressController.addresses[index];
              final cardColor = primaryColor
                  .withOpacity(1 - (index * 0.1).clamp(0, 1));

              final direccionID = address['_id'];
              final defaultAddress = address['isDefault'];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ExpansionTileCard(
                  baseColor: cardColor,
                  shadowColor: cardColor.withOpacity(0.5),
                  expandedColor: cardColor.withOpacity(0.9),
                  leading: const Icon(
                      Icons.star_border_purple500_rounded,
                      color: Colors.white),
                  title: Text("Alias: ${address['alias']}",
                      style: theme.labelLarge
                          ?.copyWith(color: Colors.white)),
                  subtitle: Text(
                    "Calle Principal: ${address['callePrincipal']}",
                    style: theme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
                  animateTrailing: true,
                  children: [
                    ListTile(
                      title: Text("Calle Secundaria: ",
                          style: theme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      subtitle: Text(address['calleSecundaria'],
                          style: theme.bodyMedium?.copyWith(color: Colors.white)),
                    ),
                    ListTile(
                      title: Text("Número de Casa: ",
                          style: theme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      subtitle: Text(address['numeroCasa'],
                          style: theme.bodyMedium?.copyWith(color: Colors.white)),
                    ),
                    ListTile(
                      title: Text("Referencia: ",
                          style: theme.labelMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      subtitle: Text(address['referencia'],
                          style: theme.bodyMedium?.copyWith(color: Colors.white)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Estado predeterminado de la dirección
                        defaultAddress == true ?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(EvaIcons.heart, color: Colors.redAccent, size: 24,),
                            const SizedBox(width: 12,),
                            Text("Predeterminada", style: theme.labelSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),)
                          ],
                        )
                            :
                        const Icon(EvaIcons.heart_outline, size: 24, color: Colors.white),
                        // Botón para actualizar la dirección
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            Get.to(() => EditAddress(direccionID: direccionID));
                          },
                        ),

                        // Botón para eliminar la dirección
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            Get.defaultDialog(
                              title: "Eliminar dirección",
                              middleText: "¿Estás seguro de que deseas eliminar esta dirección?",
                              textCancel: "Cancelar",
                              textConfirm: "Eliminar",
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                addressController.deleteAddress(
                                  direccionID: direccionID,
                                  onSuccess: () {
                                    Get.back(); // Cierra el diálogo tras el éxito
                                    Get.snackbar(
                                      "Éxito",
                                      "La dirección ha sido eliminada",
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Visibility(
          visible: !addressController.isLoading.value, // Solo visible cuando no se está cargando
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Nota: Solamente puede agregar 5 direcciones por cuenta.",
              style: theme.labelSmall?.copyWith(color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    });
  }

  // Widget que se muestra cuando no hay direcciones
  Widget nonAddressCompose(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/vectors/undraw_directions_re_kjxs.svg',
              width: 200,
            ),
            const SizedBox(height: 35),
            Text(
              "No tienes direcciones existentes",
              style: theme.headlineMedium?.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Agrega tu primera dirección para recibir un servicio personalizado y entregas eficientes a domicilio.",
              style: theme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddAddressView()));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 20),
                  SizedBox(width: 12),
                  Text("Agregar dirección"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
