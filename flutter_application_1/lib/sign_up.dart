import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/colour.dart';
import 'package:flutter_application_1/database_manager/database_manager.dart';
import 'package:flutter_application_1/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailController = TextEditingController(); // Controller for email text field
  TextEditingController _firstNameController = TextEditingController(); // Controller for first name text field
  TextEditingController _passwordController = TextEditingController(); // Controller for password text field

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.colBackground,
      appBar: AppBar(
        title: const Text('Sign Up',
        style: TextStyle(color: Color.fromARGB(255, 87, 87, 87))),
         backgroundColor: Color.fromARGB(255, 18, 1, 18),
         ),

      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _firstNameController,
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'First Name',
              ),
            ),
            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _signUpWithEmailAndPassword();
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signUpWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text, // Getting email from text field
        password: _passwordController.text, // Getting password from text field
      );
       await saveUserInformationToFirestore(_firstNameController.text, _emailController.text);
      
      // If sign-up is successful, you can navigate the user to another screen, e.g., HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthGate()),
      );
    } catch (error) {
      // Handle sign-up errors
      print('Sign up error: $error');
    }
  }
}