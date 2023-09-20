import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medicalhelp/models/HistoriaModel.dart';
import 'package:medicalhelp/utils/api_endpoint.dart';

class ApiHistoria {
  static Future<List<HistoriaModel>> obtenerHistoriasPorPacienteId(int id) async {
    var endpoints = ApiEndPoints();
    var url = Uri.parse(endpoints.baseUrl + endpoints.apiHistoria.historiaBaseEndpoint + '/' + id.toString());
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return HistoriaModel.fromJsonList(json.decode(response.body));
    } else {
      throw ('Este cliente no cuenta con historias');
    }
  }

  static Future<HistoriaModel> crearHistoria(HistoriaModel historia) async {
    var endpoints = ApiEndPoints();
    var url = Uri.parse(endpoints.baseUrl + endpoints.crearHistoria.crearHistoriaEndpoint);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    
    var response = await http.post(url, headers: headers, body: json.encode({
      'diagnostico': historia.diagnostico,
      'signosvitales': historia.signosvitales,
      'antecedentesalergicos': historia.antecedentesalergicos,
      'evolucion': historia.evolucion,
      'tratamiento': historia.tratamiento,
      'pacientes_id': historia.pacientes_id
    }));
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      return HistoriaModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error para crear historia');
    }
  }
}
