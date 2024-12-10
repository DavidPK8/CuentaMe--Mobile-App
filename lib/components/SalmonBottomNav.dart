// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../theme/decorations/app_colors.dart';

class Salmonbottomnav extends StatelessWidget {
  const Salmonbottomnav({super.key, required this.currentIndex, required this.ontabChanged});

  final int currentIndex;
  final ValueChanged<int> ontabChanged;

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
        margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        currentIndex: currentIndex,
        selectedItemColor: AppColors.backgroundcolor_1,
        unselectedItemColor: Colors.black12,
        backgroundColor: AppColors.primaryColor,
        onTap: ontabChanged,
        items: [
          SalomonBottomBarItem(icon: const Icon(Icons.home_rounded), title: const Text("Inicio")),
          SalomonBottomBarItem(icon: const Icon(Icons.list_rounded), title: const Text("Catálogo")),
          SalomonBottomBarItem(icon: const Icon(Icons.shopping_cart), title: const Text("Carrito")),
          SalomonBottomBarItem(icon: const Icon(Icons.person), title: const Text("Mi Cuenta")),
        ]
    );
  }
}
