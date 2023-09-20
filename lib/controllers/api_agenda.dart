import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medicalhelp/models/AgendaModel.dart';

class AgendaApiController {
  final String baseUrl;

  AgendaApiController(this.baseUrl);

  Future<List<AgendaModel>> fetchAgendas() async {
    final response = await http.get(Uri.parse(baseUrl + 'agendas'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => AgendaModel.fromJson(json)).toList();
    } else {
      throw Exception('No cuentas con una Agenda');
    }
  }

  Future<List<AgendaModel>> fetchAgendasByUserId(int userId) async {
    final response = await http.get(Uri.parse(baseUrl + 'agendas/user/$userId'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => AgendaModel.fromJson(json)).toList();
    } else {
      throw Exception('Intento para encontrar Agenda para $userId');
    }
  }


}
