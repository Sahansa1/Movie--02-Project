
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/API/api.dart';

class MovieDetails extends StatefulWidget {
  var id;
  MovieDetails({this.id});
  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  List<Map<String, dynamic>> MovieDetails = [];

  Future Moviedetails() async {
    var moviedetailurl = 'https://api.themoviedb.org/3/movie/' +
        widget.id.toString() +
        '?api_key=$API';

    var moviedetailresponse = await http.get(Uri.parse(moviedetailurl));
      if (moviedetailresponse.statusCode == 200) {
        var moviedetailjson = jsonDecode(moviedetailresponse.body);
        for (var i = 0; i < 1; i++) {
          MovieDetails.add({
            "backdrop_path": moviedetailjson['backdrop_path'],
            "title": moviedetailjson['title'],
            "vote_average": moviedetailjson['vote_average'],
            "overview": moviedetailjson['overview'],
            "release_date": moviedetailjson['release_date'],
          });
        }      
      }
    }
    
  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('iiii'),
        //title: Text(MovieDetails[0]['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${MovieDetails[0]['backdrop_path']}',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Vote Average: ${MovieDetails[0]['vote_average'].toString()}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Overview: ${MovieDetails[0]['overview']}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Release Date: ${MovieDetails[0]['release_date']}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}