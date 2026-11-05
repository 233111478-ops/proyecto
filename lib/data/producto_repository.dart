import '../models/producto.dart';

/// Contrato para obtener productos.
/// Etapa 1: implementación local. Etapa 2: implementación con Firebase.
abstract class ProductoRepository {
  Future<List<Producto>> obtenerProductos();
}
