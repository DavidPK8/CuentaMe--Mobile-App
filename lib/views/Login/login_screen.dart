import 'package:cuentame_tesis/views/Register/register.view.dart';
import 'package:flutter/material.dart';

import '../../theme/decorations/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        // Detecta el toque en cualquier parte de la pantalla para ocultar el teclado
        onTap: () {
          FocusScope.of(context).unfocus(); // Oculta el teclado
        },
        child: Stack(
          children: [
            // Fondo con gradiente
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.backgroundcolor_1, // Amarillo oscuro
                    AppColors.backgroundcolor_2, // Amarillo claro
                  ],
                ),
              ),
            ),
            // Contenido principal
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Imagen en la parte superior
                    Image.asset(
                      'assets/images/cuentame_logo_login.png', // Asegúrate de que la imagen exista
                      height: 250,
                    ),
                    const SizedBox(height: 20),

                    // Cuadro morado con contenido
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor, // Color morado
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Título centrado
                          const Text(
                            'Bienvenid@',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40, // Tamaño de fuente aumentado
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Campo de texto para Gmail
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Correo Electrónico',
                              labelStyle: const TextStyle(color: Colors.white),
                              prefixIcon:
                                  const Icon(Icons.email, color: Colors.white),
                              filled: true,
                              fillColor: Colors.white24,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 15),

                          // Campo de texto para Contraseña
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              labelStyle: const TextStyle(color: Colors.white),
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.white),
                              filled: true,
                              fillColor: Colors.white24,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 20),

                          // Botón de Ingresar
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                // Lógica para Ingresar
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.white), // Borde blanco
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Ingresar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Botón de Registrarse
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen()), // Redirige a registrarse
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.white), // Borde blanco
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Registrarse',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // Texto para Recuperar Contraseña
                          Center(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen()), // Redirige a registrarse
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Text(
                                  'Recuperar Contraseña',
                                  style: TextStyle(color: Colors.white),
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
            // Botón de regresar a HomeScreen
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
                    Navigator.pop(context); // Regresa a la pantalla anterior
                  },
                )),
          ],
        ),
      ),
    );
  }
}
