import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final GlobalKey _registerKey = GlobalKey<FormState>();
  final TextEditingController _nameField = TextEditingController();
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _phoneField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final TextEditingController _confimPasswordField = TextEditingController();
  final bool _ispasswordMatch = true;
  final bool _ispasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          nameInput(),
          const SizedBox(height: 16,), // Agrega un espacio equidistante
          emailInput(),
          const SizedBox(height: 16,), // Agrega otro espacio equidistante
          phoneInput(),
          const SizedBox(height: 16,), // Otro espacio
          passwordInput(),
          const SizedBox(height: 16,),
          confirmPasswordInput(),
          const SizedBox(height: 24,),// Puedes usar flex para un espacio más grande
          submitButton()
        ],
      ),
    );
  }

  TextFormField nameInput(){
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: _nameField,
      decoration: const InputDecoration(
        hintText: "",
        labelText: "Nombre Completo",
        border: OutlineInputBorder(
          gapPadding: 5,
        ),
        prefixIcon: Icon(Icons.person_2_rounded, color: AppColors.primaryColor,),
      ),
      style: Theme.of(context).textTheme.labelSmall,
    );
  }

  TextFormField emailInput(){
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _emailField,
      decoration: const InputDecoration(
        hintText: "",
        labelText: "Correo electrónico",
        border: OutlineInputBorder(
          gapPadding: 5,
        ),
        prefixIcon: Icon(Icons.email_rounded, color: AppColors.primaryColor,),
      ),
      style: Theme.of(context).textTheme.labelSmall
    );
  }

  TextFormField phoneInput(){
    return TextFormField(
      controller: _phoneField,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: "",
        labelText: "Teléfono",
        border: OutlineInputBorder(
          gapPadding: 5,
        ),
        prefixIcon: Icon(Icons.phone_android_rounded, color: AppColors.primaryColor,),
      ),
        style: Theme.of(context).textTheme.labelSmall
    );
  }

  TextFormField passwordInput(){
    return TextFormField(
      controller: _passwordField,
      obscureText: true,
      obscuringCharacter: '*',
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        hintText: "",
        labelText: "Contraseña",
        border: const OutlineInputBorder(
          gapPadding: 5,
        ),
        prefixIcon: const Icon(Icons.password, color: AppColors.primaryColor,),
        suffixIcon: _ispasswordVisible ? const Icon(Icons.visibility_off_rounded) : const Icon(Icons.visibility_rounded)
      ),
        style: Theme.of(context).textTheme.labelSmall
    );
  }

  TextFormField confirmPasswordInput(){
    return TextFormField(
      controller: _confimPasswordField,
      obscureText: true,
      obscuringCharacter: '*',
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        hintText: "",
        labelText: "Confirmar contraseña",
        border: const OutlineInputBorder(
          gapPadding: 5,
        ),

        prefixIcon: _ispasswordMatch ? const Icon(Icons.error_outline_rounded, color: Colors.red) : const Icon(Icons.check_circle_outline_rounded, color: Colors.green,),
        suffixIcon: _ispasswordVisible ? const Icon(Icons.visibility_off_rounded) : const Icon(Icons.visibility_rounded)
      ),
        style: Theme.of(context).textTheme.labelSmall
    );
  }

  FilledButton submitButton(){
    return FilledButton(
        onPressed: (){},
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(EvaIcons.gift_outline),
            SizedBox(width: 12),
            Text("Regístrame")
          ],
        )
    );
  }
}
