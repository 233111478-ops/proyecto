import '../models/producto.dart';
import 'producto_repository.dart';
import 'productos_neolife.dart';

/// Implementación con datos locales (lista fija en productos_neolife.dart).
class ProductoRepositoryLocal implements ProductoRepository {
  @override
  Future<List<Producto>> obtenerProductos() async => productosNeoLife;
}
