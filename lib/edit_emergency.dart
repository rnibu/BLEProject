import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditEmerg extends StatefulWidget {
  const EditEmerg({Key? key}) : super(key: key);

  @override
  State<EditEmerg> createState() => _EditEmergState();
}

class _EditEmergState extends State<EditEmerg> {

  User? user = FirebaseAuth.instance.currentUser;
  String device = '';
  final phoneController = TextEditingController();

  Future getDevices() async {
    await FirebaseFirestore.instance.collection('users').where(
        'email', isEqualTo: user?.email).get().then(
          (snapshot) =>
          snapshot.docs.forEach((document) {
            //print(document.reference);
            device = document.reference.id;
            //GetUserInfo(documentID: device,);
          }),
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
              'Emergency',
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
            controller: phoneController,
            keyboardType: TextInputType.number,
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
                hintText: 'phone number',
                hintStyle: TextStyle(
                  color: Colors.black38,
                )
            ),
          ),

        )
      ],
    );
  }

  void dispose(){
    phoneController.dispose();
    super.dispose();
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
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
              //BottomNavi(),
              AppBar(
                backgroundColor: Colors.black,
              ),
              Column(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Text('Redirecting'),
                      ],
                    ),
                    buildEmail(),
                    Material(
                      shape: RoundedRectangleBorder(),

                      elevation: 10,
                      shadowColor: Colors.black,
                      child: ElevatedButton(
                        onPressed: () async {
                          String number = phoneController.text.trim();
                          int num = number.length;
                          bool test = false;
                          if(num==10){

                              getDevices();
                              if(device.isNotEmpty){
                                print('test device' + device);
                                final docUser = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(device);

                                docUser.update({
                                  'emergency': phoneController.text.trim()
                                });
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(
                                          'Success!'
                                        ),
                                      );
                                    }
                                );
                                phoneController.clear();
                              }
                              else{
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(
                                          'Error try again'
                                        ),
                                      );
                                    }
                                );
                              }


                          }
                          else{
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                      'error invalid number'
                                    ),
                                  );
                                }
                            );
                          }
                        },
                        child: Text(
                          'update',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(),
                          padding: EdgeInsets.all(10),
                          primary: Colors.blue[700], // <-- Button color
                          onPrimary: Colors.black, // <-- Splash color
                        ),
                      ),
                    )
                  ]
              )
            ],
          )
      ),
    );
  }
}