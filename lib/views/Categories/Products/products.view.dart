import 'package:cuentame_tesis/theme/decorations/app_colors.dart';
import 'package:cuentame_tesis/utils/token.manager.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {

    final bool isLoggedIn = TokenManager().token.isNotEmpty;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            headerCompose(context, isLoggedIn)
          ],
        )
      ),
    );
  }
}

Widget headerCompose(BuildContext context, bool isLoggedIn){
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
              "assets/images/sweets_patern.png"
          ),
          fit: BoxFit.cover
      )
    ),
    child: Stack(
      children: [
        isLoggedIn ?
        Positioned(
          right: 12,
            top: 12,
            child: IconButton.filledTonal(
              onPressed: (){

              },
              icon: const Icon(EvaIcons.shopping_cart, color: AppColors.primaryColor, size: 22,)
          )
        )
            :
        const SizedBox.shrink()
        ,
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
              child: Text("Productos", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              )
          )
        )
      ],
    )
  );
}
