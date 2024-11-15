import 'package:cuentame_tesis/authentication/auth_provider.dart';
import 'package:cuentame_tesis/app/presentation/bottom_navigation/bottom_navitation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CuentaMe',
      home: BottomNavitation(),
    );
  }
}
