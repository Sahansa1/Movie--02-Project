import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/Models/list_movies.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int id;
   MovieDetailsScreen({
    super.key, 
    required this.movie, 
    required this.id,
    });

  final ListMovies movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar.large(
          leading: const BackButton(),

          backgroundColor: Colors.amber,
          expandedHeight:500,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title:Text(movie.title),
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
            child: Column(children: [
              const Text('Overview'
              ),
              const SizedBox(height: 16),
              Text(
                movie.overview,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border:Border.all(
                          color: Colors.lightBlue, 
                        ),
                        borderRadius: BorderRadius.circular(10),  
                      ),
                      child: Row(children: [
                        const Text('Release Date: '),
                        Text(movie.release_date),
                      ],),
                    ),

                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border:Border.all(
                          color: Colors.lightBlue, 
                          ),
                        borderRadius: BorderRadius.circular(10),  
                      ),
                      child: Row(children: [
                        const Text('Rating: '),
                        const Icon( Icons.star,
                        color: Colors.amber,
                        ),
                        Text('${movie.vote_average.toStringAsFixed(1)}/10'),
                      ],),
                    ),

                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border:Border.all(
                          color: Colors.lightBlue, 
                          ),
                        borderRadius: BorderRadius.circular(10),  
                      ),
                      child: Row(children: [
                        const Text('Popularity: '),
                        Text(movie.popularity.toString()),
                      ],),
                    ),

                  ],
                ),
              ),
            ],),
          ),
        )   
      ],
      ),
      
    );
  }
}

