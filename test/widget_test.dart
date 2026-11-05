import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:biophysique/features/carrito/carrito.dart';
import 'package:biophysique/data/producto_repository.dart';
import 'package:biophysique/data/producto_repository_local.dart';
import 'package:biophysique/data/productos_neolife.dart';
import 'package:biophysique/main.dart';

void main() {
  testWidgets('La app arranca correctamente', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<ProductoRepository>(
            create: (_) => ProductoRepositoryLocal(),
          ),
          ChangeNotifierProvider(create: (_) => Carrito()),
        ],
        child: const BiophysiqueApp(),
      ),
    );
    expect(find.byType(BiophysiqueApp), findsOneWidget);

    // Deja pasar el tiempo del splash para que no queden timers pendientes
    await tester.pump(const Duration(seconds: 5));
  });

  test('El carrito suma cantidades y calcula el total', () {
    final carrito = Carrito();
    final producto = productosNeoLife.first;

    carrito.agregar(producto);
    carrito.agregar(producto);
    expect(carrito.totalArticulos, 2);
    expect(carrito.total, producto.precio * 2);

    carrito.disminuir(producto);
    expect(carrito.totalArticulos, 1);

    carrito.vaciar();
    expect(carrito.estaVacio, true);
  });
}
