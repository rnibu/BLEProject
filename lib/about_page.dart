
// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';




class AboutPage extends StatefulWidget {
  AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
      Center(
          child: Stack(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration:  BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFA2C8FC),
                          Color(0xFF9AC3FC),
                          Color(0xFF85B5F8),
                          Color(0xFF66A5FC),
                        ]
                    )
                ),
              ),
              //BottomNavi(),
              Column(
                  //mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[
                    AppBar(),
                    Align(
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage('assets/app logo final.png' ),
                        height: MediaQuery.of(context).size.height/2,
                        width: MediaQuery.of(context).size.width/2,
                      ),
                    ),
                    Text('Version', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
                    SizedBox(height: MediaQuery.of(context).size.height/54),
                    Text('1.10', style: TextStyle(fontSize: 15),)
                    //Visibility(visible: checkConnect(), child: Text('Click here to pair your device'),)

                  ]

              ),
            ],
          )
      ),


    );
  }
}


