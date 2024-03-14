// import 'package:flutter/material.dart';
// import 'package:connectivity/connectivity.dart';
// import 'package:flutter_application_1/colour.dart';
// import 'package:flutter_application_1/login.dart';
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Container(
//         color: Colours.colBackground, 
//         child: const AuthGate(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_application_1/colour.dart';
import 'package:flutter_application_1/login.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _isConnected = (result != ConnectivityResult.none);
      });
    });
  }

  Future<void> _checkConnectivity() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      setState(() {
        _isConnected = (connectivityResult != ConnectivityResult.none);
      });
    } catch (e) {
      print('Error checking connectivity: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          color: Colours.colBackground,
          child: _isConnected ? AuthGate() : NoInternetConnection(),
        ),
      ),
    );
  }
}

class NoInternetConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No Internet Connection'),
    );
  }
}
