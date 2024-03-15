
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/Screens/firebase_options.dart';
import 'package:flutter_application_1/network_controller/dependency_injection.dart';
import 'package:flutter_application_1/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DependencyInjection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 235, 228, 189),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}