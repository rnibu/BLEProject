

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/loading_page_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




class SignUpPage extends StatefulWidget {
  //final VoidCallback showLoginPage;
  const SignUpPage({Key? key,}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {


  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emergencyPhoneController = TextEditingController();
  final userController = TextEditingController();

  List<String> items = ['User','Caretaker',];
  String? selectedItem = 'User';

  @override
  Future signUp() async{
   try{
      if (passwordsMatch()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        addUserDetails(
          _firstNameController.text.trim(),
          _lastNameController.text.trim(),
          int.parse(_phoneNumberController.text.trim()),
          emailController.text.trim(),
          int.parse(_emergencyPhoneController.text.trim()),
        );
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoadingPage()),
        );
      }
      else{
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                  "Passwords don\'t match"
                ),
              );
            }
        );
      }
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

  Future addUserDetails(String firstName,String lastName,int phoneNumber, String email, int emergency) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'phone number': phoneNumber,
      'email': email,
      'emergency' : emergency,

    });

  }

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    userController.dispose();
    super.dispose();
  }
  Widget buildPhoneNumber(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: MediaQuery.of(context).size.width/96),
            Text(
              'Phone Number',
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
            controller: _phoneNumberController,
            //keyboardType: TextInputType.emailAddress,
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
                hintText: 'Phone Number',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )
            ),
          ),

        )
      ],
    );
  }
  Widget buildEmergencyPhoneNumber(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: MediaQuery.of(context).size.width/96),
            Text(
              'Emergency Contact Number',
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
            controller: _emergencyPhoneController,
            //keyboardType: TextInputType.emailAddress,
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
                hintText: 'Phone Number',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )
            ),
          ),

        )
      ],
    );
  }
  Widget buildLastName(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: MediaQuery.of(context).size.width/96),
            Text(
              'Last Name',
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
            controller: _lastNameController,
            //keyboardType: TextInputType.emailAddress,
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
                hintText: 'Last Name',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )
            ),
          ),

        )
      ],
    );
  }
  Widget buildFirstName(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: MediaQuery.of(context).size.width/96),
            Text(
              'First Name',
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
            controller: _firstNameController,
            //keyboardType: TextInputType.emailAddress,
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
                hintText: 'first name',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )
            ),
          ),

        )
      ],
    );
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
            obscureText: false,
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

  Widget buildConfirmPassword(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: MediaQuery.of(context).size.width/96),
            Text(
              'Confirm Password',
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
            controller: confirmPasswordController,
            obscureText: false,
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
                hintText: 'Confirm password',
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

  Widget buildSignUpBtn(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/43),
      width: double.infinity,
      child: ElevatedButton(
          //elevation: 5,
          onPressed: signUp,
          //padding: EdgeInsets.all(15),
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(15)
          // ),
          // color: Colors.white,
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            padding: EdgeInsets.all(15),
          ),
          child: Text(
            'SIGN UP',
            style: TextStyle(
              color: Color(0xff0d47a1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
      ),
    );
  }

  Widget buildLogIn(){
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        //padding: EdgeInsets.only(right: 0),
        child: Text(
          'Have an account already? Log in',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
    );
  }

  bool passwordsMatch(){
    if(passwordController.text.trim()==confirmPasswordController.text.trim()){
      return true;
    }
    else{
      return false;
    }
  }
  Widget buildUser(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: MediaQuery.of(context).size.width/96),
            Text(
              'Please enter care bound with the account',
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
            controller: userController,
            obscureText: false,
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
                hintText: 'User',
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
bool visibility = false;
  bool v =  false;

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
                        //vertical: MediaQuery.of(context).size.height/2,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          /*Image(
                            image: AssetImage('assets/live4iotlogo.png'),
                            height: MediaQuery.of(context).size.height/2,
                            width: MediaQuery.of(context).size.width/2,
                          ),*/
                          SizedBox(height: MediaQuery.of(context).size.height/45),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              //SizedBox(width: MediaQuery.of(context).size.width/20),
                              Text(
                                'Sign Up: ',
                                //textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xff0d47a1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  //fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          DropdownButton<String>(
                            items: items
                                .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item, style: TextStyle(fontSize: 17, color: Colors.black))
                            ))
                                .toList(),
                            onChanged: (item){
                              setState(() => selectedItem = item);
                              // if(item=='Caretaker'){
                              //   visibility = false;
                              //   v = true;
                              // }
                              // else if(item == 'User'){
                              //   visibility = true;
                              //   v = false;
                              // }
                              // else{
                              //   visibility = false;
                              //   v = false;
                              // }


                            } ,
                            value: selectedItem,

                          ),
                          SizedBox(height: MediaQuery.of(context).size.height/54),
                          buildEmail(),
                          SizedBox(height: MediaQuery.of(context).size.height/54),
                          buildPassword(),
                          SizedBox(height: MediaQuery.of(context).size.height/54),
                          buildConfirmPassword(),
                          SizedBox(height: MediaQuery.of(context).size.height/54),
                          buildFirstName(),
                          SizedBox(height: MediaQuery.of(context).size.height/54),
                          buildLastName(),
                          SizedBox(height: MediaQuery.of(context).size.height/54),
                          buildPhoneNumber(),
                          SizedBox(height: MediaQuery.of(context).size.height/54),
                          Visibility(child: buildUser(), visible: visibility,),
                          Visibility(child: buildEmergencyPhoneNumber(), visible: true),
                          Visibility(child: buildSignUpBtn(), visible: visibility),
                          //different visibilities for different types of sign up for authentication.
                          //'User' will have regular sign up
                          //'Caretaker' sign up will check for User account to link first and then create account
                          //'Admin' might not have sign up functionality, support will have to manually add him

                          buildLogIn(),


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
