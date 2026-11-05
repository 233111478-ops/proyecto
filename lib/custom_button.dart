import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final IconData? icono;
  final bool expandido;

  const CustomButton({
    super.key,
    required this.texto,
    required this.onPressed,
    this.icono,
    this.expandido = true,
  });

  @override
  Widget build(BuildContext context) {
    final Widget boton = icono != null
        ? ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(icono),
            label: Text(texto),
          )
        : ElevatedButton(onPressed: onPressed, child: Text(texto));

    if (!expandido) return boton;
    return SizedBox(width: double.infinity, child: boton);
  }
}