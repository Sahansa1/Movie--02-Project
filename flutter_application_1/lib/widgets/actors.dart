/*import 'package:flutter_application_1/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> fetchMovieCast(int movieId) async {

  final url = 'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=${Constants.APIKey}';
  
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<dynamic> cast = data['cast'];
    return cast;
  } else {
    throw Exception('Failed to load movie cast');
  }
}

*/

////////////////// this is for the cast ///////////////////////