import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/movie_detailed_screen.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/Models/list_movies.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class MoviesGridScreen extends StatefulWidget {
  final String movieType; // Add this parameter

  MoviesGridScreen({required this.movieType});
  @override
  _MoviesGridScreenState createState() => _MoviesGridScreenState();
}

class _MoviesGridScreenState extends State<MoviesGridScreen> {
  late ScrollController scrollController;
  late List<ListMovies> displayedMovies;
  late List<ListMovies> storedMovies;
  late int currentPage;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    displayedMovies = [];
    storedMovies = [];
    currentPage = 1;
    searchController = TextEditingController();

    // Fetch initial movies
    fetchMovies();
    
    // Add a listener to the scrollController to detect when the user reaches the end
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        // User has reached the end of the list
        // Fetch more movies and append them to displayedMovies
        fetchMovies();
      }
    });
  }

  Future<void> fetchMovies() async {
    try {
      List<ListMovies> moreMovies = await fetchAllMoviesWithPage(currentPage);
      displayedMovies.addAll(moreMovies);
      storedMovies = displayedMovies;
      currentPage++;

      setState(() {});
    } catch (e) {
      // Handle error fetching more movies
    }
  }

  Future<List<ListMovies>> fetchAllMoviesWithPage(int page) async {
    List<ListMovies> allMovies = [];
    String url = '';

    // Customize the API endpoint based on the movie type
    
    if (widget.movieType == 'Top Rated') {
      url = 'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.APIKey}&page=$page';

    } else if (widget.movieType == 'Grossing') {
      url = 'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.APIKey}&sort_by=revenue.desc&page=$page';

    }else if (widget.movieType == 'UpComing'){
      url = 'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.APIKey}&page=$page';

    }else if (widget.movieType == 'Children'){
      url = 'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.APIKey}&adult=false&with_genres=16,10749&page=$page';
    
    }else if (widget.movieType == 'Best'){
      url= 'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.APIKey}&primary_release_year=2024&sort_by=popularity.desc&page=$page';
    }
    final response = await http.get(
      Uri.parse(url),
    );
    

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> movies = data['results'] ?? [];
      allMovies.addAll(movies.map((json) => ListMovies.fromJson(json)).toList());
    } else {
      throw Exception('Failed to load movies');
    }

    return allMovies;
  }

  void searchMovies(String query) {
    List<ListMovies> results = storedMovies
        .where((movie) => movie.title!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      displayedMovies = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies Grid'),
        
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: searchMovies,
              decoration: const InputDecoration(
                labelText: 'Search Movies',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(child: GridSlider(scrollController: scrollController, displayedMovies: displayedMovies)),
        ],
      ),
    );
  }
}


class GridSlider extends StatelessWidget {
  final ScrollController scrollController;
  final List<ListMovies> displayedMovies;

  const GridSlider({required this.scrollController, required this.displayedMovies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, 
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.7, 
      ),
      itemCount: displayedMovies.length,
      itemBuilder: (context, index) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
               Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(movie: displayedMovies[index], id: displayedMovies[index].id),
              ),
            );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                '${Constants.imagePath}${displayedMovies[index].poster_path}', 
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
