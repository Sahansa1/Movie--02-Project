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
  late StreamSubscription<DocumentSnapshot> _subscription;

  @override
  void initState() {
    super.initState();
    _initWatchedList();
  }

  
  void _initWatchedList() async {
  final isOnWatchedList = await checkIfOnWatchedList();
  setState(() {
    this.isOnWatchedList = isOnWatchedList;
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
                      // Details Widgets...
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
                      IconButton(
                        onPressed: () {
                          final userId = FirebaseAuth.instance.currentUser!.uid;
                          // Show a snackbar when the button is clicked
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Added to Watch List'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          // Call the function to save movie details to Firestore
                          saveMovieDetailsToFirestore(userId, widget.movie, 'watch');
                        },
                        icon: const Icon(Icons.favorite_border),
                        color: isOnWatchedList ? Colors.white : null,
                        iconSize: 30,
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


/*

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/list_movies.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/database_manager/database_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/add_remove_watch_lists.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int id;
  final ListMovies movie;

  const MovieDetailsScreen({
    Key? key,
    required this.movie,
    required this.id,
  }) : super(key: key);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool isFavorite = false;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = _prefs.getBool('${widget.movie.id}_favorite') ?? false;
    });
  }

  Future<void> _toggleFavoriteStatus() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    String action = isFavorite ? 'added' : 'removed';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Movie $action from favorites'),
        duration: Duration(seconds: 2),
      ),
    );
    if (isFavorite) {
      saveMovieDetailsToFirestore(userId, widget.movie, 'watch');
    } else {
      // Remove the movie from favorites in Firestore
      removeMovieFromWatchList(userId, widget.movie);
    }
    await _prefs.setBool('${widget.movie.id}_favorite', !isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const BackButton(),
            backgroundColor: Colors.amber,
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
                  const Text('Overview'),
                  const SizedBox(height: 16),
                  Text(
                    widget.movie.overview,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Release Date, Rating, Popularity Containers...
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                          _toggleFavoriteStatus();
                        },
                        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                        label: Text(isFavorite ? 'Remove from Favorites' : 'Add to Favorites'),
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
*/