
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_application_1/Screens/firebase_options.dart';
// import 'package:flutter_application_1/app.dart';


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp()); // Instead of directly running MyApp, run the splash screen first
// }


//import 'package:MovieFlixer/material_app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/Screens/firebase_options.dart';
import 'package:flutter_application_1/widgets/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 235, 228, 189),
        useMaterial3: true,
      ),
      home:  SplashScreen(),
      ),
      );
}
