import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/views/Profile/user.controller.dart';
import 'package:cuentame_tesis/views/Reset%20Password/reset_password.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDataView extends StatelessWidget {
  const UserDataView({super.key});

  @override
  Widget build(BuildContext context) {
    // Coloca el controlador en la vista
    final ProfileController profileController = Get.put(ProfileController());
    final theme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              size: 22,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Mis datos",
            style: theme.titleLarge?.copyWith(color: Colors.white),
          ),
        ),
        body: Obx(() {
          if (profileController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (profileController.profileData.isEmpty) {
            return const Center(child: Text("No hay datos disponibles"));
          } else {
            final data = profileController.profileData;
            final correo = data['correo'] ?? "Correo no disponible";

            return Column(
              children: [
                // Encabezado decorativo
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.account_circle_outlined,
                        size: 60,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Información del usuario",
                        style: theme.headlineSmall?.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Lista de datos
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      profileComposeDecorator(
                        context,
                        "Nombre",
                        data['nombre'] ?? 'N/A',
                        Icons.person_3_outlined,
                      ),
                      const Divider(),
                      profileComposeDecorator(
                        context,
                        "Correo",
                        correo,
                        Icons.email_outlined,
                        onTap: () {
                          showCustomBottomSheet(context, correo); // Mostrar el modal inferior
                        },
                      ),
                      const Divider(),
                      profileComposeDecorator(
                        context,
                        "Teléfono",
                        data['telefono']?.toString() ?? 'N/A',
                        Icons.phone_android_rounded,
                      ),
                    ],
                  ),
                ),
                Image.asset('assets/images/gifts_decorator.png')
              ],
            );
          }
        }),
      ),
    );
  }
}

void showCustomBottomSheet(BuildContext context, String correo) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),  // Redondea la parte superior izquierda
        topRight: Radius.circular(16), // Redondea la parte superior derecha
      ),
    ),
    isScrollControlled: true, // Permite que el bottom sheet se ajuste al contenido
    builder: (BuildContext context) {
      return Card(
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        color: AppColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ajuste al contenido
            children: [
              Text(
                "Acciones Importantes",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 25),
              resetPasswordClick(context, correo), // Acción para interactuar con el contenido
            ],
          ),
        ),
      );
    },
  );
}

Widget profileComposeDecorator(
    BuildContext context, String label, String value, IconData icon, {void Function()? onTap}) {
  final theme = Theme.of(context).textTheme;

  // Modificar el valor del teléfono específicamente
  final formattedValue = label == "Teléfono" ? "(+593) 0$value" : value;

  return ListTile(
    leading: Icon(
      icon,
      size: 28,
      color: Theme.of(context).primaryColor,
    ),
    title: Text(
      label,
      style: theme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
    ),
    subtitle: Text(
      formattedValue,
      style: theme.bodyLarge,
    ),
    trailing: onTap != null
        ? IconButton(
      icon: Icon(Icons.more_vert, color: Theme.of(context).primaryColor),
      onPressed: onTap,
    )
        : null, // Solo muestra el icono si onTap está presente
  );
}

Widget resetPasswordClick(BuildContext context, String correo) {
  final ResetPasswordController resetpasswordController =
  ResetPasswordController();

  return FilledButton.tonal(
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Recuperar contraseña",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            content: Text(
              "Para proceder con el cambio de contraseña se enviará un correo electrónico a la dirección $correo con un código de un solo uso.",
              textAlign: TextAlign.justify,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancelar"),
              ),
              FilledButton(
                onPressed: () {
                  resetpasswordController.recuperarPassword(
                    correo: correo,
                    context: context,
                    onSuccess: () {
                      // Éxito
                      Navigator.pop(context);
                    },
                  );
                },
                child: const Text("Enviar"),
              ),
            ],
          );
        },
      );
    },
    child: const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.lock_reset, size: 18),
        SizedBox(width: 12),
        Text("Cambiar contraseña"),
      ],
    ),
  );
}
