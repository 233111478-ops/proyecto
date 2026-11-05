import 'package:flutter/material.dart';

import 'theme.dart';
import 'splash_screen.dart';
import 'screens/catalogo_screen.dart';

void main() {
  runApp(const BiophysiqueApp());
}

class BiophysiqueApp extends StatelessWidget {
  const BiophysiqueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biophysique',
      debugShowCheckedModeBanner: false,
      theme: buildBiophysiqueTheme(),
      home: const SplashScreen(),
      routes: {'/catalogo': (context) => const CatalogoScreen()},
    );
  }
}
