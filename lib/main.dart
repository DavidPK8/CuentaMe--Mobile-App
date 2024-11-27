import 'package:cuentame_tesis/theme/texts/TextTheme.dart';
import 'package:cuentame_tesis/views/Login/login_screen.dart';
import 'package:cuentame_tesis/views/onBoardingScreen/onBoardScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkIfFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstTime') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CuentaMe',
      theme: AppTextTheme.getAppTheme(),
      home: FutureBuilder<bool>(
        future: _checkIfFirstTime(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == true) {
            return const OnboardScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
