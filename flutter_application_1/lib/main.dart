import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/homepage.dart';
import 'package:flutter_application_1/Screens/firebase_options.dart';
import 'package:flutter_application_1/app.dart';
import 'package:flutter_application_1/Screens/home.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );


 runApp(MyApp());
}



