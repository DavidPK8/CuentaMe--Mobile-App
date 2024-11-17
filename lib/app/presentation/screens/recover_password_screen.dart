import 'package:cuentame_tesis/app/decorations/texts/widget_text.dart';
import 'package:cuentame_tesis/app/decorations/app_colors.dart';
import 'package:flutter/material.dart';

class RecoverPasswordScreen extends StatelessWidget {
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
                            text: 'Recuperar Contraseña',
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppColors.colorWhite,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Ingresa tu correo electrónico, te enviaremos un correo para que puedas cambiar tu clave',
                            style: TextStyle(
                              color: AppColors.colorWhite,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Correo Electrónico',
                              labelStyle:
                                  const TextStyle(color: AppColors.colorWhite),
                              prefixIcon: const Icon(Icons.email,
                                  color: AppColors.colorWhite),
                              filled: true,
                              fillColor: Colors.white24,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: const TextStyle(color: AppColors.colorWhite),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                // Lógica para enviar el correo de recuperación
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Correo de recuperación enviado'),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: AppColors.colorWhite),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Enviar',
                                style: TextStyle(color: AppColors.colorWhite),
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
}
