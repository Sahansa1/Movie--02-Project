//Saving to firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/Models/list_movies.dart';

//saving user info to firebase
Future<void> saveUserInformationToFirestore(String name, String email) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      CollectionReference<Map<String, dynamic>> users =
          FirebaseFirestore.instance.collection('users');

      await users.doc(user.uid).set({
        'name': name,
        'email': email,
      });
    } else {
      print('User is not signed in.');
    }
  } catch (e) {
    print('Error saving user information: $e');
  }
}


Future<void> saveMovieDetailsToFirestore(String userId, ListMovies movie, String listType) async {
  try {
    // Reference to the user's document in the users collection
    DocumentReference<Map<String, dynamic>> userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    // Reference to the appropriate subcollection within the user's document based on listType
    CollectionReference<Map<String, dynamic>> movies =
        userDocRef.collection(listType);

    // Add a new document with a generated ID
    await movies.add({
      'title': movie.title,
      'overview': movie.overview,
      'release_date': movie.release_date,
      'vote_average': movie.vote_average,
      'popularity': movie.popularity,
      'poster_path': movie.poster_path,
      'id':movie.id,
      // Add more fields as per your requirement
    });
  } catch (e) {
    print('Error saving movie details: $e');
  }
}

// // Function to save user email to Firestore
// Future<void> saveUserNameToFirestore(String name) async {
//   try {
//     // Get the current user
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       // Reference to the users collection in Firestore
//       CollectionReference<Map<String, dynamic>> users =
//           FirebaseFirestore.instance.collection('users');

//       // Add a new document with a generated ID
//       await users.doc(user.uid).set({
//         'name': name,
//         // You can add more fields as per your requirement
//       });
//     } else {
//       print('User is not signed in.');
//     }
//   } catch (e) {
//     print('Error saving user information: $e');
//   }
// }