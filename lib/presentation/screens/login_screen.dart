import 'package:cuentame_tesis/authentication/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Provider.of<AuthProvider>(context, listen: false).login();
            Navigator.of(context).pop(); // Volver a la pantalla de productos
          },
          child: Text('Iniciar Sesión'),
        ),
      ),
    );
  }
}
