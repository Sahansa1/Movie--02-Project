import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/Models/list_actors.dart';
import 'package:flutter_application_1/Models/list_movies.dart';
import 'package:flutter_application_1/Screens/movie_detailed_screen.dart';
import 'package:flutter_application_1/colour.dart';
import 'package:flutter_application_1/repttext.dart';


class ActorsDetailsScreen extends StatelessWidget {
  final int id;
  final ListActors actor;

  const ActorsDetailsScreen({
    Key? key,
    required this.actor,
    required this.id,
  }) : super(key: key);

  @override



  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colours.colBackground,
    body: CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: const BackButton(),
          backgroundColor: const Color.fromARGB(255, 39, 38, 37),
          expandedHeight: 500,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              '${Constants.imagePath}${actor.profile_path}',
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                overviewTtitle(
                  'actor.name'
                  ),
                
                SizedBox(height: 16),
                datetext(
                  'Original Name: ${actor.original_name}',
                ),
                SizedBox(height: 8),
                datetext(
                  'Popularity: ${actor.popularity.toString()}',
                ),
                SizedBox(height: 8),
                if (actor.gender == 1)
                  datetext(
                    'Gender: Female',
                  ),
                if (actor.gender == 2)
                  datetext(
                    'Gender: Male',
                  ),
                
                SizedBox(height: 16),
                 datetext(
                  'Movies Done:',
                  
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 200, 
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: actor.known_for.length,
              itemBuilder: (context, index) {
                // Creating a movie object from the data
                final movie = ListMovies(
                  id: actor.known_for[index]['id'],
                  title: actor.known_for[index]['title'],
                  backdrop_path: actor.known_for[index]['backdrop_path'], 
                  original_title: '', 
                  overview: actor.known_for[index]['overview'],
                  poster_path: actor.known_for[index]['poster_path'],
                  popularity: actor.known_for[index]['popularity'].toDouble(),
                   release_date: actor.known_for[index]['release_date'], 
                   vote_average: actor.known_for[index]['vote_average'].toDouble(),
                  movieId: actor.known_for[index]['id'], 
                );            
                                  
                return GestureDetector(
                  onTap: () {
                    // Navigating to the movie details screen when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(movie: movie, id: id,),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.lightBlue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.network(
                            '${Constants.imagePath}${movie.poster_path}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8),
                        // Displaying movie title
                        datetext(
                          movie.title,
                          
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

}

