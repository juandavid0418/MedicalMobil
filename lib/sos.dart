import 'package:flutter/material.dart';

class sos extends StatelessWidget {
  const sos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SOS"),
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Una ambulancia llegara por ti en menos de 3 segundos",style: TextStyle(color: Colors.red,fontSize: 30),),
          Image.network("https://cdn-icons-png.flaticon.com/512/3989/3989428.png")
        ],
      ),
    );
  }
}