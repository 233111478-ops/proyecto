class Producto {
  final String nombre;
  final String descripcion;
  final String funcion;
  final String propiedades;
  final double precio;
  final String imagen;
  final List<String> categorias;

  const Producto({
    required this.nombre,
    required this.descripcion,
    required this.funcion,
    required this.propiedades,
    required this.precio,
    required this.imagen,
    this.categorias = const [],
  });
}
