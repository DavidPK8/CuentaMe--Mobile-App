import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/utils/token.manager.dart';
import 'package:cuentame_tesis/views/Goodbye%20Screen/goodbye.view.dart';
import 'package:cuentame_tesis/views/Login/login.view.dart';
import 'package:cuentame_tesis/views/Profile/options/about.view.dart';
import 'package:cuentame_tesis/views/Profile/options/user.profile.view.dart';
import 'package:cuentame_tesis/views/Register/register.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = TokenManager().token.isNotEmpty;

    return SafeArea(
      child: Scaffold(
        body: isLoggedIn
            ? _sessionProfileCompose(context)
            : _nonSessionProfileCompose(context),
      ),
    );
  }
}

// ------------------------- Widget para usuarios no autenticados --------------------------
Widget _nonSessionProfileCompose(BuildContext context) {
  return Stack(
    children: [
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: SvgPicture.asset(
          'assets/vectors/undraw_gift_re_qr17.svg',
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.height * 0.4,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            Text(
              "Inicia sesión para obtener una experiencia personalizada y conocer más sobre nuestros productos.",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                    child: _pinItem(EvaIcons.gift_outline, "Regalos a tu elección", context)
                ),
                Flexible(
                  child: _pinItem(
                      EvaIcons.shopping_bag_outline, "Personalización dinámica", context),
                ),
                Flexible(
                    child: _pinItem(EvaIcons.car_outline, "Facilidades de entrega", context)
                ),
              ],
            ),
            const SizedBox(height: 32),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text("Iniciar Sesión"),
                ),
                const SizedBox(height: 16),
                FilledButton.tonal(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: const Text("Regístrate"),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// ------------------------- Widget de íconos y texto --------------------------
Widget _pinItem(IconData icon, String text, BuildContext context) {
  return Column(
    children: [
      IconButton.filledTonal(
        onPressed: null,
        icon: Icon(
          icon,
          color: AppColors.primaryColor,
          size: 22,
        ),
      ),
      const SizedBox(height: 8),
      Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.center,
      ),
    ],
  );
}

// ------------------------- Widget para usuarios autenticados --------------------------
Widget _sessionProfileCompose(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 18),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _profileHeader(context),
        const SizedBox(height: 40),
        Expanded(
            child: _profileOptionsList(context)
        ),
        _logoutButton(context),
      ],
    ),
  );
}

// ------------------------- Función para formato de hora --------------------------
String _getFormattedTime() {
  initializeDateFormatting('es_ES', null);
  DateTime now = DateTime.now();
  String hour = DateFormat('HH', 'es_ES').format(now); // Hora en formato 24h
  String minute = DateFormat('mm', 'es_ES').format(now); // Minutos
  String amPm = DateFormat('a', 'es_ES').format(now); // AM o PM (si prefieres formato 12h)

  return '$hour:$minute ${amPm.toLowerCase()}'; // Resultado: "14:45 pm" o "08:30 am"
}

// ------------------------- Función para formato de fecha --------------------------
String _getFormattedDate() {
  initializeDateFormatting('es_ES', null);
  DateTime now = DateTime.now();
  String dayOfWeek = DateFormat('EEEE', 'es_ES').format(now);
  String month = DateFormat('MMMM', 'es_ES').format(now);
  return '${_capitalize(dayOfWeek)}, ${now.day} de ${_capitalize(month)} ${now.year}';
}

String _capitalize(String input) => input[0].toUpperCase() + input.substring(1);

// ------------------------- Encabezado del perfil --------------------------
Widget _profileHeader(BuildContext context) {
  String formattedDate = _getFormattedDate();
  String currentTime = _getFormattedTime();
  return Column(
    children: [
      const Icon(
        EvaIcons.gift_outline,
        size: 80,
        color: AppColors.primaryColor,
      ),
      const SizedBox(height: 16),
      Text(
        "¡Bienvenido de nuevo!",
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 16),
      Text(
        formattedDate.isEmpty ? 'Cargando fecha...' : formattedDate,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      const SizedBox(height: 16),
      Text(
        "última sesión: ${currentTime.isEmpty ? 'Cargando fecha...' : currentTime}" ,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    ],
  );
}

// ------------------------- Lista de opciones del perfil --------------------------
Widget _profileOptionsList(BuildContext context) {
  return ListView(
    children: [
      _listTileComposer(
        context,
        "Mi Perfil",
        EvaIcons.person_outline,
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserDataView()),
          );
        }
      ),
      _listTileComposer(context, "Mis Direcciones", EvaIcons.pin_outline),
      _listTileComposer(context, "Mis Pedidos", EvaIcons.shopping_bag_outline),
      _listTileComposer(
        context,
        "Acerca de la aplicación",
        EvaIcons.info_outline,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AboutView()),
          );
        },
      ),
    ],
  );
}

// ------------------------- Botón de cerrar sesión --------------------------
Widget _logoutButton(BuildContext context) {
  return FilledButton(
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Cerrar Sesión",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColors.primaryColor),
            ),
            content: Text(
              "¿Deseas cerrar tu sesión en esta aplicación?",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),
              FilledButton(
                onPressed: () {
                  TokenManager().clearToken();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const GoodByeView()),
                  );
                },
                child: const Text("Salir"),
              ),
            ],
          );
        },
      );
    },
    child: const Text("Cerrar sesión"),
  );
}

// ------------------------- Componente de opciones reutilizable --------------------------
Widget _listTileComposer(BuildContext context, String text, IconData icon,
    {VoidCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        children: [
          Icon(icon, size: 30, color: AppColors.primaryColor),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    ),
  );
}
