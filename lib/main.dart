import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:biophysique/core/theme.dart';
import 'package:biophysique/data/producto_repository.dart';
import 'package:biophysique/data/producto_repository_local.dart';
import 'package:biophysique/features/carrito/carrito.dart';
import 'package:biophysique/features/carrito/carrito_screen.dart';
import 'package:biophysique/features/carrito/pedido_screen.dart';
import 'package:biophysique/features/catalogo/catalogo_screen.dart';
import 'package:biophysique/features/inicio/splash_screen.dart';

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
        '/pedido': (context) => const PedidoScreen(),
      },
    );
  }
}
