import 'package:flutter/material.dart';
import 'package:medicalhelp/24hrprice.dart';

class horax24 extends StatefulWidget {
  const horax24({super.key});

  @override
  State<horax24> createState() => _horax24State();
}

class _horax24State extends State<horax24> {
  final _formKey = GlobalKey<FormState>();
  final _pasoscontroller = TextEditingController();
  final _sugerenciacontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Vendaje Servicios"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                children: [
                  Icon(Icons.verified_user),
                  Text(
                    "User",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  Text("J***n D***o")
                ],
              ),
              Column(
                children: [
                  Text(
                    "Seleccion Tu Ubicacion",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Image.network(
                      "https://media.istockphoto.com/id/1268054405/es/vector/mapa-de-destino-de-la-red-de-carreteras-de-conducci%C3%B3n-de-rutas-de-planificaci%C3%B3n-de-rutas.jpg?s=612x612&w=0&k=20&c=KI2S306eXJvVFQ8RtaXMrkhRoN6Kh-VWbo3ZkyoGsS0="),
                ],
              ),
              Column(
                children: [
                  // Text('Precio 24 horas: ${precio24hr['Precio']}'),
                  Text("${precio24hr[0]["Precio"]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                  Text("${precio24hr[0]["Incluye"]}"),

                  TextFormField(
                    controller: _pasoscontroller,
                    decoration: InputDecoration(
                        label: Text("Agregar Pasos a seguir"),
                        icon: Icon(Icons.circle_notifications_rounded)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingresa porfavor pasos para que el enfermero los haga';
                      }

                      return null;
                    },
                  ),

                  TextFormField(
                    controller: _sugerenciacontroller,
                    decoration: InputDecoration(
                        label: Text("Sugerencia"),
                        icon: Icon(Icons.notification_add)),
                    validator: (value) {
                      if (value == null) {
                        return 'Ingrese porfavor una sugerencia';
                      }
                      if (value.length < 10) {
                        return 'Ingrese una sugerencia mas larga';
                      }
                      return null;
                    },
                  ),
            
                  
                ],
              ),
              Column(
                children: [
                  //boton
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          String sugerencia = _sugerenciacontroller.text;
                          String pasos = _pasoscontroller.text;
              
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Espera un segundo')),
                        );
                      }
                    },
                    child: const Text('Enviar'),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
