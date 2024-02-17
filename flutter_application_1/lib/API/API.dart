import 'dart:convert';

import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/Models/ListMovies.dart';
import 'package:http/http.dart' as http;


class API {
  Future<List<ListMovies>> getTrendingMovies() async {
    final trendingURL = 'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.APIKey}';


    final response = await http.get(Uri.parse(trendingURL));
    
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List<dynamic>;
      print(decodedData);
      List<ListMovies> trendingMovies = decodedData.map((item) => ListMovies.fromJson(item)).toList();
      return trendingMovies;
    } else {
      throw Exception('Failed to load trending movies');
    }
  }
}