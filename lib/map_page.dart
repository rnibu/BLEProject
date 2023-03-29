

import 'package:final_project/home_page.dart';
import 'package:final_project/profile.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'dart:async';

import 'bluetooth.dart';
import 'devices.dart';

class TrackerPage extends StatefulWidget {
  const TrackerPage({Key? key}) : super(key: key);

  @override
  State<TrackerPage> createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  Completer<GoogleMapController> _controller = Completer();

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(33.089110, -96.671730),
    zoom: 17,
  );



  late GoogleMapController googleMapController;

  Future<Position> _determinePosition() async {

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled){
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();

      if(permission == LocationPermission.denied){
        return Future.error('Location services denied');
      }
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
}

  void dispose(){
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Stack(
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => googleMapController = controller,
          ),
          Center(

              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.all(20),

                              //crossAxisAlignment: CrossAxisAlignment.center,
                              child: ButtonTheme(
                                minWidth: 50,
                                 height: 50,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                 child: ElevatedButton(
                                    //backgroundColor: Theme.of(context).primaryColor,
                                    //foregroundColor: Colors.black,
                                    onPressed: () async {
                                      
                                      Position pos = await _determinePosition();

                                      googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(pos.latitude, pos.longitude),zoom: 17)));

                                      setState((){});
                                    }, 
                                    child: const Icon(Icons.center_focus_strong),

                                  ),
                              ),

                        ),
                      ],
                    ),
                  ],
                ),
              )
          )
        ],
      ),



    );
  }
}
