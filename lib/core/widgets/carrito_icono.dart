import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:biophysique/features/carrito/carrito.dart';

/// Ícono del carrito con el número de artículos. Abre la pantalla del carrito.
class CarritoIcono extends StatelessWidget {
  final Color? color;

  const CarritoIcono({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final cantidad = context.watch<Carrito>().totalArticulos;
    return IconButton(
      tooltip: 'Carrito',
      onPressed: () => Navigator.pushNamed(context, '/carrito'),
      icon: Badge(
        isLabelVisible: cantidad > 0,
        label: Text('$cantidad'),
        child: Icon(Icons.shopping_cart_outlined, color: color),
      ),
    );
  }
}
