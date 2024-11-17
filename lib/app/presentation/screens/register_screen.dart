import 'package:cuentame_tesis/app/decorations/texts/widget_text.dart';
import 'package:cuentame_tesis/app/decorations/app_colors.dart';
import 'package:cuentame_tesis/app/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.backgroundcolor_1,
                    AppColors.backgroundcolor_2,
                  ],
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/cuentame_logo_login.png',
                      height: 250,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const WidgetText(
                              text: 'Crear Cuenta',
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: AppColors.colorWhite,
                              textAlign: TextAlign.center),
                          const SizedBox(height: 20),
                          _buildTextField(
                            label: 'Nombre',
                            icon: Icons.person,
                            context: context,
                          ),
                          const SizedBox(height: 15),
                          _buildTextField(
                            label: 'Apellido',
                            icon: Icons.person_outline,
                            context: context,
                          ),
                          const SizedBox(height: 15),
                          _buildTextField(
                            label: 'Correo Electrónico',
                            icon: Icons.email,
                            context: context,
                          ),
                          const SizedBox(height: 15),
                          _buildTextField(
                            label: 'Teléfono',
                            icon: Icons.phone,
                            context: context,
                          ),
                          const SizedBox(height: 15),
                          _buildTextField(
                            label: 'Dirección',
                            icon: Icons.location_on,
                            context: context,
                          ),
                          const SizedBox(height: 15),
                          _buildTextField(
                            label: 'Contraseña',
                            icon: Icons.lock,
                            context: context,
                            obscureText: true,
                          ),
                          const SizedBox(height: 15),
                          _buildTextField(
                            label: 'Confirmar Contraseña',
                            icon: Icons.lock_outline,
                            context: context,
                            obscureText: true,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                // Aquí iría la lógica para registrar al usuario
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: AppColors.colorWhite),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Registrarse',
                                style: TextStyle(color: AppColors.colorWhite),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Center(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text(
                                  '¿Ya tienes cuenta? Inicia sesión',
                                  style: TextStyle(color: AppColors.colorWhite),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.colorWhite,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required BuildContext context,
    bool obscureText = false,
  }) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.colorWhite),
        prefixIcon: Icon(icon, color: AppColors.colorWhite),
        filled: true,
        fillColor: Colors.white24,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: AppColors.colorWhite),
    );
  }
}
