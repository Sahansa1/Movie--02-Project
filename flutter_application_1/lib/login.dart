
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/home.dart';
import 'package:flutter_application_1/Screens/homepage.dart';
import 'package:flutter_application_1/database_manager/database_manager.dart';
import 'package:flutter_application_1/sign_up.dart';


import 'package:shared_preferences/shared_preferences.dart';




class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late Future<bool> _shouldNavigateToHome;
  bool _rememberMeChecked = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _shouldNavigateToHome = _checkIfShouldNavigateToHome();
  }

  Future<bool> _checkIfShouldNavigateToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool rememberMeChecked = prefs.getBool('login_status') ?? false;

    // If "Remember me" was not checked, we should not automatically log the user in
    if (!rememberMeChecked) {
      return false;
    }

    // If "Remember me" was checked, we check the FirebaseAuth instance
    var firebaseUser = FirebaseAuth.instance.currentUser;
    return firebaseUser != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _shouldNavigateToHome,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.data ?? false) {
          // If _shouldNavigateToHome is true, navigate to the HomeScreen
          return const HomeScreen();
        } else {
          // If _shouldNavigateToHome is false, show the login screen
          return Scaffold(
            appBar: AppBar(title: Text('Login'),automaticallyImplyLeading: false,),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: _rememberMeChecked,
                        onChanged: (value) {
                          setState(() {
                            _rememberMeChecked = value ?? false;
                          });
                        },
                      ),
                      Text('Remember Me'),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _signInWithEmailAndPassword();
                    },
                    child: Text('Sign In'),
                  ),
                  TextButton(
                    onPressed: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // If sign-in is successful and "Remember Me" is checked, save it in SharedPreferences
      if (_rememberMeChecked) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        
        await prefs.setBool('login_status', true);
        
      }
      saveUserInfoToFirestore(_emailController.text);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
    } catch (error) {
      // Handle sign-in errors
      print('Sign in error: $error');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}