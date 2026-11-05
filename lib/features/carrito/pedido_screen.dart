import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:biophysique/core/theme.dart';
import 'package:biophysique/features/carrito/carrito.dart';

/// Pantalla con formulario para capturar los datos del pedido.
class PedidoScreen extends StatefulWidget {
  const PedidoScreen({super.key});

  @override
  State<PedidoScreen> createState() => _PedidoScreenState();
}

class _PedidoScreenState extends State<PedidoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _telefonoCtrl = TextEditingController();
  final _notasCtrl = TextEditingController();

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _telefonoCtrl.dispose();
    _notasCtrl.dispose();
    super.dispose();
  }

  String? _validarNombre(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Escribe tu nombre';
    if (texto.length < 3) return 'El nombre es muy corto';
    return null;
  }

  String? _validarTelefono(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) return 'Escribe tu teléfono';
    if (texto.length != 10) return 'El teléfono debe tener 10 dígitos';
    return null;
  }

  void _enviarPedido() {
    if (!_formKey.currentState!.validate()) return;
    context.read<Carrito>().vaciar();
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final carrito = context.watch<Carrito>();

    return Scaffold(
      appBar: AppBar(title: const Text('Datos del pedido')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${carrito.totalArticulos} artículos',
                        style: const TextStyle(color: AppColors.textoPrincipal),
                      ),
                      Text(
                        'Total: \$${carrito.total.toStringAsFixed(2)} MXN',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primario,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              TextFormField(
                controller: _nombreCtrl,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: _validarNombre,
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _telefonoCtrl,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: const InputDecoration(
                  labelText: 'Teléfono (10 dígitos)',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: _validarTelefono,
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _notasCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Notas para el doctor (opcional)',
                  prefixIcon: Icon(Icons.notes),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton.icon(
                onPressed: _enviarPedido,
                icon: const Icon(Icons.send),
                label: const Text(
                  'Enviar pedido',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
