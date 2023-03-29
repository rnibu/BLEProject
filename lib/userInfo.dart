import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/personal_info.dart';



class GetUserInfo extends StatelessWidget {
   String documentID = ' ';

  final user = FirebaseAuth.instance.currentUser!;
  final emerController = TextEditingController();
  final phoneController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final numController = TextEditingController();
  String device = '';
  List<String> deviceInfo = [];

   Future getDevices() async {
     await FirebaseFirestore.instance.collection('users').where(
         'email', isEqualTo: user.email).get().then(
           (snapshot) =>
           snapshot.docs.forEach((document) {
             //print(document.reference);
             device = document.reference.id;
             //GetUserInfo(documentID: device,);
           }),
     );
   }

  GetUserInfo({required this.documentID});

  @override
  Widget build(BuildContext context) {


    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentID).get(),
        builder: ((context,snapshot){
      if(snapshot.connectionState == ConnectionState.done){
        Map<String,dynamic>data =
            snapshot.data!.data() as Map<String,dynamic>;
        //deviceInfo[0] = data['first name'];
        //print('this is the device info: ' + deviceInfo[0]);
        return
        Column(
          children: [
            Card(
              elevation: 5,
              color: Colors.blueGrey,
              child: ListTile(

                title: Text('First Name: ${data['first name']}', style: TextStyle(color: Colors.white),),

                onTap: (){
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('edit first name: '),
                          content: TextField(
                            onChanged: (value) {
                              //print(emerController);
                            },
                            controller: firstNameController,
                            decoration: InputDecoration(hintText: "Text Field in Dialog"),
                          ),
                          actions: [
                            TextButton(
                                child: Text('SUBMIT'),
                                onPressed: () {
                                  String firstName = firstNameController.text.trim();

                                  getDevices();
                                  if(device.isNotEmpty){
                                    print('test device' + device);
                                    final docUser = FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(device);

                                    docUser.update({
                                      'first name': firstNameController.text.trim()
                                    });
                                    Navigator.of(context).pop();
                                    firstNameController.clear();
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
                            )
                          ],
                        );

                      }
                  );},
              ),
            ),
          Card(
            elevation: 5,
            color: Colors.blueGrey,
            child:
              ListTile(
                title: Text('Last Name: ${data['last name']}', style: TextStyle(color: Colors.white),),
                onTap: (){
                  showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('edit last name: '),
                      content: TextField(
                        onChanged: (value) {
                          //print(emerController);
                        },
                        controller: lastNameController,
                        decoration: InputDecoration(hintText: "Text Field in Dialog"),
                      ),
                      actions: [
                        TextButton(
                            child: Text('SUBMIT'),
                            onPressed: () {
                              String lastName = lastNameController.text.trim();

                              getDevices();
                              if(device.isNotEmpty){
                                print('test device' + device);
                                final docUser = FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(device);

                                docUser.update({
                                  'last name': lastNameController.text.trim()
                                });
                                Navigator.of(context).pop();
                                lastNameController.clear();
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
                        )
                      ],
                    );

                  }
              );},
          ),
          ),
            Card(
                elevation: 5,
                color: Colors.blueGrey,
                child: ListTile(
                  title: Text('Emergency Number: ${data['emergency']}', style: TextStyle(color: Colors.white),),
                  onTap: (){
                    String number = '';
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('edit number: '),
                            content: TextField(
                              onChanged: (value) {
                                //print(emerController);
                              },
                              controller: emerController,
                              decoration: InputDecoration(hintText: "Text Field in Dialog"),
                            ),
                            actions: [
                              TextButton(
                                  child: Text('SUBMIT'),
                                  onPressed: () {
                                    String number = emerController.text.trim();
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
                                          'emergency': emerController.text.trim()
                                        });
                                        Navigator.of(context).pop();
                                        emerController.clear();
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
                                  }
                              )
                            ],
                          );

                        }
                    );},
                ),
            ),
          Card(
          elevation: 5,
          color: Colors.blueGrey,
          child:ListTile(
            title: Text('Phone Number: ${data['phone number']}', style: TextStyle(color: Colors.white, fontFamily: 'RobotoMono'),),
            onTap: (){
              String number = '';
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('edit number: '),
                      content: TextField(
                        onChanged: (value) {
                          //print(emerController);
                        },
                        controller: numController,
                        decoration: InputDecoration(hintText: "Text Field in Dialog"),
                      ),
                      actions: [
                        TextButton(
                            child: Text('SUBMIT'),
                            onPressed: () {
                              String number = numController.text.trim();
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
                                    'phone number': numController.text.trim()
                                  });
                                  Navigator.of(context).pop();
                                  numController.clear();
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
                            }
                        )
                      ],
                    );

                  }
              );},
          ),
          ),
            Card(
                elevation: 5,
                color: Colors.blueGrey,
                child:ListTile(
                  title: Text('Email: ${data['email']}', style: TextStyle(color: Colors.white, fontFamily: 'Raleway'),),
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(
                                'Error cannot change email'
                            ),
                          );
                        }
                    );
                  },
                )
            ),

          ],
        );
      }
      return Text('loading');
    }
    )
    );
    /*return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentID).get(),
        builder: ((context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            switch(type){
              case 0:
                deviceInfo[0] = data['first name'];
                return Text(deviceInfo[0]

                );
              case 1:
                return Text('${data['last name']}',
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                );
              case 2:
                return Text('${data['phone number']}',
                    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                );
              case 3:
                //num = data['emergency'];
                //print('test ' + number);
                return Text('${data['emergency']}');
            }
          }
          return Text('');
        }
        )
    );*/
  }
}
