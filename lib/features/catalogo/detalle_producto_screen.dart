import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:biophysique/core/theme.dart';
import 'package:biophysique/core/widgets/carrito_icono.dart';
import 'package:biophysique/features/carrito/carrito.dart';
import 'package:biophysique/models/producto.dart';

class DetalleProductoScreen extends StatelessWidget {
  final Producto producto;

  const DetalleProductoScreen({super.key, required this.producto});

  void _agregarAlCarrito(BuildContext context) {
    context.read<Carrito>().agregar(producto);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${producto.nombre} se agregó al carrito'),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  Widget _seccion(String titulo, String contenido) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: AppColors.textoPrincipal,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            contenido,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textoPrincipal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(producto.nombre), actions: [CarritoIcono()]),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.md,
          ),
          child: ElevatedButton.icon(
            onPressed: () => _agregarAlCarrito(context),
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text(
              'Agregar al carrito',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 230,
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(
                producto.imagen,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.inventory_2_outlined,
                    size: 100,
                    color: AppColors.primario,
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              producto.nombre,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.textoPrincipal,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '\$${producto.precio.toStringAsFixed(2)} MXN',
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: AppColors.primario,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _seccion('Descripción del producto', producto.descripcion),
            _seccion('Para qué sirve', producto.funcion),
            _seccion('Propiedades', producto.propiedades),
            const Text(
              'Información orientativa. Consulta las indicaciones del producto y de un profesional de salud.',
              style: TextStyle(color: AppColors.textoSecundario, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
