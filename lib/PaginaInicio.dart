import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicalhelp/MyHomePage.dart';
import 'package:medicalhelp/agenda.dart';
import 'package:medicalhelp/appbar_nav.dart';
import 'package:medicalhelp/controllers/api_agenda.dart';
import 'package:medicalhelp/controllers/api_paciente.dart';
import 'package:medicalhelp/detalle_paciente_screen.dart';
import 'package:medicalhelp/models/PacienteModel.dart';
import 'package:medicalhelp/utils/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicalhelp/models/AgendaModel.dart';

class Paginainicio extends StatefulWidget {
  const Paginainicio({Key? key}) : super(key: key);

  @override
  _PaginainicioState createState() => _PaginainicioState();
}

class _PaginainicioState extends State<Paginainicio> {
  late Future<List<PacienteModel>> futurePacientes;
  Future<List<AgendaModel>>? futureAgendas;
  int? userId;
  final AgendaApiController agendaApiController =
      AgendaApiController(ApiEndPoints().baseUrl);

  @override
  void initState() {
    super.initState();
    _loadUserId();
    futurePacientes = ApiPaciente.obtenerPacientes();
  }

  _loadUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('user_id');
      futureAgendas = agendaApiController.fetchAgendasByUserId(userId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userId != null && futureAgendas == null) {
      futureAgendas = agendaApiController.fetchAgendasByUserId(userId!);
    }

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
      body: userId != null
          ? FutureBuilder<List<AgendaModel>>(
              future: agendaApiController.fetchAgendasByUserId(userId!),
              builder: (context, agendaSnapshot) {
                if (agendaSnapshot.connectionState == ConnectionState.done &&
                    agendaSnapshot.hasData) {
                  List<int> pacienteIdsEnAgendas = [];
                  for (AgendaModel agenda in agendaSnapshot.data!) {
                    if (!pacienteIdsEnAgendas.contains(agenda.id_pacientes)) {
                      pacienteIdsEnAgendas.add(agenda.id_pacientes);
                    }
                  }

                  return FutureBuilder<List<PacienteModel>>(
                    future: futurePacientes,
                    builder: (context, pacienteSnapshot) {
                      if (pacienteSnapshot.connectionState ==
                              ConnectionState.done &&
                          pacienteSnapshot.hasData) {
                        List<PacienteModel> pacientesFiltrados =
                            pacienteSnapshot.data!.where((paciente) {
                          return pacienteIdsEnAgendas.contains(paciente.id);
                        }).toList();

                        return Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Tus Pacientes',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: pacientesFiltrados.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        leading: Image.network(
                                          'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png',
                                          width: 50,
                                        ),
                                        title: Text(pacientesFiltrados[index]
                                                .nombre +
                                            ' ' +
                                            pacientesFiltrados[index].apellido),
                                        subtitle: Text(
                                            pacientesFiltrados[index].correo),
                                        trailing: Icon(
                                          Icons.circle,
                                          color: pacientesFiltrados[index]
                                                      .estado ==
                                                  0
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                        onTap:
                                            pacientesFiltrados[index].estado ==
                                                    0
                                                ? () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetallePacienteScreen(
                                                                    paciente:
                                                                        pacientesFiltrados[
                                                                            index])));
                                                  }
                                                : null,
                                      ),
                                      Divider(
                                        // <-- Aquí agregamos el Divider
                                        color: Colors.blue,
                                        thickness: 1.0,
                                        indent: 20.0,
                                        endIndent: 20.0,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          : Center(child: CircularProgressIndicator()),
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
