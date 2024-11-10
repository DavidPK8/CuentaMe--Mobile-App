import 'package:cuentame_tesis/authentication/auth_provider.dart';
import 'package:cuentame_tesis/presentation/bottom_navigation/bottom_navitation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CuentaMe',
      home: BottomNavitation(),
    );
  }
}
