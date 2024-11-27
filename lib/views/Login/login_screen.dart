import 'package:cuentame_tesis/views/Login/login.form.dart';
import 'package:cuentame_tesis/views/Register/register.view.dart';
import 'package:flutter/material.dart';

import '../../theme/decorations/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text("Iniciar Sesión", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
          leading: IconButton(
              onPressed: (){

              },
              icon: const Icon(Icons.arrow_back_ios_rounded, size: 18, color: Colors.white),
          )
        ),
        body: Stack(
          children: [
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset('assets/images/gifts_decorator.png', scale: 1.25,)
            ),
            bodyCompose(context)
          ],
        )
      ),
    );
  }
}

Widget bodyCompose(BuildContext context){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      Expanded(
          flex: 2,
          child: headerCompose(context)
      ),
      Expanded(
          flex: 8,
          child: formCompose(context)
      )
    ],
  );
}

Widget headerCompose(BuildContext context){
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Image.asset('assets/images/logo_complete.png', scale: 1.25,),
  );
}

Widget formCompose(BuildContext context){
  return Container(
    color: AppColors.primaryColor,
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Column(
        children: [
          Text("Ingresa con tu correo y contraseña", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white)),
          const SizedBox(height: 24,),
          const LoginForm()
        ],
      ),
    ),
  );
}
