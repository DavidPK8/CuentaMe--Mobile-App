// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Iconheader extends StatelessWidget {
  const Iconheader({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        const SizedBox(width: 12,),
        Text(title, style: Theme.of(context).textTheme.headlineSmall,),
      ],
    );
  }
}
