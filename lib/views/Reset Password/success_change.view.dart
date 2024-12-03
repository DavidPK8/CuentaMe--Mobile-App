import 'package:cuentame_tesis/views/Login/login.view.dart';
import 'package:flutter/material.dart';

class SuccessChangePassword extends StatelessWidget {
  const SuccessChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/images/password_changed.png', scale: 1, width: 150, height: 350,),
            ),
          ),
          Positioned(
            top: 125,
            right: 0,
            left: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    composeCenter(context),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget composeCenter(BuildContext context){
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      const Icon(Icons.verified_rounded, color: Colors.green, size: 90,),
      const SizedBox(height: 18),
      Text("Contraseña recuperada", style: Theme.of(context).textTheme.displaySmall, textAlign: TextAlign.center,),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Text("Tu contraseña ha sido cambiada de forma satisfactoria.", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge,),
      ),
      FilledButton(
          onPressed: () async{

            await Future.delayed(const Duration(milliseconds: 300));

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context){
                  return const LoginScreen() ;
                })
            );
          },
          child: const Text("Inciar Sesión")
      )
    ],
  );
}
