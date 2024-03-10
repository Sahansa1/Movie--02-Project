import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/Screens/movie_detailed_screen.dart';
import 'package:flutter_application_1/repttext.dart';

class Movies extends StatelessWidget {
  const Movies({
    super.key, 
    required this.snapshot,
  });

  final AsyncSnapshot snapshot; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, 
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          String releaseYear = '';
          if (snapshot.data![index].release_date != null) {
            DateTime releaseDate = DateTime.parse(snapshot.data![index].release_date);
            releaseYear = releaseDate.year.toString();
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child:GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailsScreen(
                      movie: snapshot.data[index], id: 0,
                    ),
                 ),
                );
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 250,
                      width: 200,
                      child: Image.network(
                        '${Constants.imagePath}${snapshot.data![index].poster_path}',
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      homeMovieName(snapshot.data![index].title),
                      const SizedBox(width: 7),
                      homeMovieYear(releaseYear)
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static fromJson(json) {}

}

                  