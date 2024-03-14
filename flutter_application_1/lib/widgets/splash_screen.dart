import 'package:flutter/material.dart';
import 'package:flutter_application_1/colour.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/app.dart'; // Importing your main app

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay using Future.delayed
    Future.delayed(Duration(seconds: 2), () {
      // Navigate to the main application screen after 2 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 37, 3, 49), // Set your splash screen background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/mug.png',
              width: 250, 
              height: 250,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
