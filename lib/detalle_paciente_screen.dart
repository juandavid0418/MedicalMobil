import 'package:flutter/material.dart';
import 'package:medicalhelp/controllers/api_historia.dart';
import 'package:medicalhelp/models/HistoriaModel.dart';
import 'package:medicalhelp/models/PacienteModel.dart';

class DetallePacienteScreen extends StatefulWidget {
  final PacienteModel paciente;

  DetallePacienteScreen({required this.paciente});

  @override
  _DetallePacienteScreenState createState() => _DetallePacienteScreenState();
}

class _DetallePacienteScreenState extends State<DetallePacienteScreen> {
  late Future<List<HistoriaModel>> futureHistoria;

  @override
  void initState() {
    super.initState();
    futureHistoria = ApiHistoria.obtenerHistoriasPorPacienteId(widget.paciente.id);
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.paciente.nombre + ' ' + widget.paciente.apellido),
    ),
    body: RefreshIndicator(
      onRefresh: _obtenerHistorias,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.network('https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png', width: 100,),
                    SizedBox(height: 10),
                    Text('${widget.paciente.nombre} ${widget.paciente.apellido}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.info_outline),
                      onPressed: () => _mostrarDetalles(context),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text('Historia Clínica', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              FutureBuilder<List<HistoriaModel>>(
                future: futureHistoria,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (snapshot.data!.isEmpty) {
                      return Text('No hay historias disponibles para este paciente.');
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        HistoriaModel historia = snapshot.data![index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fecha: ${historia.created_at != null ? historia.created_at!.toLocal().toString() : 'No disponible'}', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Diagnóstico: ${historia.diagnostico}'),
                            Text('Signos Vitales: ${historia.signosvitales}'),
                            Text('Antecedentes Alérgicos: ${historia.antecedentesalergicos}'),
                            Text('Evolución: ${historia.evolucion}'),
                            Text('Tratamiento: ${historia.tratamiento}'),
                            Divider(color: Colors.grey),
                          ],
                        );
                      }
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => _mostrarFormularioCrearHistoria(context),
      child: Icon(Icons.add),
    ),
  );
}

  Future<void> _obtenerHistorias() async {
    setState(() {
      futureHistoria = ApiHistoria.obtenerHistoriasPorPacienteId(widget.paciente.id);
    });
  }
  void _mostrarDetalles(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Correo: ${widget.paciente.correo}'),
              Text('Teléfono: ${widget.paciente.telefono}'),
              Text('Dirección: ${widget.paciente.direccion}'),
              Text('Ciudad: ${widget.paciente.ciudad}'),
              Text('Documento: ${widget.paciente.documento}'),
            ],
          ),
        );
      },
    );
  }

 void _mostrarFormularioCrearHistoria(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  final HistoriaModel historia = HistoriaModel(
    id: 0, 
    diagnostico: '',
    signosvitales: '',
    antecedentesalergicos: '',
    evolucion: '',
    tratamiento: '',
    pacientes_id: widget.paciente.id,
  );

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Diagnóstico'),
                  onSaved: (value) => historia.diagnostico = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Introduce el diagnóstico' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Signos Vitales'),
                  onSaved: (value) => historia.signosvitales = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Introduce los signos vitales' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Antecedentes Alérgicos'),
                  onSaved: (value) =>
                      historia.antecedentesalergicos = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Introduce los antecedentes alérgicos' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Evolución'),
                  onSaved: (value) => historia.evolucion = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Introduce la evolución' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Tratamiento'),
                  onSaved: (value) => historia.tratamiento = value ?? '',
                  validator: (value) =>
                      value!.isEmpty ? 'Introduce el tratamiento' : null,
                ),
                ElevatedButton(
                  child: Text("Crear historia"),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      try {
                        await ApiHistoria.crearHistoria(historia);

                        // Cierra la hoja modal
                        Navigator.of(context).pop();

                        // Actualiza el estado para obtener las historias actualizadas
                        setState(() {
                          futureHistoria =
                              ApiHistoria.obtenerHistoriasPorPacienteId(widget.paciente.id);
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error al crear historia: $e")));
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

}
