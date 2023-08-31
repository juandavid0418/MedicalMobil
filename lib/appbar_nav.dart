import 'package:flutter/material.dart';

class AppbarNav extends StatelessWidget {
  final String titulo;

  const AppbarNav({super.key,required this.titulo});

  @override
  Widget build(BuildContext context) {
    return AppBar(
          title: Text(titulo),
          actions: const [
            Text("Juan David Giraldo",style: TextStyle(),),
            Icon(Icons.account_box),
            Icon(Icons.notifications),
          ],
          backgroundColor: Color.fromARGB(255, 18, 139, 209),
        );
  }
}