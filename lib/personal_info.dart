
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/userInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class PersonalInfo extends StatefulWidget {
  PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {

  //final user = FirebaseAuth.instance.currentUser!;
  int index1 = 0;

  User? user = FirebaseAuth.instance.currentUser;
  String device = '';

   Future getDevices() async{
    await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: user?.email).get().then(
            (snapshot) => snapshot.docs.forEach((document){
              //print(document.reference);
              device = document.reference.id;
              //GetUserInfo(documentID: device,);
    }),
    );
  }

  @override
  void initState(){
     getDevices();
     super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
          child: Stack  (
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppBar(),
                  Expanded(
                      child: FutureBuilder(
                        future: getDevices(),
                        builder: (context, snapshot){
                          if(device.isNotEmpty){
                            return ListView.builder(
                                itemCount: 1,
                                itemBuilder: (context, index){
                                  return ListTile(
                                    title: GetUserInfo(documentID: device),
                                  );
                                }
                            );
                          }
                          return Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('')
                                  ],
                                )
                              ],
                            ),
                          );
                        }
                      )
                  ),
                ],
              )

          ]
          )
      ),
    );
  }
}

