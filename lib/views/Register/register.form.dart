import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/views/OTP/otp.view.dart';
import 'package:cuentame_tesis/views/Register/register.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final RegisterController _registerController = Get.put(RegisterController());
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();
  final TextEditingController _nameField = TextEditingController();
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _phoneField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final TextEditingController _confirmPasswordField = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

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
          const SizedBox(height: 16),
          emailInput(),
          const SizedBox(height: 16),
          phoneInput(),
          const SizedBox(height: 16),
          addressInput(),
          const SizedBox(height: 16),
          passwordInput(),
          const SizedBox(height: 16),
          confirmPasswordInput(),
          const SizedBox(height: 24),
          submitButton(context),
        ],
      ),
    );
  }

  TextFormField nameInput() {
    return TextFormField(
      controller: _nameField,
      decoration: const InputDecoration(
        hintText: "",
        labelText: "Nombre Completo",
        border: OutlineInputBorder(
          gapPadding: 5,
        ),
        prefixIcon: Icon(
          Icons.person_2_rounded,
          color: AppColors.primaryColor,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'El nombre no puede estar vacío';
        } else {
          if (value[0] != value[0].toUpperCase()){
            return "El nombre debe empezar con mayúscula";
          }
        }
        return null;
      },
      style: Theme.of(context).textTheme.labelSmall,
    );
  }

  TextFormField emailInput() {
    return TextFormField(
      controller: _emailField,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: "",
        labelText: "Correo electrónico",
        border: OutlineInputBorder(
          gapPadding: 5,
        ),
        prefixIcon: Icon(
          Icons.email_rounded,
          color: AppColors.primaryColor,
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
      style: Theme.of(context).textTheme.labelSmall,
    );
  }

  TextFormField phoneInput() {
    return TextFormField(
      controller: _phoneField,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        hintText: "",
        labelText: "Teléfono",
        border: OutlineInputBorder(
          gapPadding: 5,
        ),
        prefixIcon: Icon(
          Icons.phone_android_rounded,
          color: AppColors.primaryColor,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'El teléfono no puede estar vacío';
        } else if (value.length < 10) {
          return 'Ingrese un número de teléfono válido';
        }
        return null;
      },
      style: Theme.of(context).textTheme.labelSmall,
    );
  }

  TextFormField addressInput() {
    return TextFormField(
      controller: _addressController,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: "",
        labelText: "Dirección",
        border: OutlineInputBorder(
          gapPadding: 5,
        ),
        prefixIcon: Icon(
          EvaIcons.pin_outline,
          color: AppColors.primaryColor,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'La dirección está vacia.';
        } else if (value.length < 10) {
          return 'Ingrese una dirección válida.';
        }
        return null;
      },
      style: Theme.of(context).textTheme.labelSmall,
    );
  }

  Widget passwordInput() {
    return Obx(
          () => TextFormField(
        controller: _passwordField,
        obscureText: _registerController.isPasswordVisible.value,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          hintText: "",
          labelText: "Contraseña",
          border: const OutlineInputBorder(
            gapPadding: 5,
          ),
          prefixIcon: const Icon(
            Icons.lock_rounded,
            color: AppColors.primaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _registerController.isPasswordVisible.value
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
            ),
            onPressed: _registerController.togglePasswordVisibility,
          ),
        ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'La contraseña no puede estar vacía';
              } else if (value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres';
              }
              return null;
            },
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }

  Widget confirmPasswordInput() {
    return Obx(
          () => TextFormField(
        controller: _confirmPasswordField,
        obscureText: _registerController.isPasswordVisible.value,
        obscuringCharacter: '*',
        onChanged: (_) => _registerController.checkPasswordMatch(
          _passwordField.text,
          _confirmPasswordField.text,
        ),
        decoration: InputDecoration(
          hintText: "",
          labelText: "Confirmar Contraseña",
          border: const OutlineInputBorder(
            gapPadding: 5,
          ),
          prefixIcon: Icon(
            _registerController.isPasswordMatch.value
                ? Icons.check_circle_outline_rounded
                : Icons.error_outline_rounded,
            color: _registerController.isPasswordMatch.value
                ? Colors.green
                : Colors.red,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _registerController.isPasswordVisible.value
                  ? Icons.visibility_off_rounded
                  : Icons.visibility_rounded,
            ),
            onPressed: _registerController.togglePasswordVisibility,
          ),
        ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'La confirmación no puede estar vacía';
              } else if (value != _passwordField.text) {
                return 'Las contraseñas no coinciden';
              }
              return null;
            },
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }

  FilledButton submitButton(BuildContext context) {
    return FilledButton(
      onPressed: () {
        if (_registerKey.currentState?.validate() ?? false) {
          _registerController.registrarCliente(
            nombre: _nameField.text,
            correo: _emailField.text,
            telefono: _phoneField.text,
            password: _passwordField.text,
            direccion: _addressController.text,
            context: context,
            onSuccess: () {
              // Abrir página apra verificación de OTP
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => OTPView(correo: _emailField.text, action: "verifyAccount",)),
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
          Icon(EvaIcons.gift_outline),
          SizedBox(width: 12),
          Text("Regístrame"),
        ],
      ),
    );
  }
}
