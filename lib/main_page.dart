import 'package:final_project/AuthPage.dart';
import 'package:final_project/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_project/home_page.dart';


import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return BottomNavi();
          }
          else {
            //it.exception?.printStackTrace();
            return AuthPage();

          }
        },
      ),
    );
  }
}
