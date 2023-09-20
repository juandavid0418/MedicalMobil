import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:medicalhelp/MyHomePage.dart';
import 'package:medicalhelp/PaginaInicio.dart';
import 'package:medicalhelp/models/UserModel.dart';
import 'package:medicalhelp/utils/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail(BuildContext context) async {
    var endpoints = ApiEndPoints();
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(endpoints.baseUrl + endpoints.authEndpoints.loginEmail);

    print('email: ${emailController.text}');
    print('password: ${passwordController.text}');

    Map body = {
      'email': emailController.text.trim(),
      'password': passwordController.text
    };
    
    print('Sending request to $url');

    try {
      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);
      
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final json = jsonDecode(response.body);

      if (json['access_token'] == true) {
        var token = json['token_type'];
        final SharedPreferences? prefs = await _prefs;
        await prefs?.setString('token', token);
        await prefs?.setString('user_email', emailController.text.trim());  // Guardar email
        UserModel user = await UserxEmail(emailController.text.trim());
        await prefs?.setInt('user_id', user.id);  // Guardar id del usuario
        int? checkUserId = prefs?.getInt('user_id');
        print('User ID from SharedPreferences: $checkUserId');

        
        emailController.clear();
        passwordController.clear();

        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Paginainicio()));
      } else {
        throw json["Message"] ?? "Error";
      }

    } catch (error) {
      print(error);
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }
  Future<UserModel> UserxEmail(String email) async {
  var endpoints = ApiEndPoints();
  var headers = {'Content-Type': 'application/json'};
  var url = Uri.parse(endpoints.baseUrl + endpoints.apiUserEmail.historiaBaseEndpoint + "/$email");

  try {
    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return UserModel.fromJson(json);  // Usamos el modelo aquí
    } else {
      throw jsonDecode(response.body)["Message"] ?? "Error";
    }
  } catch (error) {
    print(error);
    throw Exception('Error para encontrar Usuario');  // Es mejor lanzar una excepción que retornar null
  }
}

}
