import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_gate.dart';
import 'package:flutter_application_1/colour.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        color: Colours.colBackground, 
        child: const AuthGate(),
      ),
    );
  }
}
