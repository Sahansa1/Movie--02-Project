import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/Movies.dart';
import 'Models/ListMovies.dart';
import 'Screens/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
      ),
      body: FutureBuilder<List<ListMovies>>(
        future: fetchMovies(), // Call fetchMovies to get the list of movies
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If data is still loading, show a CircularProgressIndicator
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // If there's an error, display the error message
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // If data is available, pass the snapshot to the Movies widget
            return Movies(snapshot: snapshot);
          }
        },
      ),
    );
  }

  Future<List<ListMovies>> fetchMovies() async {
    // Implement your code to fetch movies data
    // This is just a placeholder function, replace it with your actual implementation
    return [];
  }
}
