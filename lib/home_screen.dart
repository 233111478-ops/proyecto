import 'package:flutter/material.dart';

import 'theme.dart';
import 'custom_button.dart';
import 'carrito/carrito_icono.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Cambiar por el nombre real del médico (confirmarlo con el cliente).
  static const String _nombreDoctor = 'Dr. Nombre Apellido';

  void _proximamente(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensaje)));
  }

  /// Tarjeta de categoría; ocupa una cuarta parte del ancho.
  Widget _categoria(BuildContext context, IconData icono, String texto) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _proximamente(context, 'Aquí se filtrará por $texto'),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm + 4,
            horizontal: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icono, color: AppColors.primario, size: 26),
              const SizedBox(height: AppSpacing.xs),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  texto,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textoPrincipal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.fondo, AppColors.primarioClaro],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Encabezado: logo y carrito
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('img/logo.png', height: 36),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: CarritoIcono(color: AppColors.primario),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Bienestar natural',
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontSize: 26, color: AppColors.primario),
                ),
                const SizedBox(height: AppSpacing.sm),

                // Tarjeta del médico
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm + 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColors.primarioClaro,
                        child: Icon(
                          Icons.medical_services_outlined,
                          color: AppColors.primario,
                        ),
                      ),
                      SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Médico homeópata',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textoSecundario,
                              ),
                            ),
                            Text(
                              _nombreDoctor,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textoPrincipal,
                              ),
                            ),
                            SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 14,
                                  color: AppColors.primario,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  'Ixmiquilpan, Hidalgo',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textoSecundario,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Tarjeta principal: usa el espacio que sobra
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 150),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.acento.withValues(
                                        alpha: 0.35,
                                      ),
                                      blurRadius: 26,
                                      spreadRadius: 3,
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'img/home.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        const Text(
                          'Tu camino hacia el bienestar',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textoPrincipal,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Consulta para qué sirve cada producto y arma tu pedido.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        CustomButton(
                          texto: 'Explorar productos',
                          icono: Icons.storefront,
                          onPressed: () =>
                              Navigator.pushNamed(context, '/catalogo'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                // Categorías
                const Text(
                  'Categorías',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textoPrincipal,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    _categoria(context, Icons.eco_outlined, 'Digestión'),
                    const SizedBox(width: AppSpacing.sm),
                    _categoria(context, Icons.spa_outlined, 'Relajación'),
                    const SizedBox(width: AppSpacing.sm),
                    _categoria(context, Icons.shield_outlined, 'Defensas'),
                    const SizedBox(width: AppSpacing.sm),
                    _categoria(
                      context,
                      Icons.accessibility_new,
                      'Articulaciones',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
