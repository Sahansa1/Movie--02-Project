import 'dart:convert';

import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/Models/list_movies.dart';
import 'package:flutter_application_1/Models/list_series.dart';
import 'package:http/http.dart' as http;

class API {
  
    static const trendingMovieURL = 'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.APIKey}';
    static const topRatedMovieURL = 'https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.APIKey}';
    static const upComingMovieURL = 'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.APIKey}';
    static const childrenFriendlyMoviesURL = 'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.APIKey}&sort_by=revenue.desc&adult=false&with_genres=16'; 
    static const highestGrossingMoviesURL = 'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.APIKey}&sort_by=revenue.desc';
    static const trendingSeriesURL ='https://api.themoviedb.org/3/trending/tv/day?api_key=${Constants.APIKey}';
    static const topRatedSeriesURL ='https://api.themoviedb.org/3/tv/top_rated?api_key=${Constants.APIKey}';
    static const upComingSeriesURL ='https://api.themoviedb.org/3/tv/on_the_air?api_key=${Constants.APIKey}';
    static const searchMoviesURL = 'https://api.themoviedb.org/3/search/movie?api_key=${Constants.APIKey}';
    static const highestGrossingSeriesURL = 'https://api.themoviedb.org/3/discover/tv?api_key=${Constants.APIKey}&sort_by=revenue.desc';
    static const childrenFriendlySeriesURL = 'https://api.themoviedb.org/3/discover/tv?api_key=${Constants.APIKey}&sort_by=revenue.desc&adult=false&with_genres=16'; 
  


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
    final response = await http.get(Uri.parse(topRatedMovieURL));
    
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
      throw Exception('Failed to load up coming series');
    }
  }

  Future<List<ListSeries>> getTopRatedSeries() async {
    final response = await http.get(Uri.parse(topRatedSeriesURL));
    
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List<dynamic>;
      List<ListSeries> topRatedSeries = decodedData.map((item) => ListSeries.fromJson(item)).toList();
      return topRatedSeries;
    } else {
      throw Exception('Failed to load top rated series');
    }
  }

  Future<List<ListMovies>> getSearchedMovies(String searchTerm) async {
    final queryParameters = {'query': searchTerm};
    final uri = Uri.parse(searchMoviesURL).replace(queryParameters: queryParameters);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List<dynamic>;
      List<ListMovies> searchedMovies = decodedData.map((item) => ListMovies.fromJson(item)).toList();
      return searchedMovies;
    } else {
      throw Exception('Failed to search movies');
    }
  }


  Future<List<ListMovies>> getChildrenFriendlyMovies() async {
    final response = await http.get(Uri.parse(childrenFriendlyMoviesURL));
    
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List<dynamic>;
      List<ListMovies> childrenFriendlyMovies = decodedData.map((item) => ListMovies.fromJson(item)).toList();
      return childrenFriendlyMovies;
    } else {
      throw Exception('Failed to load children friendly movies');
    }
  }  

  Future<List<ListSeries>> getChildrenFriendlySeries() async {
    final response = await http.get(Uri.parse(childrenFriendlySeriesURL));
    
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List<dynamic>;
      List<ListSeries> childrenFriendlySeries = decodedData.map((item) => ListSeries.fromJson(item)).toList();
      return childrenFriendlySeries;
    } else {
      throw Exception('Failed to load children friendly series');
    }
  }  

Future<List<ListMovies>> getHighestGrossingMovies() async {
    final response = await http.get(Uri.parse(highestGrossingMoviesURL));
    
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List<dynamic>;
      List<ListMovies> highestGrossingMovies = decodedData.map((item) => ListMovies.fromJson(item)).toList();
      return highestGrossingMovies;
    } else {
      throw Exception('Failed to load highest grossings movies');
    }
  }  

Future<List<ListSeries>> getHighestGrossingSeries() async {
    final response = await http.get(Uri.parse(highestGrossingSeriesURL));
    
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List<dynamic>;
      List<ListSeries> highestGrossingSeries = decodedData.map((item) => ListSeries.fromJson(item)).toList();
      return highestGrossingSeries;
    } else {
      throw Exception('Failed to load highest grossings series');
    }
  }  
  
  
}