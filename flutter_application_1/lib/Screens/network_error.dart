import 'package:flutter/material.dart';

class NetworkErrorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Network Error'),
        ),
        body: Center(
          child: Text('No internet connection available.'),
        ),
      ),
    );
  }
}
