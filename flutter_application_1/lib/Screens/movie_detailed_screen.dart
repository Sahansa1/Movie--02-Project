import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/list_movies.dart';
import 'package:flutter_application_1/colour.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/database_manager/database_manager.dart';
import 'package:flutter_application_1/repttext.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int id;
  const MovieDetailsScreen({
    Key? key, 
    required this.movie, 
    required this.id,
  }) : super(key: key);

  final ListMovies movie;

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool isOnWatchedList = false;
  bool isOnWatchList = false;
  late StreamSubscription<DocumentSnapshot> _subscription;

  @override
  void initState() {
    super.initState();
    _initWatchedList();
    _initWatchList();
  }

  
  void _initWatchedList() async {
  final isOnWatchedList = await checkIfOnWatchedList();
  setState(() {

    this.isOnWatchedList = isOnWatchedList;
  });
}

void _initWatchList() async {
  final isOnWatchList = await checkIfOnWatchList();
  setState(() {
    this.isOnWatchList = isOnWatchList;
  });
}
  
  Future<bool> checkIfOnWatchedList() async {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  print(userId);

  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('watched')
      .get();

  for (final docSnapshot in querySnapshot.docs) {
    final data = docSnapshot.data();
    if (data != null && data['id'] == widget.movie.id) {
      return true;
    }
  }
  return false;
}

Future<bool> checkIfOnWatchList() async {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  print(userId);

  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('watch')
      .get();

  for (final docSnapshot in querySnapshot.docs) {
    final data = docSnapshot.data();
    if (data != null && data['id'] == widget.movie.id) {
      return true;
    }
  }
  return false;
}


Future<void> removeFromWatchedList(String userId, int movieId) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('watched')
        .where('id', isEqualTo: movieId)
        .get();
    for (final doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
    print('Movie removed from watched list');
  } catch (e) {
    print('Error removing movie from watched list: $e');
    // Handle error as needed
  }
}

Future<void> removeFromWatchList(String userId, int movieId) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('watch')
        .where('id', isEqualTo: movieId)
        .get();
    for (final doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
    print('Movie removed from watch list');
  } catch (e) {
    print('Error removing movie from watch list: $e');
    // Handle error as needed
  }
}
Widget _buildInfoBox(String title, String value) {
  return Container(
    width: MediaQuery.of(context).size.width / 3 - 20, // Adjust width as needed
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white), // Border color
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white, // Title color
            ),
          ),
        ),
        SizedBox(height: 4),
        Center(
          child: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.white, // Value color
            ),
          ),
        ),
      ],
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.colBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const BackButton(),
            backgroundColor:Colours.imageColour,
            expandedHeight: 500,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.movie.title),
              background: Image.network(
                '${Constants.imagePath}${widget.movie.backdrop_path}',
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ), 
          ), 
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  overviewTtitle("Overview"),
                  const SizedBox(height: 16),
                  overviewText(widget.movie.overview),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoBox('Release Date', widget.movie.release_date),
                          _buildInfoBox('Popularity', widget.movie.popularity.toString()),
                          _buildInfoBox('Vote Average', widget.movie.vote_average.toString()),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          final userId = FirebaseAuth.instance.currentUser!.uid;
                          final updatedOnWatchedList = await checkIfOnWatchedList();
                          
                          if (isOnWatchedList) {
                            await removeFromWatchedList(userId, widget.movie.id);
                            print(isOnWatchedList);
                            // Remove from Watched List
                            // Call function to remove movie details from Firestore
                          } else {
                            // Add to Watched List
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Added to Watched List'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            // Call the function to save movie details to Firestore
                            saveMovieDetailsToFirestore(userId, widget.movie, 'watched');
                            
                          }
                          setState(() {
                            isOnWatchedList = !isOnWatchedList;
                          });
                        },
                        icon: Icon(isOnWatchedList ? Icons.remove : Icons.check),
                        label: Text(isOnWatchedList ? 'Remove from Watched List' : 'Add to Watched List'),
                      ),

                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final userId = FirebaseAuth.instance.currentUser!.uid;
                          final updatedOnWatchList = await checkIfOnWatchList();
                          
                          if (isOnWatchedList) {
                            await removeFromWatchList(userId, widget.movie.id);
                            print(isOnWatchedList);
                            // Remove from Watched List
                            // Call function to remove movie details from Firestore
                          } else {
                            // Add to Watched List
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Added to Watch List'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            // Call the function to save movie details to Firestore
                            saveMovieDetailsToFirestore(userId, widget.movie, 'watch');
                            
                          }
                          setState(() {
                            isOnWatchList = !isOnWatchList;
                          });
                        },
                        
                        icon: Icon(isOnWatchList ? Icons.remove : Icons.check),
                        label: Text(isOnWatchList ? 'Remove from Watch List' : 'Add to Watch List'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

