import 'package:flutter/material.dart';

import 'theme.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _irAlOnboarding();
  }

  Future<void> _irAlOnboarding() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.fondo, AppColors.primarioClaro],
          ),
        ),
        child: Stack(
          children: [
            // Círculos decorativos de fondo
            Positioned(
              top: -70,
              right: -70,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.acento.withValues(alpha: 0.18),
                ),
              ),
            ),
            Positioned(
              bottom: -90,
              left: -80,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primario.withValues(alpha: 0.10),
                ),
              ),
            ),
            Positioned(
              top: 140,
              left: -30,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.acento.withValues(alpha: 0.12),
                ),
              ),
            ),

            // Contenido con animación de entrada
            SafeArea(
              child: Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 1200),
                  curve: Curves.easeOut,
                  builder: (context, valor, hijo) {
                    return Opacity(
                      opacity: valor,
                      child: Transform.scale(
                        scale: 0.85 + 0.15 * valor,
                        child: hijo,
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 230,
                        height: 230,
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.acento.withValues(alpha: 0.40),
                              blurRadius: 40,
                              spreadRadius: 6,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'img/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      const Text(
                        'Tu bienestar natural',
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primario,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Pie de la pantalla
            const Positioned(
              left: 0,
              right: 0,
              bottom: 32,
              child: Text(
                'Ixmiquilpan, Hidalgo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.8,
                  color: AppColors.textoSecundario,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}