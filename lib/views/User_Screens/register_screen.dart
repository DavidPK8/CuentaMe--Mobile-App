import 'package:cuentame_tesis/services/authentication/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrarse')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Provider.of<AuthProvider>(context, listen: false).login();
            Navigator.of(context).pop(); // Volver a la pantalla de productos
          },
          child: const Text('Registrarse'),
        ),
      ),
    );
  }
}
