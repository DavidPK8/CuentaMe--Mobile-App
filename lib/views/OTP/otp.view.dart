import 'package:cuentame_tesis/views/Login/login_screen.dart';
import 'package:cuentame_tesis/views/OTP/otp.controller.dart';
import 'package:cuentame_tesis/views/OTP/verified_otp.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../theme/decorations/app_colors.dart';

class OTPView extends StatefulWidget {

  final String correo;

  const OTPView({super.key, required this.correo});

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {

  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocus = FocusNode();
  final OTPController _otpControllerLogic = Get.put(OTPController());  // Instanciamos el controlador

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text("Verifica tu cuenta", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),),
        ),
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/undraw_Gift_re_qr17.png'),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Verificación OTP", style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 24,),
                    Text("Se ha enviado un correo a ${widget.correo} con un código de verificación de un solo uso. Ingreso para poder activar tu cuenta.", textAlign: TextAlign.center,),
                    const SizedBox(height: 24,),
                    Text("Tiempo de uso: 15 minutos.", textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelSmall,),
                    const SizedBox(height: 60,),
                    // Pinput field for OTP input
                    Pinput(
                      controller: _otpController,
                      focusNode: _otpFocus,
                      length: 6, // Define la longitud del OTP
                      defaultPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 20,
                          fontWeight: FontWeight.w600,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black54),
                        ),
                      ),
                      submittedPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 20,
                            fontWeight: FontWeight.w600,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.cartColor
                        )
                      ),
                      showCursor: true,
                    ),
                    const SizedBox(height: 60,),
                    Obx(() {
                      if (_otpControllerLogic.isLoading.value) {
                        return const CircularProgressIndicator();
                      }
                      return FilledButton(
                        onPressed: () {
                          String otp = _otpController.text;
                          _otpControllerLogic.verifyOTP(
                            correo: widget.correo,
                            otp: otp,
                            context: context,
                            onSuccess: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context){
                                    return const VerifiedOtpView() ;
                                  })
                              );
                            },
                          );
                        },
                        child: const Text("Verificar OTP"),
                      );
                    }),
                    const Spacer()
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
