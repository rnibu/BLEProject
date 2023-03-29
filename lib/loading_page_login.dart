import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:final_project/loginScreen.dart';

class LoadingPage extends StatefulWidget {
  //final VoidCallback showLoginPage;
  const LoadingPage({Key? key,}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Timer scheduleTimeout([int milliseconds = 10000]) =>
      Timer(Duration(milliseconds : milliseconds), handleTimeout);

  void handleTimeout(){
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }


  /*_AnimatedFlutterLogoState() {
    //_timer = new Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _logoStyle = FlutterLogoStyle.horizontal;
      });
    });
  }*/

  @override
  /*void dispose() {
    super.dispose();
    _timer.cancel();
  }*/

  @override
  Widget build(BuildContext context) {
    scheduleTimeout(2*1000);

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
                      Text(
                        'Success!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      LoadingBumpingLine.circle(),
                    ]
                )
              ],
            )
        )
    );
  }
}
