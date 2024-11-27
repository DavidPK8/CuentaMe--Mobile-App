import 'package:cuentame_tesis/views/Register/register.view.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: (){
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const RegisterScreen())
            );
          },
          child: Text("Registrarme")
      ),
    );
  }
}
