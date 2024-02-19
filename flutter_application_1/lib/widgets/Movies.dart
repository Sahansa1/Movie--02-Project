import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/Models/ListMovies.dart';
import 'package:flutter_application_1/Screens/DetailScreen.dart';

class Movies extends StatelessWidget {
  const Movies({
    Key? key,
    required this.snapshot, // Change this to snapshot
  }) : super(key: key);

  final AsyncSnapshot<List<ListMovies>> snapshot; // Change this to AsyncSnapshot<List<ListMovies>>

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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(snapshot.data![index].title), // Example of accessing movie title
          );
        },
      ),
    );
  }
}
