import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/list_movies.dart';
import 'package:flutter_application_1/Screens/movie_detailed_screen.dart';
import 'package:flutter_application_1/colour.dart';

class ShowAllMoviesScreen extends StatelessWidget {
  final List<ListMovies> movies;
  final String title;

  const ShowAllMoviesScreen({Key? key, required this.movies, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.colBackground,
      appBar: AppBar(
        title: Text(title),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, 
          childAspectRatio: 2/3,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailsScreen(movie: movies[index], id: movies[index].id,),
                ),
              );
            },
            child: GridTile(
              footer: Container(
                color: Colors.black.withOpacity(0.5),
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${movies[index].vote_average}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${movies[index].poster_path}',
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
