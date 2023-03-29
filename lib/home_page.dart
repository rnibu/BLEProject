import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_sms/flutter_sms.dart';



class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser!;
  int index1 = 0;
  String device = '';
  List<String> info = [];
  List<String> recipents = [];
  Future getDevices() async{
    await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: user.email).get().then(
          (snapshot) => snapshot.docs.forEach((document){
        //print(document.reference);
        device = document.reference.id;
        //GetUserInfo(documentID: device,);
      }),
    );
  }


  Future<Position> _determinePosition() async {

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled){
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();

      if(permission == LocationPermission.denied){
        return Future.error('Location services denied');
      }
    }


    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  void _sendSMS(String message, List<String> recipents)async{
    String _result = await sendSMS(message: message, recipients: recipents, sendDirect: true);
    print(_result);
  }


   Future<bool> checkConnect() async {

     List<BluetoothDevice> connectedDevices = await FlutterBlue.instance.connectedDevices;
     if(connectedDevices.isNotEmpty){
       return false;     }
    return true;
  }


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

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[

                    Align(
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage('assets/app logo final.png' ),
                        height: MediaQuery.of(context).size.height/2,
                        width: MediaQuery.of(context).size.width/2,
                      ),
                    ),
                    Text('Welcome to the BLE Pendant App!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                    SizedBox(height: MediaQuery.of(context).size.height/54),
                    //Visibility(visible: checkConnect(), child: Text('Click here to pair your device'),)

                  ]

              )

            ],

          )
      ),

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

