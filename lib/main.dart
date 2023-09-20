import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicalhelp/MyHomePage.dart';
import 'package:medicalhelp/PaginaInicio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Medical Help',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}


