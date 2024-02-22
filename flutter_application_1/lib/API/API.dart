import 'dart:convert';

import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/Models/ListMovies.dart';
import 'package:flutter_application_1/Models/ListSeries.dart';
import 'package:http/http.dart' as http;

class API {
  
    static const trendingMovieURL = 'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.APIKey}';
    static const topRatedMovieURL = 'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.APIKey}';
    static const upComingMovieURL = 'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.APIKey}';
    static const trendingSeriesURL ='https://api.themoviedb.org/3/trending/tv/day?api_key=${Constants.APIKey}';
    static const topRatedSeriesURL ='https://api.themoviedb.org/3/tv/top_rated?api_key=${Constants.APIKey}';
    static const upComingSeriesURL ='https://api.themoviedb.org/3/tv/top_rated?api_key=${Constants.APIKey}';

    

  Future<List<ListMovies>> getTrendingMovies() async {
    final response = await http.get(Uri.parse(trendingMovieURL));
    
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List<dynamic>;
      List<ListMovies> trendingMovies = decodedData.map((item) => ListMovies.fromJson(item)).toList();
      return trendingMovies;
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  Future<List<ListMovies>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse(topRatedMovieURL))!;
    
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List<dynamic>;
      List<ListMovies> trendingMovies = decodedData.map((item) => ListMovies.fromJson(item)).toList();
      return trendingMovies;
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }

  Future<List<ListMovies>> getUpComingMovies() async {
    final response = await http.get(Uri.parse(upComingMovieURL));
    
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List<dynamic>;
      List<ListMovies> trendingMovies = decodedData.map((item) => ListMovies.fromJson(item)).toList();
      return trendingMovies;
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }
   Future<List<ListSeries>> getTrendingSeries() async {
    final response = await http.get(Uri.parse(trendingSeriesURL));
    
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List<dynamic>;
      List<ListSeries> trendingSeries = decodedData.map((item) => ListSeries.fromJson(item)).toList();
      return trendingSeries;
    } else {
      throw Exception('Failed to load trending series');
    }
  }

  Future<List<ListSeries>> getUpComingSeries() async {
    final response = await http.get(Uri.parse(upComingSeriesURL));
    
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List<dynamic>;
      List<ListSeries> upComingSeries = decodedData.map((item) => ListSeries.fromJson(item)).toList();
      return upComingSeries;
    } else {
      throw Exception('Failed to load trending series');
    }
  }

  Future<List<ListSeries>> getTopRatedSeries() async {
    final response = await http.get(Uri.parse(topRatedSeriesURL));
    
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List<dynamic>;
      List<ListSeries> topRatedSeries = decodedData.map((item) => ListSeries.fromJson(item)).toList();
      return topRatedSeries;
    } else {
      throw Exception('Failed to load TopRated series');
    }
  }
}