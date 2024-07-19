import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/calculator_screen.dart';
import 'screens/bmi_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prova Final - Tópicos Especiais',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/profile': (context) => ProfileScreen(),
        '/calculator': (context) => CalculatorScreen(),
        '/bmi': (context) => BMIScreen(),
      },
    );
  }
}
