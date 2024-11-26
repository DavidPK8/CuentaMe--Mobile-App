import 'dart:math';

import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/views/Login/login_screen.dart';
import 'package:cuentame_tesis/views/Register/register.form.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              headerCompose(context),
              const SizedBox(height: 32),
              composeBody(),
              const SizedBox(height: 24),
              loginAdd(context),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget composeBody(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text("Regístrate",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: AppColors.primaryColor)
          ),
          const SizedBox(height: 32),
          Text(
            "Crea tu cuenta de forma gratuita y en pocos segundos.",
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          const RegisterForm()
        ],
      ),
    );
  }
}

Widget headerCompose(BuildContext context){
  return Container(
    height: MediaQuery.of(context).size.width * 0.35,
    width: MediaQuery.of(context).size.width,
    decoration: const BoxDecoration(
      color: AppColors.primaryColor,
      borderRadius:  BorderRadius.vertical(bottom: Radius.circular(24))
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/logo_basic.png', scale: 2.0,),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/gift_source_1.png',
            width: 90,
            height: 125,
            fit: BoxFit.cover,
            alignment: const Alignment(0, -1),
          ),
        )

      ],
    ),
  );
}

Widget loginAdd(BuildContext context) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        "¿Ya tienes una cuenta?",
        style: Theme.of(context).textTheme.labelMedium,
      ),
      const SizedBox(
        width: 8,
      ),
      TextButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        },
        child: Text(
          "Inicia Sesión",
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}
