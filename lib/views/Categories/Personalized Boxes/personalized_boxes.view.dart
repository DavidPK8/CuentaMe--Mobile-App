import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/utils/token.manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';

class PersonalizedBoxesView extends StatelessWidget {
  const PersonalizedBoxesView({super.key});

  @override
  Widget build(BuildContext context) {

    final bool isLoggedIn = TokenManager().token.isNotEmpty;
    
    return SafeArea(
      child: Scaffold(
          body: isLoggedIn ? composeSessionForm(context) : nonSessionPersonalizedBox(context)
      ),
    );
  }
}

Widget composeSessionForm(BuildContext context){
  return SafeArea(
    child: Scaffold(
      body: Column(
        children: [
          headerCompose(context),
          Expanded(child: sessionedpersonalizedBox(context))
        ],
      ),
    ),
  );
}

Widget headerCompose(BuildContext context){
  return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: const BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
                color: Colors.black45
            )
          ],
          image: DecorationImage(
              image: AssetImage(
                  "assets/images/gifts_bg_3.png"
              ),
              fit: BoxFit.cover
          )
      ),
      child: Stack(
        children: [
          Positioned(
              right: 12,
              top: 12,
              child: IconButton.filledTonal(
                  onPressed: (){

                  },
                  icon: const Icon(EvaIcons.shopping_cart, color: AppColors.primaryColor, size: 22,)
              )
          ),
          Positioned(
              left: 12,
              top: 12,
              child: IconButton.filledTonal(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(EvaIcons.close_outline, color: AppColors.primaryColor, size: 22,)
              )
          ),
          Center(
              child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child: Text("Personaliza tu caja", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                  )
              )
          )
        ],
      )
  );
}

Widget sessionedpersonalizedBox(BuildContext context){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset('assets/vectors/undraw_bug_fixing_oc-7-a.svg', width: 250,),
          const SizedBox(height: 50),
          Text("Estamos en mantenimiento para darte una mejor experiencia.", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
          const SizedBox(height: 25,),
          Text("Disculpa las molestias.", style: Theme.of(context).textTheme.bodyLarge,),
        ],
      )
    ),
  );
}

Widget nonSessionPersonalizedBox(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente el contenido principal
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Contenido principal
          SvgPicture.asset('assets/vectors/undraw_empty_re_opql.svg', width: 300,),
          const SizedBox(height: 30),
          Text(
            "¡Oh no! No puedes acceder a esta funcionalidad",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            "Inicia sesión para personalizar tus pedidos.",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Row(
            mainAxisSize: MainAxisSize.max, // Ajusta el tamaño del botón
            children: [
              Icon(Icons.arrow_back_rounded, size: 24),
              SizedBox(width: 12),
              Text("Regresar"),
            ],
          ),
        ),
      ),
    ),
  );
}
