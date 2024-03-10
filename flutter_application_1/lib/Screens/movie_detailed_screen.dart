import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/Models/list_movies.dart';
import 'package:flutter_application_1/colour.dart';
import 'package:flutter_application_1/database_manager/database_manager.dart';
import 'package:flutter_application_1/repttext.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int id;
  const MovieDetailsScreen({
    Key? key, 
    required this.movie, 
    required this.id,
  }) : super(key: key);

  final ListMovies movie;
  
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
              title: Text(movie.title),
              background: Image.network(
                '${Constants.imagePath}${movie.backdrop_path}',
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
                  overviewText(movie.overview),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(255, 226, 228, 228)), 
                          borderRadius: BorderRadius.circular(10),  
                        ),
                        child: Row(
                          children: [
                            detailsBoxTitle('Release Date: '),
                            detailsBoxDetail(movie.release_date), 
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colours.detailsBorder), 
                          borderRadius: BorderRadius.circular(10),  
                        ),
                        child: Row(
                          children: [
                            detailsBoxTitle('Rating: '),
                            const Icon(Icons.star, color: Colors.amber),                     
                            detailsBoxDetail('${movie.vote_average.toStringAsFixed(1)}/10'), 
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colours.detailsBorder), 
                          borderRadius: BorderRadius.circular(10),  
                        ),
                        child: Row(
                          children: [
                            detailsBoxTitle('Popularity: '),
                            detailsBoxDetail(movie.popularity.toString()), 
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Get the current user's ID
                          String userId = FirebaseAuth.instance.currentUser!.uid;
                          
                          // Show a snackbar when the button is clicked
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Added to Watched List'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          
                          // Call the function to save movie details to Firestore
                          saveMovieDetailsToFirestore(userId, movie,'watched');
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Add to Watched List'),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: () {
                          String userId = FirebaseAuth.instance.currentUser!.uid;
                          
                          // Show a snackbar when the button is clicked
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Added to Watch List'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                          
                          // Call the function to save movie details to Firestore
                          saveMovieDetailsToFirestore(userId, movie,'watch');
                        },
                        icon: const Icon(Icons.favorite_border),
                        color: Colors.white,
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