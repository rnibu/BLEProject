// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:final_project/bottom_nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:final_project/widgets.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';




class DevicesPage extends StatefulWidget {
  const DevicesPage({Key? key}) : super(key: key);

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(

      color: Colors.lightBlue,
      home: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              return FindDevicesScreen();
            }
            return BluetoothOffScreen(state: state);
          }),
    );
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, this.state}) : super(key: key);

  final BluetoothState? state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA2C8FC),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .subtitle1
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class FindDevicesScreen extends StatelessWidget {

  final user = FirebaseAuth.instance.currentUser!;

  String _device = '';

  List<String> recipents = [];

  bool flag = false;

  void didChangeAppLifecycleState(AppLifecycleState state){
    didChangeAppLifecycleState(state);

    if(state==AppLifecycleState.inactive||state==AppLifecycleState.detached) return;

    final isBackground = state ==AppLifecycleState.paused;

    if(isBackground/*&&flag*/){
      //String number = recipents[0];
      print('hello' + recipents[0].toString());
      //FlutterPhoneDirectCaller.callNumber(number);
    }
  }

  void _sendSMS(String message, List<String> recipents)async{
    String _result = await sendSMS(message: message, recipients: recipents, sendDirect: true);
    print(_result);
  }

  Future getDevices() async{
    await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: user.email).get().then(
          (snapshot) => snapshot.docs.forEach((document){
        //print(document.reference);
        _device = document.reference.id;
        //GetUserInfo(documentID: _device,);
      }),
    );
  }
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
  int counter = 0;
  bool firstCheck = false;
  List<BluetoothDevice> connectedDevices = [];
  Future connectDevice(BluetoothDevice d) async{

    


    connectedDevices = await FlutterBlue.instance.connectedDevices;

  }


  //List<BluetoothDevice> connectedDevices = await FlutterBlue.instance.connectedDevices;

  static const intro =
          'To connect pendant, please press search button and then press and hold the button on the pendant until the red light appears. Find the pendant in the list and press \"CONNECT\". Once connected, press the search button and leave on. Your device is ready to use.'
              '\n'
              'Note: if an action is detected, the app will stop searching automatically';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavi()),
            );
          },
        ),
        title: Text('Find Devices'),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            FlutterBlue.instance.startScan(/*timeout: Duration(seconds: 30)*/),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child:
              ExpandablePanel(
              header: Text('Intructions',style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
              collapsed: Text(intro, softWrap: true, maxLines: 1, overflow: TextOverflow.ellipsis),
              expanded: Text(intro, softWrap: true, ),
               ),
          ),
        //   AlertDialog(
        //   content: Text(
        //       'To connect pendant, please press search button and then press and hold the button on the pendant until the red light appears. Find the pendant in the list and press \"CONNECT\". Once connected, press the search button and leave on. Your device is ready to use.'
        //           '\n'
        //           'Note: if an action is detected, the app will stop searching automatically'
        //   ),
        // ),
             StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(Duration(seconds: 30))
                    .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!
                      .map((d) => ListTile(
                    title: Text(d.name),

                    subtitle: Text(d.id.toString()),
                    trailing: StreamBuilder<BluetoothDeviceState>(
                      stream: d.state,
                      initialData: BluetoothDeviceState.disconnected,
                      builder: (c, snapshot) {
                        if (snapshot.data ==
                            BluetoothDeviceState.connected) {
                          return ElevatedButton(
                            child: Text('DISCONNECT'),
                            onPressed: () {
                              d.state.listen((state) {
                                print('connection state: $state');
                              });
                              d.disconnect();
                              FlutterBlue.instance.stopScan();
                            }
                          );

                        }
                        return Text('Disconnected');
                      },
                    ),
                  ))
                      .toList(),
                ),
              ),
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBlue.instance.scanResults,
                initialData: [],
                builder: (c, snapshot) {
                  if(snapshot.data == BluetoothDeviceState.connecting){
                    return AlertDialog(
                      content: Text('Connecting'),
                    );
                  }
                  else {
                    return Column(
                    children: snapshot.data!
                        .map(
                          (r) => ScanResultTile(
                          result: r,
                          onTap: () async {
                            if(r.device.name=='PD001'){
                              const snackBar = SnackBar(content: Text('Connecting...Press and hold pendant again'));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              await r.device.connect();
                              r.device.state.listen((state)  async {
                                print('connection state: $state');
                                const snackBar = SnackBar(content: Text('Connected!'));

                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                connectedDevices = await FlutterBlue.instance.connectedDevices;
                              });
                              //r.device.connect();
                              //connectedDevices = await FlutterBlue.instance.connectedDevices;
                              FlutterBlue.instance.stopScan();
                            }
                            else{
                              const snackBar = SnackBar(content: Text('Connect a Pendant device'));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          }

                      ),

                    )
                        .toList(),

                  );}

                }

              ),

            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () {
                FlutterBlue.instance.stopScan();

                } ,
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () async {
                  counter =0;
                  FlutterBlue.instance.startScan();
                  getDevices();


                  if(true){
                    //FlutterBlue.instance.startScan(/*timeout: Duration(seconds: 30)*/);
                    var devinf = List.filled(100000,'0');  //value 1000 determines size of the results list to keep. 300~ is good enough for one scan without restarting app
                    var sig = List.filled(devinf.length,-100);
                    var name = List.filled(devinf.length,'0');
                    var i=0;
                    var ind=1;

                    var subscription = FlutterBlue.instance.scanResults.listen((results) async {

                      for (ScanResult r in results) {
                        i++;
                        sig[i] = r.rssi;
                        devinf[i] = r.device.id.id;
                        name[i]=r.device.name;
                        int key = 0;
                        //print(counter);
                        if(r.device.name=='PD001') {
                          connectedDevices = await FlutterBlue.instance.connectedDevices;
                          print(connectedDevices);
                          print(r.device);
                          if(connectedDevices.contains(r.device)&&counter==1){
                            key = r.advertisementData.manufacturerData.keys.single;


                            var adat=r.advertisementData.manufacturerData[key]?.toList();
                            var outp=String.fromCharCode(adat![17])+String.fromCharCode(adat[18]);
                            print(outp + 'output');
                            if(outp.contains('2')){
                              print('Pendant Key Event Detected');}
                            if(outp.contains('1')){
                              print('Fall Event Detected');}
                            if(outp.contains('0')){
                              print('Neutral. No Event Detected');}
                            print(outp);
                            String message = "This is a test message";
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(_device)
                                .get()
                                .then((DocumentSnapshot documentSnapshot) async {
                              try {
                                FlutterBlue.instance.stopScan();
                                Position pos = await _determinePosition();
                                String position = pos.toString();
                                //print(position);
                                dynamic nested = documentSnapshot.get(FieldPath(['emergency']));
                                String number = nested.toString();
                                FlutterPhoneDirectCaller.callNumber(number);
                                recipents = [number];
                                flag = true;
                                _sendSMS('This is an emergency alert.\n' + position + ': This is my current location', recipents);

                              } on StateError catch(e) {
                                print('No nested field exists!');
                              }
                            });
                            break;
                          }
                          counter = 1;
                        }
                      }
                      //FlutterBlue.instance.stopScan();
                    });
                  }
                  //counter+=3;

                },

            );
          }
        }
      ),
    );
  }
}

