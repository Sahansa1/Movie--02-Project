import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/list_movies.dart';
import 'package:flutter_application_1/Screens/movie_detailed_screen.dart';
import 'package:flutter_application_1/repttext.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/Constants.dart';

class searchbarfun extends StatefulWidget {
  const searchbarfun({super.key});

  @override
  State<searchbarfun> createState() => _searchbarfunState();
}

class _searchbarfunState extends State<searchbarfun> {
  List<Map<String, dynamic>> searchresult = [];

//Function to search for the movie with the query provided
  Future<List<ListMovies>> searchlistfunction(String query) async {
    List<ListMovies> searchResults = [];

    final response = await http.get(
      Uri.parse(
          'https://api.themoviedb.org/3/search/movie?query=$query&api_key=${Constants.APIKey}'),
    );

    if (response.statusCode == 200) {
      var tempdata = jsonDecode(response.body);
      var searchjson = tempdata['results'];
      for (var i = 0; i < searchjson.length; i++) {
        // Check if essential movie details are not null
        if (searchjson[i]['id'] != null &&
            searchjson[i]['poster_path'] != null &&
            searchjson[i]['backdrop_path'] != null &&
            searchjson[i]['release_date'] != null &&
            searchjson[i]['title'] != null &&
            searchjson[i]['original_title'] != null &&
            searchjson[i]['vote_average'] != null) {
              // Add movie details to search result list
          searchresult.add({
            'id': searchjson[i]['id'],
            'poster_path': searchjson[i]['poster_path'],
            'vote_average': searchjson[i]['vote_average'],
            'backdrop_path': searchjson[i]['backdrop_path'],
            'release_date': searchjson[i]['release_date'],
            'title': searchjson[i]['title'],
            'original_title': searchjson[i]['original_title'],
            'popularity': searchjson[i]['popularity'],
            'overview': searchjson[i]['overview'],
          });
          // Limit the search result list to 20 items

          if (searchresult.length > 20) {
            searchresult.removeRange(20, searchresult.length);
          }
        } else {
          print('null value is');
        }
      }
    }
    return searchResults;
  }

  final TextEditingController searchtext = TextEditingController();
  bool showlist = false;
  String query1 = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        showlist = !showlist;
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 30, bottom: 20, right: 10),
        child: Column(
          children: [
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 122, 112, 112).withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                autofocus: false,
                controller: searchtext,
                style: TextStyle(color: Colors.white),
                onSubmitted: (query) {
                  searchresult.clear();
                  setState(() {
                    query1 = query;
                    FocusManager.instance.primaryFocus?.unfocus();
                  });
                },
                onChanged: (query) {
                  searchresult.clear();
                  setState(() {
                    query1 = query;
                  });
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        searchtext.clear();
                        FocusManager.instance.primaryFocus?.unfocus();
                      });
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: const Color.fromARGB(255, 139, 139, 138).withOpacity(0.6),
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 121, 121, 121),
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Color.fromARGB(255, 169, 169, 165)),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
             // Display search results if query text is not empty
            searchtext.text.length > 0
                ? FutureBuilder(
                    future: searchlistfunction(query1),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Container(
                          color: Color.fromARGB(255, 34, 34, 34),
                          height: 400,
                          child: Column(
                            children: [
                             // Text(query1),
                             // Text(searchresult.length.toString()), // Text added here
                              Expanded(
                                child: ListView.builder(
                                  itemCount: searchresult.length,
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        ListMovies movie = ListMovies(
                                          id: searchresult[index]['id'],
                                          title: searchresult[index]['title'],
                                          backdrop_path: searchresult[index]['backdrop_path'],
                                          original_title: '',
                                          overview: searchresult[index]['overview'],
                                          poster_path: searchresult[index]['poster_path'],
                                          popularity: searchresult[index]['popularity'] != null
                                              ? searchresult[index]['popularity'].toDouble(): null,
                                          release_date: searchresult[index]['release_date'],
                                          vote_average: searchresult[index]['vote_average'] != null
                                              ? searchresult[index]['vote_average'].toDouble()
                                              : null,
                                          movieId: searchresult[index]['id'],
                                        );

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MovieDetailsScreen(movie: movie, id: searchresult[index]['id']),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 4, bottom: 4),
                                        height: 180,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                          color: Color.fromRGBO(59, 58, 58, 1),
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 200,
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    'https://image.tmdb.org/t/p/w500${searchresult[index]['poster_path']}',
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      tittletext(
                                                        '${searchresult[index]['title']}',
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.all(5),
                                                            height: 30,
                                                            decoration: BoxDecoration(
                                                              color: Color.fromARGB(255, 117, 76, 177).withOpacity(0.2),
                                                              borderRadius: const BorderRadius.all(Radius.circular(6)),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  color: Color.fromARGB(255, 145, 171, 74),
                                                                  size: 20,
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                ratingtext('${searchresult[index]['vote_average']}'),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.all(5),
                                                            height: 30,
                                                            decoration: BoxDecoration(
                                                              color: Colors.purple.withOpacity(0.2),
                                                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Icon(
                                                                  Icons.people_outline_sharp,
                                                                  color: Colors.purple,
                                                                  size: 20,
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                searchresult[index]['popularity'] != null
                                                                    ? ratingtext('${searchresult[index]['popularity']}')
                                                                    : Text('Popularity not available'),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      Expanded(
                                                        child: Container(
                                                          child: Text(
                                                            '${searchresult[index]['overview']}',
                                                            style: TextStyle(fontSize: 12, color: Colors.white),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.purple,
                          ),
                        );
                      }
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

