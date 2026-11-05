import 'package:flutter/material.dart';

import 'carrito.dart';

/// Ícono del carrito con el número de artículos. Abre la pantalla del carrito.
class CarritoIcono extends StatelessWidget {
  final Color? color;

  const CarritoIcono({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Carrito.instancia,
      builder: (context, _) {
        final cantidad = Carrito.instancia.totalArticulos;
        return IconButton(
          tooltip: 'Carrito',
          onPressed: () => Navigator.pushNamed(context, '/carrito'),
          icon: Badge(
            isLabelVisible: cantidad > 0,
            label: Text('$cantidad'),
            child: Icon(Icons.shopping_cart_outlined, color: color),
          ),
        );
      },
    );
  }
}
