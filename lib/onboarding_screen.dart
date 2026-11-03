import 'package:flutter/material.dart';

import 'theme.dart';
import 'custom_button.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    width: 160,
                    height: 160,
                    color: AppColors.primario,
                    child: const Icon(Icons.spa, color: Colors.white, size: 80),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Conoce lo natural',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Consulta para qué sirve cada producto naturista, '
                  'sus propiedades y arma tu pedido desde tu celular.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xl),
                CustomButton(
                  texto: 'Comenzar',
                  icono: Icons.arrow_forward,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}