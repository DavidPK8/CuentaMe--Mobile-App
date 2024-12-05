import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/views/PageView.dart';// Importa tu vista para agregar dirección
import 'package:cuentame_tesis/views/Profile/user.fetch.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:get/get.dart';

class InlogView extends StatefulWidget {
  const InlogView({super.key, required this.nombre});
  final String nombre;

  @override
  _InlogViewState createState() => _InlogViewState();
}

class _InlogViewState extends State<InlogView> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    // Iniciar el temporizador de 10 segundos antes de cambiar de pantalla
    Future.delayed(const Duration(seconds: 10), () {
        Get.offAll(() => const ComposePageView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centrar todos los elementos
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          headerCompose(),
          bodyCompose(context, widget.nombre),
          footerCompose(context)
        ],
      ),
    );
  }

  Widget headerCompose() {
    return Expanded( // Usa Expanded para llenar el espacio sin generar conflicto
      child: Align( // Usamos Align para centrar la imagen
        alignment: Alignment.center,
        child: Image.asset('assets/images/logo_basic.png', scale: 2.75),
      ),
    );
  }

  Widget bodyCompose(BuildContext context, String nombre) {
    return Expanded( // Usa Expanded para ocupar el espacio
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centrar el contenido dentro de la columna
        children: [
          const CircleAvatar(
            radius: 50,
            child: Icon(EvaIcons.person, size: 50),
          ),
          const SizedBox(height: 20),
          Text("Bienvenido/a,\n$nombre", style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white), textAlign: TextAlign.center)
        ],
      ),
    );
  }

  Widget footerCompose(BuildContext context) {
    return Expanded( // Usa Expanded para ocupar el espacio restante
      child: Align( // Usamos Align para centrar el Row
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(width: 25),
            Text(
              "Iniciando sesión...",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
