import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Models/list_movies.dart';

Future<void> removeMovieFromWatchList(String userId, ListMovies movie) async {
  try {
    // Reference to the user's document in the users collection
    DocumentReference<Map<String, dynamic>> userDocRef =
        FirebaseFirestore.instance.collection('users').doc(userId);

    // Reference to the favorites subcollection within the user's document
    CollectionReference<Map<String, dynamic>> favorites =
        userDocRef.collection('watch');

    // Query for the document corresponding to the movie
    QuerySnapshot<Map<String, dynamic>> snapshot = await favorites
        .where('title', isEqualTo: movie.title)
        .limit(1)
        .get();

    // Check if the document exists
    if (snapshot.docs.isNotEmpty) {
      // Delete the document
      await snapshot.docs.first.reference.delete();
    }
  } catch (e) {
    print('Error removing movie from favorites: $e');
  }
}
