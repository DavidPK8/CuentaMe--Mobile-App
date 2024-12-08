import 'package:cuentame_tesis/views/Profile/options/Address/address.fetch.dart';
import 'package:flutter/material.dart';
import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({super.key, required this.direccionID});

  final String direccionID;

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  // Controladores para los campos del formulario
  final _callePrincipalController = TextEditingController();
  final _calleSecundariaController = TextEditingController();
  final _numeroCasaController = TextEditingController();
  final _referenciaController = TextEditingController();
  final _aliasController = TextEditingController();
  final _parroquiaController = TextEditingController();
  final _isDefaultController = ValueNotifier<bool>(false); // Para el campo isDefault

  final _formKey = GlobalKey<FormState>();

  // Aquí puedes hacer una petición para obtener los detalles de la dirección
  // y luego asignar esos valores a los controladores. Usaremos un servicio.
  final AddressService _addressService = AddressService();

  @override
  void dispose() {
    // Descartamos los controladores cuando el widget se destruye
    _callePrincipalController.dispose();
    _calleSecundariaController.dispose();
    _numeroCasaController.dispose();
    _referenciaController.dispose();
    _aliasController.dispose();
    _parroquiaController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  // Método para manejar la actualización de la dirección
  Future<void> _updateAddress() async {
    if (_formKey.currentState!.validate()) {
      final response = await _addressService.editAddress(
        direccionId: widget.direccionID,
        alias: _aliasController.text,
        parroquia: _parroquiaController.text,
        callePrincipal: _callePrincipalController.text,
        calleSecundaria: _calleSecundariaController.text,
        numeroCasa: _numeroCasaController.text,
        referencia: _referenciaController.text,
        isDefault: _isDefaultController.value,
      );

      if (response.statusCode == 200) {
        Get.snackbar("Éxito", "Dirección actualizada correctamente", snackPosition: SnackPosition.BOTTOM);
        Navigator.pop(context);
      } else {
        Get.snackbar("Error", "No se pudo actualizar la dirección", snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            "Actualizar dirección",
            style: theme.titleLarge?.copyWith(color: Colors.white),
          ),
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/vectors/undraw_delivery_address_re_cjca.svg',
                    width: 180,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  "Para actualizar tu dirección, por favor revisa los campos y haz los cambios necesarios.",
                  style: theme.bodyMedium,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 18),
                // Campos del formulario
                _buildTextFormField(_aliasController, "Alias", "Este campo es obligatorio"),
                const SizedBox(height: 16),
                _buildTextFormField(_parroquiaController, "Parroquia o Sector", "Este campo es obligatorio"),
                const SizedBox(height: 16),
                _buildTextFormField(_callePrincipalController, "Calle Principal", "Este campo es obligatorio"),
                const SizedBox(height: 16),
                _buildTextFormField(_calleSecundariaController, "Calle Secundaria", "Este campo es obligatorio"),
                const SizedBox(height: 16),
                _buildTextFormField(_numeroCasaController, "Número de Casa o Departamento", "Este campo es obligatorio"),
                const SizedBox(height: 16),
                _buildTextFormField(_referenciaController, "Referencia", "Este campo es obligatorio"),
                const SizedBox(height: 28),

                // Campo para marcar como predeterminada
                Row(
                  children: [
                    Text("¿Es predeterminada?", style: theme.bodyMedium),
                    ValueListenableBuilder<bool>(
                      valueListenable: _isDefaultController,
                      builder: (context, isDefault, child) {
                        return Checkbox(
                          value: isDefault,
                          onChanged: (value) {
                            _isDefaultController.value = value ?? false;
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Botón para actualizar
                Center(
                  child: ElevatedButton(
                    onPressed: _updateAddress,
                    child: const Text("Actualizar Dirección"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget para los campos de texto del formulario
  Widget _buildTextFormField(TextEditingController controller, String label, String validationMessage) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(label),
        prefixIcon: const Icon(Icons.location_on),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMessage;
        }
        return null;
      },
    );
  }
}