import 'package:flutter/material.dart';

class AppbarNav extends StatelessWidget {
  final String titulo;

  const AppbarNav({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titulo),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: Text(
              "Juan David Giraldo",
              style: TextStyle(
                fontSize:
                    16, // Puedes ajustar este valor según tus preferencias
                color: Colors.white, // Color del texto
              ),
            ),
          ),
        ),
        const SizedBox(width: 2.0), // Espacio entre el nombre y el ícono
        const Icon(Icons.account_box),
      ],
      backgroundColor: Color.fromARGB(0xFF, 0xE7, 0x4C, 0x3C),
    );
  }
}