/*class DeviceScreen extends StatelessWidget {
   DeviceScreen({Key? key, required this._device}) : super(key: key);

  final BluetoothDevice _device;

  List<int> _getRandomBytes() {
    final math = Random();
    return [
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255)
    ];
  }

  List<Widget> _buildServiceTiles(List<BluetoothService> services) {
    return services
        .map(
          (s) => ServiceTile(
        service: s,
        characteristicTiles: s.characteristics

            .map(

              (c) => CharacteristicTile(
            characteristic: c,
            onReadPressed: () => c.read(),
            onWritePressed: () async {
              await c.write(_getRandomBytes(), withoutResponse: true);
              await c.read();
            },
            onNotificationPressed: () async {
              await c.setNotifyValue(!c.isNotifying);
              await c.read();
              //_deviceService();
            },
            descriptorTiles: c.descriptors
                .map((d) => DescriptorTile(
                descriptor: d,
                onReadPressed: () async {
                  d.read();
                  print('Testing uuid: ');
                  //_deviceService();
                  },
                onWritePressed: () => d.write(_getRandomBytes()),

              ),

            )
                .toList(),
          ),
        )
            .toList(),
      ),
    )
        .toList();
  }

 */
/*
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(_device.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: _device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback? onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => _device.disconnect();
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () {
                    _device.connect();
                  };
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return FlatButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .button
                        ?.copyWith(color: Colors.white),
                  ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: _device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? Icon(Icons.bluetooth_connected)
                    : Icon(Icons.bluetooth_disabled),
                title: Text(
                    'Device is ${snapshot.data.toString().split('.')[1]}.'),
                subtitle: Text('${_device.id}'),
                trailing: StreamBuilder<bool>(
                  stream: _device.isDiscoveringServices,
                  initialData: false,
                  builder: (c, snapshot) => IndexedStack(
                    index: snapshot.data! ? 1 : 0,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () async {
                          _device.discoverServices();
                          _deviceService();

                          },
                      ),
                      IconButton(
                        icon: SizedBox(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                          ),
                          width: 18.0,
                          height: 18.0,
                        ),
                        onPressed: null,
                      )
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<int>(
              stream: _device.mtu,
              initialData: 0,
              builder: (c, snapshot) => ListTile(
                title: Text('MTU Size'),
                subtitle: Text('${snapshot.data} bytes'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _device.requestMtu(223),
                ),
              ),
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: _device.services,
              initialData: [],
              builder: (c, snapshot) {

                /*var subscription = FlutterBlue.instance.scanResults.listen((results) {

                  // do something with scan results

                    for (ScanResult r in results) {
                      if(r.advertisementData.manufacturerData.isEmpty){
                        continue;
                      }
                      else{
                        if(r.advertisementData.manufacturerData.keys.toString()=='(0)'){
                          print('Found');
                          print('check _device toString' + FlutterBlue.instance.connectedDevices.toString());
                          print('${r.advertisementData.manufacturerData}');
                          parseManufacturerData(r.advertisementData.manufacturerData);
                        }
                        // Pass it to our previous function
                        //parseManufacturerData(r.advertisementData.manufacturerData);
                      }

                    }

                });*/
                //_deviceService();
                return Column(
                  children: _buildServiceTiles(snapshot.data!),

                );
              },
            ),
          ],
        ),
      ),

    );
  }
}*/