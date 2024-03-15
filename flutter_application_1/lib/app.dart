import 'package:flutter/material.dart';
import 'package:flutter_application_1/colour.dart';
import 'package:flutter_application_1/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disabling debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        color: Colours.colBackground, 
        child: const AuthGate(),// Displaying the login screen
      ),
    );
  }
}
