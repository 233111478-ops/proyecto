import 'package:flutter/foundation.dart';

import 'package:biophysique/models/producto.dart';

/// Un producto dentro del carrito con su cantidad.
class ItemCarrito {
  final Producto producto;
  int cantidad;

  ItemCarrito({required this.producto, this.cantidad = 1});

  double get subtotal => producto.precio * cantidad;
}

/// Estado compartido del carrito (MVP local).
/// Se entrega a toda la app con ChangeNotifierProvider en main.dart.
class Carrito extends ChangeNotifier {
  final List<ItemCarrito> _items = [];

  List<ItemCarrito> get items => List.unmodifiable(_items);
  bool get estaVacio => _items.isEmpty;
  int get totalArticulos =>
      _items.fold(0, (suma, item) => suma + item.cantidad);
  double get total => _items.fold(0.0, (suma, item) => suma + item.subtotal);

  int _indice(Producto producto) =>
      _items.indexWhere((item) => item.producto.nombre == producto.nombre);

  void agregar(Producto producto, {int cantidad = 1}) {
    final i = _indice(producto);
    if (i >= 0) {
      _items[i].cantidad += cantidad;
    } else {
      _items.add(ItemCarrito(producto: producto, cantidad: cantidad));
    }
    notifyListeners();
  }

  void incrementar(Producto producto) => agregar(producto);

  void disminuir(Producto producto) {
    final i = _indice(producto);
    if (i < 0) return;
    if (_items[i].cantidad > 1) {
      _items[i].cantidad--;
    } else {
      _items.removeAt(i);
    }
    notifyListeners();
  }

  void eliminar(Producto producto) {
    _items.removeWhere((item) => item.producto.nombre == producto.nombre);
    notifyListeners();
  }

  void vaciar() {
    _items.clear();
    notifyListeners();
  }
}
