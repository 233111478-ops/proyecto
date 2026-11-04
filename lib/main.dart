
import 'package:flutter/material.dart';
import 'screens/catalogo_screen.dart';

void main() {
  runApp(const NeoLifeApp());
}

class NeoLifeApp extends StatelessWidget {
  const NeoLifeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeoLife',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF377C38),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF377C38),
        ),
        useMaterial3: true,
      ),
      home: const CatalogoScreen(),
    );
  }
}
