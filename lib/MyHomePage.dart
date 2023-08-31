import 'package:flutter/material.dart';
import 'package:medicalhelp/PaginaInicio.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _emailocontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "My Medical\n      Help",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                Text("Login")
              ],
            ),
            //imagen
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/logo.png"))),
            ),
            //campo de correo
            TextFormField(
              controller: _emailocontroller,
              decoration: InputDecoration(
                  label: Text("Correo"), icon: Icon(Icons.email)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa porfavor un correo';
                }
                if (!value.contains("@") || !value.contains(".")) {
                  return "Ingrese un correo valido";
                }

                return null;
              },
            ),

            //campo de contraseña
            TextFormField(
              controller: _passwordcontroller,
              decoration: InputDecoration(
                  label: Text("password"), icon: Icon(Icons.password)),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ingrese porfavor una contraseña';
                }
                if (value.length < 4) {
                  return 'Ingrese una contraseña mayor a 4 digitos';
                }
                return null;
              },
            ),

            //boton
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Paginainicio()));
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Espera un segundo')),
                  );
                }
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
