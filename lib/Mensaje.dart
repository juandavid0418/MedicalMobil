import 'package:flutter/material.dart';

class mensaje extends StatelessWidget {
  const mensaje({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat en linea'),
      ),
      body: Column(
        children: [
          Expanded(
            
            child:(Column(
              children: [
                Image.network("https://www.shutterstock.com/image-vector/bot-icon-robot-logotype-flat-260nw-1497911912.jpg"),
                Text("Hoka soy Boty, en un momento te hablara un asesor")
              ],
            )),
            
          ),
          Container(
            color: Colors.grey.shade300,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                hintText: 'Habla con asesor'
              ),
            ),
          )
        ],
      ),
    );
  }
}