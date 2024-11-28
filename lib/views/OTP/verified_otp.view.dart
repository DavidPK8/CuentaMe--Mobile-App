import 'package:cuentame_tesis/views/Login/login_screen.dart';
import 'package:flutter/material.dart';

class VerifiedOtpView extends StatelessWidget {
  const VerifiedOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  composeCenter(context),
                  Text("Tu cuenta ha sido verificada y activada exitosamente. Ingresa y descubre los grandes detalles que tenemos para ofrecerte.", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge,),
                  const SizedBox(height: 24,),
                  FilledButton(
                      onPressed: (){
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context){
                              return const LoginScreen() ;
                            })
                        );                  },
                      child: const Text("Inciar Sesión")
                  )
                ],
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
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.asset('assets/images/source_verified.png', scale: 1, width: 150, height: 400,),
      ),
      Text("Cuenta verificada", style: Theme.of(context).textTheme.displayMedium,),
    ],
  );
}
