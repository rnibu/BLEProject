import 'package:final_project/CareTakerHomePage.dart';
import 'package:final_project/devices.dart';
import 'package:final_project/home_page.dart';
import 'package:final_project/map_page.dart';
import 'package:final_project/profile.dart';
import 'package:flutter/material.dart';


class BottomNavi extends StatefulWidget {
  const BottomNavi({Key? key}) : super(key: key);

  @override
  State<BottomNavi> createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {

  int currentIndex = 0;
  final screens = [
    HomePage(),
    //CareTakerHomePage(),
    TrackerPage(),
    DevicesHome(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    debugShowCheckedModeBanner: false;

    return Scaffold(

      body:IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.black,), label: 'Home', backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.gps_fixed, color: Colors.black,), label: 'Track', backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.device_hub, color: Colors.black,), label: 'Devices', backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.black,), label: 'Profile', backgroundColor: Colors.white),
        ],
      ),
    );
  }
}
