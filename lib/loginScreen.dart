
import 'package:final_project/forgot_password.dart';
import 'package:final_project/main_page.dart';
import 'package:final_project/registration_page.dart';
import 'package:final_project/user_simple.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class LoginScreen extends StatefulWidget{


  const LoginScreen({Key? key,}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();

}



class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver{


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;


  @override
  initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);


    bool remember = UserSimplePreferences.getRememberMe()??false;
    rememberMe = remember;
    if(rememberMe){
      final textUser = UserSimplePreferences.getUsername()??'';
      emailController = TextEditingController(text: textUser);
      final textPass = UserSimplePreferences.getPassword()??'';
      passwordController = TextEditingController(text: textPass);
    }


  }

  Future signInUser() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
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

    if(!rememberMe){
      emailController.clear();
      passwordController.clear();
    }

  }

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state){
    super.didChangeAppLifecycleState(state);

    if(state==AppLifecycleState.inactive||state==AppLifecycleState.detached) return;

    final isBackground = state ==AppLifecycleState.paused;

    if(isBackground&&rememberMe){

      UserSimplePreferences.setUsername(emailController.text);
      UserSimplePreferences.setPassword(passwordController.text);
    }
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

  Widget buildPassword(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: MediaQuery.of(context).size.width/96),
            Text(
              'Password',
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
            controller: passwordController,
            obscureText: true,
            style: TextStyle(
                color: Colors.black87
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                    Icons.lock,
                    color: Color(0xff03A9F4)
                ),
                hintText: 'password',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )
            ),
          ),
          //button for password


        )
      ],
    );
  }

  Widget buildForgotPassBtn(){
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ForgotPassword()),
        );
        },
        //padding: EdgeInsets.only(right: 0),
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
    );
  }

  Widget buildRememberCb(){
    return Container(
        height: MediaQuery.of(context).size.height/40,
        child: Row(
          children: <Widget>[
            Theme(
              data: ThemeData(unselectedWidgetColor: Colors.white),
              child:
              Checkbox(

                value: rememberMe,
                checkColor: Colors.green,
                activeColor: Colors.white,
                onChanged: (value){
                  setState(() {
                    rememberMe = value!;
                  });
                  UserSimplePreferences.setRememberMe(rememberMe);
                },
              ),
            ),
            Text(
              'Remember Me',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,

              ),
            )
          ],
        )
    );
  }

  Widget buildLoginBtn(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/43),
      width: double.infinity,
      child: ElevatedButton(
          //elevation: 5,
          onPressed: signInUser,
          //padding: EdgeInsets.all(15),
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(15)
          // ),
          //color: Colors.white,
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            padding: EdgeInsets.all(15),
          ),
          child: Text(
            'LOGIN',
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpPage()),
          );
          print('hello');
        },
        child: RichText(
          text: TextSpan(
              children: [
                TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )
                ),
                TextSpan(
                    text: 'Sign Up',
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
                      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width/9.6,0 , MediaQuery.of(context).size.width/9.6, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/app logo final.png' ),
                            height: MediaQuery.of(context).size.height/3,
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
                                        'Welcome! ',
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
                          buildPassword(),
                          buildForgotPassBtn(),
                          buildRememberCb(),
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