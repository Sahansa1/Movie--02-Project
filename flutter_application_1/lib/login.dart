
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/homepage.dart';
import 'package:flutter_application_1/colour.dart';
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
  TextEditingController _firstNameController = TextEditingController();


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
        //check the connectivity status
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Color.fromRGBO(0, 0, 0, 1),
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
            backgroundColor: Colours.colBackground ,
            appBar: AppBar(
              title: Text(
                'Login',
                style: TextStyle(color: const Color.fromARGB(255, 87, 87, 87))),
              automaticallyImplyLeading: false,
              backgroundColor: Color.fromARGB(255, 18, 1, 18),
              ),
            
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/bingewatch_wording.png', width: 200), 
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: _emailController,
                      style: TextStyle(color: Colors.white),
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
                      style: TextStyle(color: Colors.white),
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
                      Text(
                        'Remember Me',
                        style: TextStyle(color: Color.fromARGB(255, 69, 69, 69)),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _signInWithEmailAndPassword();
                    },
                    child: Text('Log In',
                    ),
                    
                  ),
                   GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(
                        color: Colors.blue, // Change color to blue or any other desired color
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
// Function to handle email and password authentication
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
      // Save user information to Firestore upon successful login
      saveUserInformationToFirestore(_emailController.text,_firstNameController.text);

      // Navigate to the HomeScreen

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