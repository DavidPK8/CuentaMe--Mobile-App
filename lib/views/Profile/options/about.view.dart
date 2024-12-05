import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
                'assets/images/gifts_bg_2.png',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              )
          ),
          Positioned(
              left: 10,
              bottom: 25,
              child: IconButton.filledTonal(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_rounded, size: 22, color: AppColors.primaryColor,)
              )
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(5, 8),
                      blurRadius: 8
                    )
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo_basic_complete.png', scale: 3.5,),
                    const SizedBox(height: 24,),
                    Text("Versión de la aplicación", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),
                    Text("1.0.0", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),
                    const SizedBox(height: 24,),
                    FilledButton.tonal(onPressed: (){}, child: Text("Términos y Condiciones", style: Theme.of(context).textTheme.labelLarge,)),
                    const SizedBox(height: 8,),
                    FilledButton.tonal(onPressed: (){}, child: Text("Política de Privacidad", style: Theme.of(context).textTheme.labelLarge)),
                    const SizedBox(height: 24,),
                    Text("© 2024 - CuentaMe Gifts", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
