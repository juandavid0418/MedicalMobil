import 'package:flutter/material.dart';
import 'package:medicalhelp/24hr.dart';
import 'package:medicalhelp/Mensaje.dart';
import 'package:medicalhelp/MyHomePage.dart';
import 'package:medicalhelp/appbar_nav.dart';
import 'package:medicalhelp/s_intectologia.dart';
import 'package:medicalhelp/s_vendaje.dart';
import 'package:medicalhelp/sos.dart';

class Paginainicio extends StatelessWidget {
  const Paginainicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(preferredSize: Size.fromHeight(50),
        child: AppbarNav(titulo: 'Medical Help')),
        drawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
        //Primera Fila
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Primer Boton
            Column(
              children: [
                Container(
                  width: 170,
                  height: 170,
                  decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 205, 213, 219),
                  borderRadius:
                  BorderRadius.all(Radius.circular(10))),
  	              child: IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const vendaje()));
                          },
                          icon: const Icon(
                            Icons.health_and_safety,
                            size: 150,
                            color: Color.fromARGB(255, 43, 136, 198),
                          ),
                        ),
                        
                      ),
                      Text(
                        "S.Vendaje",
                        style: TextStyle(fontSize: 18),
                        )
               ],
                ),
             //Segundo Boton
                
                Column(
              children: [
                Container(
                  width: 170,
                  height: 170,
                  decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 205, 213, 219),
                  borderRadius:
                  BorderRadius.all(Radius.circular(10))),
  	              child: IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const inyectologia()));
                          },
                          icon: const Icon(
                            Icons.personal_injury,
                            size: 150,
                            color: Color.fromARGB(255, 43, 136, 198),
                          ),
                        ),
                        
                      ),
                      Text(
                        "S.Inyectologia",
                        style: TextStyle(fontSize: 18),
                        )
               ],
                ),
              ],
              
            ),
            //Segunda Fila
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(children: [
                //tercer boton
                Container(
                  width: 170,
                  height: 170,
                  decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 205, 213, 219),
                  borderRadius:
                  BorderRadius.all(Radius.circular(10))),
  	              child: IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const horax24()));
                          },
                          icon: const Icon(
                            Icons.access_time,
                            size: 150,
                            color: Color.fromARGB(255, 43, 136, 198),
                          ),
                        ),
                        
                      ),
                      Text(
                        "S.24 hr",
                        style: TextStyle(fontSize: 18),
                        )
               ],
                ),

                //4to bton
                Column(
              children: [
                Container(
                  width: 170,
                  height: 170,
                  decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 205, 213, 219),
                  borderRadius:
                  BorderRadius.all(Radius.circular(10))),
  	              child: IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const mensaje()));
                          },
                          icon: const Icon(
                            Icons.chat,
                            size: 150,
                            color: Color.fromARGB(255, 43, 136, 198),
                          ),
                        ),
                        
                      ),
                      Text(
                        "S.Linea",
                        style: TextStyle(fontSize: 18),
                        )
               ],
                ),
              ],
            ),
                 
              Column(
              children: [
                IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const sos()));
                          },
                          icon: const Icon(
                            Icons.sos_rounded,
                            size: 50,
                            color: Color.fromARGB(255, 182, 2, 2),
                          ),
                        )
              ],
            )
          
        ],
            )
            



        

        )
        
      
    );
  }
}