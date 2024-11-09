import 'package:flutter/material.dart';
import 'screens/bottom_navigation/bottom_navitation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CuentaMe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavitation(),
    );
  }
}