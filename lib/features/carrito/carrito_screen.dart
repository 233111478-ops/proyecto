import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:biophysique/core/theme.dart';
import 'package:biophysique/features/carrito/carrito.dart';

class CarritoScreen extends StatelessWidget {
  const CarritoScreen({super.key});

  Future<void> _confirmarPedido(BuildContext context) async {
    final enviado = await Navigator.pushNamed(context, '/pedido');
    if (enviado != true || !context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('¡Pedido registrado! Gracias por tu compra.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _vaciarCarrito(BuildContext context) async {
    final carrito = context.read<Carrito>();
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Vaciar carrito'),
        content: const Text('¿Quieres quitar todos los productos?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Vaciar'),
          ),
        ],
      ),
    );
    if (confirmado == true) carrito.vaciar();
  }

  Widget _carritoVacio(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              size: 90,
              color: AppColors.textoSecundario,
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'Tu carrito está vacío',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textoPrincipal,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Text('Agrega productos desde el catálogo.'),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton.icon(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/catalogo'),
              icon: const Icon(Icons.storefront),
              label: const Text('Ver catálogo'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tarjetaItem(BuildContext context, ItemCarrito item) {
    final carrito = context.read<Carrito>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: Image.asset(
                item.producto.imagen,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.inventory_2_outlined,
                  size: 40,
                  color: AppColors.primario,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.producto.nombre,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textoPrincipal,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '\$${item.producto.precio.toStringAsFixed(2)} MXN c/u',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textoSecundario,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Subtotal: \$${item.subtotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: AppColors.primario,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      color: AppColors.primario,
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => carrito.disminuir(item.producto),
                    ),
                    Text(
                      '${item.cantidad}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textoPrincipal,
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      color: AppColors.primario,
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () => carrito.incrementar(item.producto),
                    ),
                  ],
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                    visualDensity: VisualDensity.compact,
                  ),
                  onPressed: () => carrito.eliminar(item.producto),
                  child: const Text('Quitar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _resumen(BuildContext context, Carrito carrito) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total (${carrito.totalArticulos} artículos)',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textoPrincipal,
                  ),
                ),
                Text(
                  '\$${carrito.total.toStringAsFixed(2)} MXN',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primario,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _confirmarPedido(context),
                icon: const Icon(Icons.check_circle_outline),
                label: const Text(
                  'Confirmar pedido',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final carrito = context.watch<Carrito>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi carrito'),
        actions: [
          if (!carrito.estaVacio)
            IconButton(
              tooltip: 'Vaciar carrito',
              icon: const Icon(Icons.delete_sweep_outlined),
              onPressed: () => _vaciarCarrito(context),
            ),
        ],
      ),
      body: carrito.estaVacio
          ? _carritoVacio(context)
          : ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: carrito.items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) =>
                  _tarjetaItem(context, carrito.items[index]),
            ),
      bottomNavigationBar: carrito.estaVacio
          ? null
          : _resumen(context, carrito),
    );
  }
}
