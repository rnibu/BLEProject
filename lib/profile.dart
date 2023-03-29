import 'package:final_project/edit_emergency.dart';
import 'package:final_project/loginScreen.dart';
import 'package:final_project/personal_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'about_page.dart';
import 'devices.dart';
import 'home_page.dart';
import 'map_page.dart';
//import '';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  FirebaseAuth auth = FirebaseAuth.instance;

  void pageTracer(int i){
    switch(i){
      case 0:
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TrackerPage()),
        );
        break;
      case 2:
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DevicesHome()),
        );
        break;
      case 3:
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
    }
  }

  signOut() async {
    await auth.signOut();
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
                  decoration: BoxDecoration(
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
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Text('Redirecting'),
                        ],
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                          signOut();
                        },
                        leading: Icon(Icons.person_off_outlined),
                        title: Text('Sign Out',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ), //Signout
                      /*ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditEmerg())
                        );
                        },
                        leading: Icon(Icons.settings_phone_outlined),
                        title: Text('Edit Emergency Contact',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),*/
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PersonalInfo())
                          );
                        },
                        leading: Icon(Icons.person),
                        title: Text('Edit Personal Info',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AboutPage())
                          );
                        },
                        leading: Icon(Icons.info),
                        title: Text('About',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                      ListTile(
                        onTap: () async {
                          //call our number
                          String number = '2147645189';
                          await FlutterPhoneDirectCaller.callNumber(number);
                        },
                        //leading: Icon(Icons.info),
                        title: Text('Questions? Press here to call our number or dial 214-764-5189',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      ),

                    ]
                ),

              ],
            )
        ),

    );
  }
}
