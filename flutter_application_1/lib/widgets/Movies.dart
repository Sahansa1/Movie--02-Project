import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';

class Movies extends StatelessWidget {
  const Movies({
    super.key, required this.snapshot,
  });


  final AsyncSnapshot snapshot; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, 
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
         return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
           
            height:200,
            width:200,
            child: Image.network(
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              '${Constants.imagePath}${snapshot.data![index].poster_path}'),
         )
          );
        },
      ),
    );
  }
}

