//Test case to see transitioning from the splash screen to the main app screen after a certain duration.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/firebase_options.dart';

import 'package:flutter_application_1/network_controller/dependency_injection.dart';
import 'package:flutter_application_1/widgets/splash_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

  void main() {
  testWidgets('MyApp widget navigation test', (WidgetTester tester) async {
    // Initialize Firebase
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    // Initialize dependency injection
    DependencyInjection.init();
    
    // Build our app and trigger a frame
    await tester.pumpWidget(MaterialApp(home: MyApp(),));

    // Verify that SplashScreen is rendered
    expect(find.byType(SplashScreen), findsOneWidget);

    // Wait for splash screen to disappear
    await tester.pump(Duration(seconds: 2)); // Adjust duration as per your splash screen duration

    // Verify that the main app screen is rendered
    expect(find.byType((MyApp)), findsOneWidget); // Replace YourMainAppScreen with your main app screen widget

    // You can add more tests as needed, like checking for specific widgets on the main app screen
  });
}
