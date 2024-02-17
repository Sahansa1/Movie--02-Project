import 'dart:convert';

import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/Models/ListMovies.dart';
import 'package:http/http.dart' as http;


class API {
  
    static const trendingURL = 'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.APIKey}';
    static const topRatedURL = 'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.APIKey}';
    static const upComingURL = 'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.APIKey}';

  Future<List<ListMovies>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(trendingURL));
    
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List<dynamic>;
      List<ListMovies> trendingMovies = decodedData.map((item) => ListMovies.fromJson(item)).toList();
      return trendingMovies;
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  Future<List<ListMovies>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(topRatedURL));
    
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List<dynamic>;
      List<ListMovies> trendingMovies = decodedData.map((item) => ListMovies.fromJson(item)).toList();
      return trendingMovies;
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  Future<List<ListMovies>> getUpComingMovies() async {
    final response = await http.get(Uri.parse(upComingURL));
    
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List<dynamic>;
      List<ListMovies> trendingMovies = decodedData.map((item) => ListMovies.fromJson(item)).toList();
      return trendingMovies;
    } else {
      throw Exception('Failed to load trending movies');
    }
  }


}