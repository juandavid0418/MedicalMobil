import 'package:flutter/material.dart';
import 'package:medicalhelp/PaginaInicio.dart';
import 'package:medicalhelp/controllers/login_controller.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // <--- Agregar este widget para centrar el contenido horizontalmente
        child: Form(
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
                  Text("Loginn")
                ],
              ),
              //imagen
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("assets/logo.png"))),
              ),
              //campo de correo
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: loginController.emailController,
                  decoration: InputDecoration(
                    label: Text("Correo"),
                    icon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa por favor un correo';
                    }
                    if (!value.contains("@") || !value.contains(".")) {
                      return "Ingrese un correo válido";
                    }
                    return null;
                  },
                ),
              ),
              //campo de contraseña
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: loginController.passwordController,
                  decoration: InputDecoration(
                    label: Text("Contraseña"),
                    icon: Icon(Icons.vpn_key),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese por favor una contraseña';
                    }
                    if (value.length < 4) {
                      return 'Ingrese una contraseña mayor a 4 dígitos';
                    }
                    return null;
                  },
                ),
              ),
              //boton
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await loginController.loginWithEmail(context);
                  }
                },
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
