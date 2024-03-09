// import 'package:cloud_firestore/cloud_firestore.dart';

// class DatabaseManager {
//   final CollectionReference profileList =
//       Firestore.instance.collection('profileInfo');

//   Future<void> createUserData(
//       String email, String uid) async {
//     return await profileList
//         .document(uid)
//         .setData({'email': email});
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Models/list_movies.dart';

// Function to save user information to Firestore
Future<void> saveUserInfoToFirestore(String email) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Reference to the users collection in Firestore
      CollectionReference<Map<String, dynamic>> users =
          FirebaseFirestore.instance.collection('users');

      // Add a new document with a generated ID
      await users.doc(user.uid).set({
        'email': email,
        // You can add more fields as per your requirement
      });
    } else {
      print('User is not signed in.');
    }
  } catch (e) {
    print('Error saving user information: $e');
  }
}

Future<void> saveMovieDetailsToFirestore(String userId, ListMovies movie) async {
  try {
    // Reference to the user's document in the users collection
    DocumentReference<Map<String, dynamic>> userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    // Reference to the movies subcollection within the user's document
    CollectionReference<Map<String, dynamic>> movies =
        userDocRef.collection('movies');

    // Add a new document with a generated ID
    await movies.add({
      'title': movie.title,
      'overview': movie.overview,
      'release_date': movie.release_date,
      'vote_average': movie.vote_average,
      'popularity': movie.popularity,
      // Add more fields as per your requirement
    });
  } catch (e) {
    print('Error saving movie details: $e');
  }
}