import 'package:final_project/bluetooth.dart';
import 'package:final_project/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'home_page.dart';
import 'map_page.dart';


class DevicesHome extends StatefulWidget {
  const DevicesHome({Key? key}) : super(key: key);

  @override
  State<DevicesHome> createState() => _DevicesHomeState();
}

class _DevicesHomeState extends State<DevicesHome> {

  TextEditingController deviceController = TextEditingController();
  Widget buildAddDevices(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: MediaQuery.of(context).size.width/96),
            Text(
              'Device IMEI',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,

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
          height: MediaQuery.of(context).size.width/20,
          width: MediaQuery.of(context).size.width/1.5,
          child: TextField(
            controller: deviceController,
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Bluetooth Device Pairing: ',style: TextStyle(color: Colors.white, fontSize: 20),),
                    ButtonTheme(
                      minWidth: 50,
                      height: 50,

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: ElevatedButton(
                        //backgroundColor: Theme.of(context).primaryColor,
                        //foregroundColor: Colors.black,
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DevicesPage()),
                          );
                        },
                        child: Icon(Icons.device_hub)


                      ),
                    ),

                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height/20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center ,
                  children: [

                    buildAddDevices()
                    /*ButtonTheme(
                      minWidth: 100,
                      height: 100,

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: RaisedButton(
                        //backgroundColor: Theme.of(context).primaryColor,
                        //foregroundColor: Colors.black,
                        onPressed: (){},
                        child: const Icon(Icons.center_focus_strong),


                      ),
                    ),*/
                  ],
                )
              ],
            ),
          )
        ],
      ),

    );
  }
}
