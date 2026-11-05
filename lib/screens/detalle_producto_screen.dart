
import 'package:flutter/material.dart';
import '../models/producto.dart';

class DetalleProductoScreen extends StatelessWidget {
  final Producto producto;

  const DetalleProductoScreen({
    super.key,
    required this.producto,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F3),
      appBar: AppBar(
        title: Text(producto.nombre),
        backgroundColor: const Color(0xFF377C38),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 230,
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(
                  producto.imagen,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.inventory_2_outlined,
                      size: 100,
                      color: Colors.green,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 25),

            Text(
              producto.nombre,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              '\$${producto.precio.toStringAsFixed(2)} MXN',
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF377C38),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Descripcion del producto',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              producto.descripcion,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 22),

            const Text(
              'Para que sirve',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              producto.funcion,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 22),

            const Text(
              'Propiedades',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              producto.propiedades,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            const Text(
              'Informacion orientativa. Consulta las indicaciones del producto y de un profesional de salud.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
