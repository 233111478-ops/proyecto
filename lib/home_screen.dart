import 'package:flutter/material.dart';

import 'theme.dart';
import 'custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biophysique'),
        actions: [
          IconButton(
            tooltip: 'Carrito',
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () => _proximamente(context, 'el carrito'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            'Bienvenido a Biophysique',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.primario,
                ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Productos naturistas recomendados por tu médico homeópata.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          const _TarjetaInfo(
            icono: Icons.search,
            titulo: 'Consulta',
            texto: 'Descubre para qué sirve cada producto y sus propiedades.',
          ),
          const SizedBox(height: AppSpacing.md),
          const _TarjetaInfo(
            icono: Icons.shopping_basket_outlined,
            titulo: 'Arma tu pedido',
            texto: 'Agrega al carrito los productos que necesitas.',
          ),
          const SizedBox(height: AppSpacing.xl),
          CustomButton(
            texto: 'Ver catálogo',
            icono: Icons.storefront,
            onPressed: () => _proximamente(context, 'el catálogo'),
          ),
        ],
      ),
    );
  }

  void _proximamente(BuildContext context, String que) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('Aquí irá $que')));
  }
}

class _TarjetaInfo extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String texto;

  const _TarjetaInfo({
    required this.icono,
    required this.titulo,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primarioClaro,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icono, color: AppColors.primario, size: 32),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textoPrincipal,
                  ),
                ),
                const SizedBox(height: 2),
                Text(texto, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}