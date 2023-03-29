// ignore_for_file: file_names, prefer_const_constructors

import 'package:final_project/loginScreen.dart';
import 'package:final_project/registration_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}



class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;


  void toggleScreens(){
    /*setState((){
      showLoginPage = !showLoginPage;
    }
    );*/
    if(showLoginPage==true){
      showLoginPage=false;
    }
    else{
      showLoginPage=true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      toggleScreens();
      return LoginScreen();
    }
    else{
      toggleScreens();
      return SignUpPage();
    }
  }
}
