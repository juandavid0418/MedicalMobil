import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicalhelp/MyHomePage.dart';
import 'package:medicalhelp/PaginaInicio.dart';
import 'package:medicalhelp/controllers/api_agenda.dart';
import 'package:medicalhelp/controllers/api_paciente.dart';
import 'package:medicalhelp/models/AgendaModel.dart';
import 'package:medicalhelp/appbar_nav.dart';
import 'package:medicalhelp/models/PacienteModel.dart';
import 'package:medicalhelp/utils/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Agenda extends StatefulWidget {
  const Agenda({Key? key}) : super(key: key);

  @override
  _Agenda createState() => _Agenda();
}

class _Agenda extends State<Agenda> {
  final agendaApiController = AgendaApiController(ApiEndPoints().baseUrl);
  late Future<List<AgendaModel>> futureAgendas;
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
    futureAgendas = agendaApiController.fetchAgendas();
  }

  _loadUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('user_id');
      futureAgendas = agendaApiController.fetchAgendasByUserId(userId!);
    });
  }

  Map<int, PacienteModel> detallesPacientes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppbarNav(titulo: 'Medical Help'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(0xFF, 0xE7, 0x4C, 0x3C),
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar Sesión'),
              onTap: () async {
                final SharedPreferences? prefs =
                    await SharedPreferences.getInstance();
                prefs?.clear();
                Get.offAll(MyHomePage());
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<AgendaModel>>(
        future: futureAgendas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            // Filtrar las agendas por estado 0
            List<AgendaModel> agendasFiltradas =
                snapshot.data!.where((agenda) => agenda.estado == 0).toList();

            if (agendasFiltradas.isEmpty) {
              return Center(child: Text('No hay datos en la agenda'));
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Icon(Icons.calendar_today, size: 48),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Tu Agenda',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: agendasFiltradas.length,
                    itemBuilder: (BuildContext context, int index) {
                      AgendaModel agenda = agendasFiltradas[index];

                      if (detallesPacientes[agenda.id_pacientes] == null) {
                        ApiPaciente.obtenerPacientePorId(agenda.id_pacientes)
                            .then((paciente) {
                          setState(() {
                            detallesPacientes[agenda.id_pacientes] = paciente;
                          });
                        });
                        return Center(
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                title: Center(
                                    child: Text(
                                        '${agenda.fecha_inicio} - ${agenda.fecha_fin}')),
                                subtitle: Center(
                                    child: Text(
                                        'Hora Inicio: ${agenda.hora} - Hora Fin: ${agenda.hora_fin}')),
                              ),
                              Text('Cargando detalles del paciente...',
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        );
                      } else {
                        PacienteModel paciente =
                            detallesPacientes[agenda.id_pacientes]!;
                        return Center(
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                title: Center(
                                    child: Text(
                                        '${agenda.fecha_inicio} - ${agenda.fecha_fin}')),
                                subtitle: Center(
                                    child: Text(
                                        'Hora: ${agenda.hora} - Hora Fin: ${agenda.hora_fin}')),
                              ),
                              Text(
                                'Datos del paciente a atender',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                title: Center(
                                    child: Text(
                                        '${paciente.nombre} ${paciente.apellido}')),
                                subtitle: Center(
                                  child: Column(
                                    children: [
                                      Text('Correo: ${paciente.correo}'),
                                      Text('Teléfono: ${paciente.telefono}'),
                                      Text('Direccion: ${paciente.direccion}'),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Agenda()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Paginainicio()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
