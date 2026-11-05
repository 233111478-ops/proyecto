# Biophysique

Descripción
Biophysique es una aplicación móvil que se desarrollo en Flutter para los clientes de Biophysique en el cual un negocio de productos naturistas en Ixmiquilpan, Hidalgo. Permite consultar el catálogo de productos conocer para qué sirve cada uno, sus propiedades y características, y organizar la compra mediante un carrito, facilitando la selección de los productos indicados en la receta del médico homeópata.

## Cliente (Ruta A)
- **Cliente:** Biophysique, negocio dedicado a la venta de productos naturistas recomendados por un médico homeópata.
- **Ubicación:** Ixmiquilpan, Hidalgo, México.
- **Necesidad:** Actualmente el inventario y el registro de ventas se llevan de forma manual por lo que causa dificulta su organización asi mismo los clientes no cuentan con un medio para consultar la información de los productos por su cuenta. 

### Problema y necesidades detectadas segun las entrevistas
- Biophysique lleva inventario ventas y pedidos de forma manual por lo que un solo dia sin esto atrasa el inventario
- Registrar ventas	

### Usuarios
- **Clientes:** consultan para qué sirve cada producto sus caracteriticas y organizan sus compras.
- **Médico homeópata:** indica los productos que necesita cada paciente.
- **Personal del negocio:** consulta los productos y prepara los pedidos.


## Integrantes
| Nombre | Matrícula | Usuario de GitHub | Responsabilidad |
|---|---|---|---|
| Raúl Lora Lira | 233111790 | [@RobinLora](https://github.com/RobinLora) | Entrevista con el cliente; catálogo de productos y filtrado por categorías |
| Ana Karen Vera García | 233110950 | [@anavera](https://github.com/anavera) | Documentación del proyecto; desarrollo de la mayor parte de la interfaz, incluyendo la pantalla de bienvenida (splash) |
| Pedro Omar Marcelino Martínez | 233111478 | [@mtz747770-sys](https://github.com/mtz747770-sys) | Carrito de compras (agregar y eliminar productos, cálculo del total) y corrección y organización del repositorio en GitHub |

**Materia:** Programación Móvil · **Docente:** Mario Alberto Gea Pérez · **Grupo:** 9° B · **Periodo:** Septiembre–Diciembre 2026
Universidad Politécnica Metropolitana de Hidalgo, Ingeniería en Tecnologías de la Información.

## Funcionalidades de la Etapa 1
- **Pantalla de bienvenida (splash):** muestra el icono de Biophysique al abrir la app.
- **Catálogo de productos:** listado con imagen, nombre y precio, con búsqueda por nombre y filtrado por categorías.
- **Carrito de compras:** agregar y eliminar productos y calcular el total de la compra.
- **Resumen del pedido:** muestra los productos seleccionados y el total.

## Instalación y ejecución

### Requisitos
- Flutter 3.47.2
- Dart 3.13.2
- VS Code con las extensiones de Flutter y Dart
- Emulador Android o dispositivo físico

### Pasos
```bash
git clone https://github.com/[COMPLETAR]/biophysique.git
cd biophysique
flutter pub get
flutter run
```

## Estructura del proyecto
```
lib/
├── core/        # Tema visual, colores, constantes, rutas y componentes reutilizables
├── features/    # Una carpeta por funcionalidad: bienvenida, catálogo, detalle, carrito y pedido
├── models/      # Modelo de producto y de los elementos del carrito
├── data/        # Repositorio abstracto e implementación local con datos de prueba
└── main.dart    # Punto de entrada, registro de Providers y navegación
```