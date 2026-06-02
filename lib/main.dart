import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const BarbeariaApp());
}

class BarbeariaApp extends StatelessWidget {
  const BarbeariaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barbearia Estilo',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}