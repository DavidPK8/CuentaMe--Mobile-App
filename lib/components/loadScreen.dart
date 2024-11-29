import 'package:flutter/material.dart';

import '../theme/decorations/app_colors.dart';

class Loadscreen extends StatelessWidget {
  const Loadscreen({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset('assets/images/logo_complete.png', scale: 2.10,),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/resource_gift.png')
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(color: AppColors.primaryColor,),
                const SizedBox(height: 24,),
                Text(description, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
