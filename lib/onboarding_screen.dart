import 'package:flutter/material.dart';

import 'theme.dart';
import 'custom_button.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const int _totalPaginas = 3;

  final PageController _controller = PageController();
  int _paginaActual = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _esUltima => _paginaActual == _totalPaginas - 1;

  void _siguiente() {
    if (_esUltima) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Dibuja una página: imagen en círculo, título y texto.
  Widget _pagina({
    required String imagen,
    required String titulo,
    required String texto,
  }) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 240,
            height: 240,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.acento.withValues(alpha: 0.35),
                  blurRadius: 32,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                imagen,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.primarioClaro,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.spa,
                    color: AppColors.primario,
                    size: 96,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            titulo,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: AppColors.primario),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            texto,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                ),
          ),
        ],
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
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (indice) {
                    setState(() => _paginaActual = indice);
                  },
                  children: [
                    _pagina(
                      imagen: 'img/onboarding_1.png',
                      titulo: 'Bienvenido a Biophysique',
                      texto: 'Descubre productos naturistas recomendados por '
                          'tu médico homeópata, desde tu celular.',
                    ),
                    _pagina(
                      imagen: 'img/onboarding_2.png',
                      titulo: 'Conoce cada producto',
                      texto: 'Consulta para qué sirve, sus propiedades y sus '
                          'características antes de elegir.',
                    ),
                    _pagina(
                      imagen: 'img/onboarding_3.png',
                      titulo: 'Arma tu pedido',
                      texto: 'Agrega al carrito lo que necesitas y revisa el '
                          'resumen con el total de tu compra.',
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_totalPaginas, (indice) {
                  final activa = indice == _paginaActual;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: activa ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: activa
                          ? AppColors.primario
                          : AppColors.acento.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: CustomButton(
                  texto: _esUltima ? 'Comenzar' : 'Siguiente',
                  icono: _esUltima ? Icons.check : Icons.arrow_forward,
                  onPressed: _siguiente,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}