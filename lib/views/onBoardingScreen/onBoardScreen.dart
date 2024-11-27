// ignore_for_file: file_names, use_build_context_synchronously
import 'package:cuentame_tesis/views/PageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  Future<void> completeOnboarding(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ComposePageView()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        totalPage: 4, // Número de páginas
        headerBackgroundColor: Colors.white,
        pageBackgroundColor: Colors.white,
        finishButtonText: 'Descubrir',
        onFinish: () => completeOnboarding(context),
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          elevation: 5,
        ),
        skipTextButton: const Text(
          'Saltar',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        controllerColor: AppColors.primaryColor,
        background: [
          SvgPicture.asset(
            'assets/vectors/gift_cuentame.svg',
            height: 400,
          ),
          SvgPicture.asset(
            'assets/vectors/undraw_gift_re_qr17.svg',
            height: 400,
          ),
          SvgPicture.asset(
            'assets/vectors/undraw_online_wishes_dlmr.svg',
            height: 400,
          ),
          SvgPicture.asset(
            'assets/vectors/undraw_deliveries.svg',
            height: 400,
          ),
        ],
        centerBackground: true,
        speed: 1.8,
        pageBodies: [
          buildOnboardingPage(
            context,
            title: "Te damos la bienvenida a Cuenta-me",
            description:
            "Somos un negocio que ama los detalles e impresionar a quienes más amas. Nos esforzamos endar grandes experiencias y recuerdos inolviables.",
          ),
          buildOnboardingPage(
            context,
            title: "Haz sonreír a quienes amas",
            description:
            "Descubre cajitas con dulces, peluches y detalles personalizados. El regalo perfecto para sorprender en cualquier ocasión.",
          ),
          buildOnboardingPage(
            context,
            title: "Tú eliges, nosotros lo armamos",
            description:
            "Diseña regalos únicos con tus colores, mensajes y detalles favoritos. Cada pedido se hace pensando en lo especial que es esa persona para ti.",
          ),
          buildOnboardingPage(
            context,
            title: "Siempre cerca de ti",
            description:
            "Recibe tu pedido en la puerta de tu casa o pasa a retirarlo en nuestra tienda. ¡Tú decides cómo disfrutarlo!",
          ),
        ],
      ),
    );
  }

  /// Widget reutilizable para las páginas de Onboarding
  Widget buildOnboardingPage(
      BuildContext context, {
        required String title,
        required String description,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Espacio para la imagen (se maneja en la propiedad 'background' del OnBoardingSlider)
          const SizedBox(height: 350),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 35),
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
