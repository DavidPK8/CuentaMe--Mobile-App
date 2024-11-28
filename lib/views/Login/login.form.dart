import 'package:cuentame_tesis/views/Login/login.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final LoginController _loginController = Get.put(LoginController());
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginKey,
      child: Column(
        children: [
          emailInput(),
          const SizedBox(height: 24,),
          passwordInput(),
          const SizedBox(height: 24,),
          submitButton(context)
        ],
      ),
    );
  }

  TextFormField emailInput() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: "Correo electrónico",
        labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 14
        ),
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
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14
          ),
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
              color: Colors.white,
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

  FilledButton submitButton(BuildContext context) {
    return FilledButton(
      onPressed: () {
        if (_loginKey.currentState?.validate() ?? false) {
          _loginController.loginCLiente(
            correo: _emailController.text,
            password: _passwordController.text,
            context: context,
            onSuccess: () {
              // Abrir página apra verificación de OTP
              showDialog(
                  context: context,
                  builder: (context){
                    return const Dialog(
                      child: Text("Sesión Iniciada"),
                    );
                  }
              );
            },
          );
        }
      },
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(EvaIcons.log_in, size: 20,),
          SizedBox(width: 12),
          Text("Ingresar"),
        ],
      ),
    );
  }
}
