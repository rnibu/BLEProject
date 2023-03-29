import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_sms/flutter_sms.dart';



class CareTakerHomePage extends StatefulWidget {
  CareTakerHomePage({Key? key}) : super(key: key);

  @override
  State<CareTakerHomePage> createState() => _CareTakerHomePageState();
}

class _CareTakerHomePageState extends State<CareTakerHomePage> {


  static const intro =
      'To connect pendant, please press search button and then press and hold the button on the pendant until the red light appears. Find the pendant in the list and press \"CONNECT\". Once connected, press the search button and leave on. Your device is ready to use.'
      '\n'
      'Note: if an action is detected, the app will stop searching automatically';

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body:
          SingleChildScrollView(
            child: Center(

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

                        mainAxisAlignment: MainAxisAlignment.start,

                        children: <Widget>[

                          Align(
                            alignment: Alignment.topCenter,
                            child: Image(
                              image: AssetImage('assets/app logo final.png' ),
                              height: MediaQuery.of(context).size.height/2,
                              width: MediaQuery.of(context).size.width/2,
                            ),
                          ),
                          Text('Patients under your care: ', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                          SizedBox(height: MediaQuery.of(context).size.height/54),


                          ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            //physics: const BouncingScrollPhysics(),
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height/20,
                                width: MediaQuery.of(context).size.height/20,
                                color: Colors.amber[100],
                                child: const Center(child: Text('Entry A')),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height/20,
                                width: MediaQuery.of(context).size.height/20,
                                color: Colors.amber[100],
                                child: const Center(child: Text('Entry B')),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height/20,
                                width: MediaQuery.of(context).size.height/20,
                                color: Colors.amber[100],
                                child: const Center(child: Text('Entry C')),
                              ),
                              ExpandablePanel(

                                header: Text('Intructions',style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                                collapsed: Text('', softWrap: true, overflow: TextOverflow.ellipsis),
                                expanded: Text(intro, softWrap: true, ),
                                //theme:  ,
                              ),

                              Container(
                                height: MediaQuery.of(context).size.height/20,
                                width: MediaQuery.of(context).size.height/20,
                                color: Colors.amber[100],
                                child:


                                    DropdownButton<String>(

                                      items: <String>['A', 'B', 'C', 'D'].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (_) {},
                                    ),

                                ),


                            ],
                          )



                          // DropdownButton<String>(
                          //
                          //   items: <String>['A', 'B', 'C', 'D'].map((String value) {
                          //     return DropdownMenuItem<String>(
                          //       value: value,
                          //       child: Text(value),
                          //     );
                          //   }).toList(),
                          //   onChanged: (_) {},
                          // )

                          //Visibility(visible: checkConnect(), child: Text('Click here to pair your device'),)

                        ]

                    )

                  ],

                )
            ),
          )


      /* bottomNavigationBar: BottomNavigationBar(

        onTabChange: (index) => setState(() {
          pageTracer(index1);
        }),
        : [
            GButton(icon: Icons.home, text: 'Home', backgroundColor: Colors.blue),
            GButton(icon: Icons.gps_fixed, text: 'Track', backgroundColor: Colors.red),
            GButton(icon: Icons.device_hub, text: 'Devices', backgroundColor: Colors.black),
            GButton(icon: Icons.person, text: 'Profile', backgroundColor: Colors.green),
        ],

      ),*/

    );
  }
}

