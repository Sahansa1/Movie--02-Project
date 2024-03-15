import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  testWidgets('Login button should exist', (WidgetTester tester) async {
    // Build the AuthGate widget
    await tester.pumpWidget(MaterialApp(home: AuthGate()));

    // Find the login button
    final loginButtonFinder = find.widgetWithText(ElevatedButton, 'Log In');

    // Expect to find the login button
    expect(loginButtonFinder, findsOneWidget);
  });
}