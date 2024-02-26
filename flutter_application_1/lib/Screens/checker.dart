import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/list_movies.dart';
import 'package:flutter_application_1/widgets/movie_details.dart';

class descriptioncheckui extends StatefulWidget {
  var newid;
  var newtype;
  descriptioncheckui(this.newid, this.newtype);

  @override
  State<descriptioncheckui> createState() => _descriptioncheckuiState();
}

class _descriptioncheckuiState extends State<descriptioncheckui> {
  checktype() {
    
      return ListMovies(
        id: widget.newid, 
        title: 'title',
         backdrop_path: '', 
        original_title: '', 
        vote_average: 0,
         overview: '', 
        poster_path: '',
         popularity: 0, 
         release_date: '',
          movieId: 0,
      );
    //} else {
      //return errorui(context);
    
    
  }

  @override
  Widget build(BuildContext context) {
    return checktype();
  }
}

Widget errorui(context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Error'),
    ),
    body: Center(
      child: Text('no Such page found'),
    ),
  );
}
