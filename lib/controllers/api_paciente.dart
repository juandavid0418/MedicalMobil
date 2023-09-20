import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medicalhelp/models/PacienteModel.dart';
import 'package:medicalhelp/utils/api_endpoint.dart';

class ApiPaciente {
  static Future<List<PacienteModel>> obtenerPacientes() async {
    var endpoints = ApiEndPoints();
    var url = Uri.parse(endpoints.baseUrl + endpoints.apiPaciente.getAllPacientesEndpoint);
    var response = await http.get(url);
    
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((paciente) => PacienteModel.fromJson(paciente)).toList();
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }
  
 static Future<PacienteModel> obtenerPacientePorId(int id) async {
    var endpoints = ApiEndPoints();
    var url = Uri.parse('${endpoints.baseUrl}${endpoints.apiPaciente.getAllPacientesEndpoint}/$id');

    var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return PacienteModel.fromJson(jsonResponse);
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }
}



