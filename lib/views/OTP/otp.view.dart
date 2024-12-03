import 'dart:async';
import 'package:cuentame_tesis/views/OTP/verified_otp.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/views/OTP/otp.controller.dart';
import 'package:cuentame_tesis/views/Reset%20Password/changepassword.view.dart';
import 'package:pinput/pinput.dart';

class OTPView extends StatefulWidget {
  final String correo;
  final String action; // Nuevo parámetro

  const OTPView({
    super.key,
    required this.correo,
    required this.action, // Indica si es "verifyAccount" o "resetPassword"
  });

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  final TextEditingController _otpController = TextEditingController();
  final OTPController _otpControllerLogic = Get.put(OTPController());

  late int _secondsRemaining;
  late Timer _timer;
  bool _isTimerActive = true;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = 15 * 60;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _isTimerActive = false;
        });
        _timer.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            "Verifica tu cuenta",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          // Agregado para permitir el desplazamiento
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Verificación OTP",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 24),
                Text(
                  "Se ha enviado un correo a ${widget.correo} con un código de verificación de un solo uso. Ingresa para continuar.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  "Tiempo restante: ${_formatTime(_secondsRemaining)}",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 60),
                // Campo Pinput para ingreso de OTP
                Pinput(
                  controller: _otpController,
                  length: 6,
                  showCursor: true,
                  defaultPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black54),
                    ),
                  ),
                  submittedPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                Obx(() {
                  if (_otpControllerLogic.isLoading.value) {
                    return const CircularProgressIndicator();
                  }
                  return FilledButton(
                    onPressed: () {
                      if (_otpController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Por favor, ingresa el código OTP.")),
                        );
                        return;
                      }

                      _otpControllerLogic.verifyOTP(
                        otpInput: _otpController.text, // Valor del campo de texto
                        correo: widget.correo,
                        action: widget.action, // Pasar la acción
                        context: context,
                        onSuccess: () {
                          if (widget.action == "resetPassword") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangePasswordView(correo: widget.correo),
                              ),
                            );
                          } else if (widget.action == "verifyAccount") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VerifiedOtpView(),
                              ),
                            );
                          }
                        },
                      );
                    },
                    child: const Text("Verificar OTP"),
                  );
                }),
                const SizedBox(height: 16),
                Obx(() {
                  if (_otpControllerLogic.isResendingOTP.value) {
                    return const CircularProgressIndicator();
                  }
                  return TextButton(
                    onPressed: _isTimerActive
                        ? null
                        : () async {
                      setState(() {
                        _isTimerActive = true;
                        _secondsRemaining = 15 * 60; // Reiniciar temporizador
                      });
                      _startTimer();
                      await _otpControllerLogic.resendOTP(
                        correo: widget.correo,
                        context: context,
                        onResendSuccess: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("OTP reenviado exitosamente")),
                          );
                        },
                      );
                    },
                    child: const Text("Reenviar OTP"),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
