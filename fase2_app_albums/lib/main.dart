import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Certifique-se que este arquivo existe

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a faixa de "Debug"
      title: 'Personagens Marvel', 
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red, // Cor da barra superior
          foregroundColor: Colors.white, // Cor do texto da barra
          centerTitle: true,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(), 
    );
  }
}