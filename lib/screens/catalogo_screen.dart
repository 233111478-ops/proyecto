import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../carrito/carrito_icono.dart';
import '../data/producto_repository.dart';
import '../models/producto.dart';
import 'detalle_producto_screen.dart';

class CatalogoScreen extends StatefulWidget {
  final String? categoriaInicial;

  const CatalogoScreen({super.key, this.categoriaInicial});

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  static const Color _verde = Color(0xFF377C38);
  static const List<String> _categorias = [
    'Digestión',
    'Relajación',
    'Defensas',
    'Articulaciones',
  ];

  late final Future<List<Producto>> _productos;
  String busqueda = '';
  String? categoriaSeleccionada;

  @override
  void initState() {
    super.initState();
    categoriaSeleccionada = widget.categoriaInicial;
    _productos = context.read<ProductoRepository>().obtenerProductos();
  }

  List<Producto> _filtrar(List<Producto> productos) {
    return productos.where((producto) {
      final coincideTexto = producto.nombre.toLowerCase().contains(
        busqueda.toLowerCase(),
      );
      final coincideCategoria =
          categoriaSeleccionada == null ||
          producto.categorias.contains(categoriaSeleccionada);
      return coincideTexto && coincideCategoria;
    }).toList();
  }

  Widget _chipCategoria(String etiqueta, String? valor) {
    final seleccionado = categoriaSeleccionada == valor;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(etiqueta),
        selected: seleccionado,
        selectedColor: _verde,
        labelStyle: TextStyle(
          color: seleccionado ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        showCheckmark: false,
        onSelected: (_) {
          setState(() {
            categoriaSeleccionada = valor;
          });
        },
      ),
    );
  }

  Widget _tarjetaProducto(BuildContext context, Producto producto) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetalleProductoScreen(producto: producto),
            ),
          );
        },
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  producto.imagen,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.inventory_2_outlined,
                      size: 65,
                      color: Colors.green,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    producto.nombre,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '\$${producto.precio.toStringAsFixed(2)} MXN',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text('Ver detalles', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F3),
      appBar: AppBar(
        title: const Text(
          'NeoLife - Catalogo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: _verde,
        foregroundColor: Colors.white,
        actions: [CarritoIcono()],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              onChanged: (texto) {
                setState(() {
                  busqueda = texto;
                });
              },
              decoration: InputDecoration(
                hintText: 'Buscar un producto...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _chipCategoria('Todas', null),
                for (final categoria in _categorias)
                  _chipCategoria(categoria, categoria),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Producto>>(
              future: _productos,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('No se pudieron cargar los productos'),
                  );
                }

                final productosFiltrados = _filtrar(snapshot.data ?? []);

                if (productosFiltrados.isEmpty) {
                  return Center(
                    child: Text(
                      categoriaSeleccionada == null
                          ? 'No se encontraron productos'
                          : 'No hay productos en $categoriaSeleccionada',
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.68,
                  ),
                  itemCount: productosFiltrados.length,
                  itemBuilder: (context, index) =>
                      _tarjetaProducto(context, productosFiltrados[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
