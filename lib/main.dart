import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'carrito/carrito.dart';
import 'theme.dart';
import 'splash_screen.dart';
import 'screens/catalogo_screen.dart';
import 'screens/carrito_screen.dart';

import 'data/producto_repository.dart';
import 'data/producto_repository_local.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<ProductoRepository>(create: (_) => ProductoRepositoryLocal()),
        ChangeNotifierProvider(create: (_) => Carrito()),
      ],
      child: const BiophysiqueApp(),
    ),
  );
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
      routes: {
        '/catalogo': (context) => CatalogoScreen(
          categoriaInicial:
              ModalRoute.of(context)?.settings.arguments as String?,
        ),
        '/carrito': (context) => const CarritoScreen(),
      },
    );
  }
}
