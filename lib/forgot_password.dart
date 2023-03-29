
import 'package:final_project/loginScreen.dart';
import 'package:final_project/main_page.dart';
import 'package:final_project/registration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'loading_page_login.dart';


class ForgotPassword extends StatefulWidget{


  const ForgotPassword({Key? key,}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();

}



class _ForgotPasswordState extends State<ForgotPassword>{


  final emailController = TextEditingController();
  //final passwordController = TextEditingController();

  Future passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim(),
      );
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoadingPage()),
      );
    }on FirebaseAuthException catch (e){
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                e.message.toString(),
              ),
            );
          }
      );
      }
  }

  @override
  void dispose(){
    emailController.dispose();
    //passwordController.dispose();
    super.dispose();
  }

  Widget buildEmail(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: MediaQuery.of(context).size.width/96),
            Text(
              'Email',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,

                //fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        SizedBox(height: 10),

        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(

              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0,2)
                )
              ]
          ),
          height: 60,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: Colors.black87
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                    Icons.email,
                    color: Color(0xff03A9F4)
                ),
                hintText: 'email',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )
            ),
          ),

        )
      ],
    );
  }

  Widget buildLoginBtn(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/43),
      width: double.infinity,
      child: ElevatedButton(
          // elevation: 5,
          onPressed: passwordReset,
          // padding: EdgeInsets.all(15),
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(15)
          // ),
          // color: Colors.white,
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            padding: EdgeInsets.all(15),
          ),
          child: Text(
            'RESET PASSWORD',
            style: TextStyle(
              color: Color(0xff0d47a1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )

      ),
    );
    dispose();
  }

  Widget buildSignUpBtn() {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen( )),
          );        },
        child: RichText(
          text: TextSpan(
              children: [
                TextSpan(
                    text: 'Know your password? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )
                ),
                TextSpan(
                    text: 'Go back',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    )
                ),
              ]
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(

        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
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
                  child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width/9.6,
                        vertical: MediaQuery.of(context).size.height/30,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/live4iotlogo.png' ),
                            height: MediaQuery.of(context).size.height/2,
                            width: MediaQuery.of(context).size.width/2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: <Widget>[
                              Stack(
                                children: [
                                  //SizedBox(width: MediaQuery.of(context).size.width),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Forgot password?',
                                        //textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          //fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height/21),
                          buildEmail(),
                          SizedBox(height: MediaQuery.of(context).size.height/54),
                          buildLoginBtn(),
                          buildSignUpBtn(),
                        ],
                      )
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}