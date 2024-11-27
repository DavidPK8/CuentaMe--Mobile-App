import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/views/Login/login.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final LoginController _loginController = Get.put(LoginController());
  final GlobalKey _loginKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginKey,
      child: Column(
        children: [
          emailInput(),
          const SizedBox(height: 16,),
          passwordInput(),
          const SizedBox(height: 24,)
        ],
      ),
    );
  }

  TextFormField emailInput() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: "",
        labelText: "Correo electrónico",
        border: OutlineInputBorder(
          gapPadding: 5,
        ),
        prefixIcon: Icon(
          Icons.email_rounded,
          color: Colors.white,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'El correo no puede estar vacío';
        } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zAolA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
          return 'Ingrese un correo válido';
        }
        return null;
      },
      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
    );
  }

  Widget passwordInput() {
    return Obx(
          () => TextFormField(
        controller: _passwordController,
        obscureText: _loginController.isPasswordVisible.value,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          hintText: "",
          labelText: "Contraseña",
          border: const OutlineInputBorder(
            gapPadding: 5,
          ),
          prefixIcon: const Icon(
            Icons.lock_rounded,
            color: Colors.white,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _loginController.isPasswordVisible.value
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
            ),
            onPressed: _loginController.togglePasswordVisibility,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'La contraseña no puede estar vacía';
          }
          return null;
        },
        style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
      ),
    );
  }
}
