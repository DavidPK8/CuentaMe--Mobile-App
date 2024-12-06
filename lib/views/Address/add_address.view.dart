import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/views/Profile/options/Address/address.controller.dart';
import 'package:cuentame_tesis/views/Profile/options/Address/address.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({super.key});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  // Controladores para los campos del formulario
  final _callePrincipalController = TextEditingController();
  final _calleSecundariaController = TextEditingController();
  final _numeroCasaController = TextEditingController();
  final _referenciaController = TextEditingController();
  final _aliasController = TextEditingController();
  final _parroquiaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Inyectamos el controlador de direcciones
  final AddressController addressController = Get.put(AddressController());

  @override
  void dispose() {
    // Descartamos los controladores cuando el widget se destruye
    _callePrincipalController.dispose();
    _calleSecundariaController.dispose();
    _numeroCasaController.dispose();
    _referenciaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.pin_drop, size: 24, color: Colors.white),
              const SizedBox(width: 12),
              Text(
                "Nueva Dirección",
                style: theme.titleLarge?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/vectors/undraw_delivery_address_re_cjca.svg',
                  width: 180,
                ),
                const SizedBox(height: 18),
                Flexible(
                  child: Text(
                    "Para agregar una dirección a tu cuenta debes llenar el siguiente formulario. Procura que los datos estén correctamente digitados, las calles tengan sus nombres reales y la referencia sea exacta.",
                    style: theme.bodyMedium,
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 18),
                addressForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget que contiene el formulario
  Widget addressForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          TextFormField(
            controller: _aliasController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(EvaIcons.map_outline),
              label: Text("Alias"),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Este campo es obligatorio";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _parroquiaController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(EvaIcons.map_outline),
              label: Text("Sector o parroquia"),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Este campo es obligatorio";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _callePrincipalController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Calle principal"),
              prefixIcon: Icon(EvaIcons.map_outline),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Este campo es obligatorio";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _calleSecundariaController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(EvaIcons.map_outline),
              label: Text("Calle Secundaria"),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Este campo es obligatorio";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _numeroCasaController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(EvaIcons.hash_outline),
              label: Text("Número de casa o Departamento"),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Este campo es obligatorio";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _referenciaController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(EvaIcons.home_outline),
              label: Text("Referencia"),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Este campo es obligatorio";
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          Obx(() {
            return Center(
              child: FilledButton(
                onPressed: addressController.isLoading.value
                    ? null
                    : () async {
                  if (_formKey.currentState!.validate()) {
                    await addressController.addAddress(
                      alias: _aliasController.text,
                      parroquia: _parroquiaController.text,
                      callePrincipal: _callePrincipalController.text,
                      calleSecundaria: _calleSecundariaController.text,
                      numeroCasa: _numeroCasaController.text,
                      referencia: _referenciaController.text,
                      onSuccess: () {
                        delayedDialog(context);
                      },
                    );
                  }
                },
                child: addressController.isLoading.value
                    ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                    : const Text("Agregar Dirección"),
              ),
            );
          }),
        ],
      ),
    );
  }

  // Función delayed que espera 600 milisegundos antes de mostrar el dialog
  Future<void> delayedDialog(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 600)); // Espera 600 ms

    // Mostrar el Dialog después de la espera
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dirección Agregada'),
        content: const Text('Dirección agregada con éxito'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.offAll(() => const AddressView());
            },
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
