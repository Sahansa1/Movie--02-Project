import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/list_movies.dart';
import 'package:flutter_application_1/Screens/abc.dart';
import 'package:flutter_application_1/Screens/checker.dart';
//import 'package:flutter_application_1/Screens/checker.dart';
import 'package:flutter_application_1/Screens/movie_detailed_screen.dart';
import 'package:flutter_application_1/repttext.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/Constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class searchbarfun extends StatefulWidget {
  const searchbarfun({super.key});

  @override
  State<searchbarfun> createState() => _searchbarfunState();
}

class _searchbarfunState extends State<searchbarfun> {
  List<Map<String, dynamic>> searchresult = [];

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
        if (searchjson[i]['id'] != null &&
            searchjson[i]['poster_path'] != null &&
            searchjson[i]['backdrop_path'] != null &&
            searchjson[i]['release_date'] != null &&
            searchjson[i]['title'] != null &&
            searchjson[i]['original_title'] != null &&
            searchjson[i]['vote_average'] != null 
            //searchjson[i]['media_type'] != null
            
            ) {
          searchresult.add({
            'id': searchjson[i]['id'],
            'poster_path': searchjson[i]['poster_path'],
            'vote_average': searchjson[i]['vote_average'],
            'backdrop_path': searchjson[i]['backdrop_path'],
            'release_date': searchjson[i]['release_date'],
            'title':searchjson[i]['title'],
            'original_title':searchjson[i]['original_title'],
            //'media_type': searchjson[i]['media_type'],
            'popularity': searchjson[i]['popularity'],
            'overview': searchjson[i]['overview'],
          });
          
          if (searchresult.length > 20) {
          searchresult.removeRange(20, searchresult.length);
        }
      } else {
        print('null value rr');
      }
    }
    return searchResults;
  } else {
    return [];
  }   
}

final TextEditingController searchtext = TextEditingController();
  bool showlist = false;
  String query1 ='';


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
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 38, 30, 30).withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TextField(
              autofocus: false,
              controller: searchtext,
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
                    Fluttertoast.showToast(
                      webBgColor: "#000000",
                      webPosition: "center",
                      webShowClose: true,
                      msg: "Search Cleared",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );

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
                hintStyle: const TextStyle(color: Color.fromARGB(255, 74, 74, 72)),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),

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
                    Text(query1),
                    //Text(searchresult.toString()),
                    Text(searchresult.length.toString()), // Text added here
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
                                popularity: searchresult[index]['popularity'].toDouble(),
                                release_date: searchresult[index]['release_date'], 
                                vote_average: searchresult[index]['vote_average'].toDouble(),
                                movieId: searchresult[index]['id'], 
                              );

                              // Navigate to the movie detailed screen while passing the ListMovies object
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailsScreen(movie: movie,id:searchresult[index]['id']),
                                ),
                              );
                            },

                            child: Container(
                              margin: const EdgeInsets.only(top: 4, bottom: 4),
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(131, 129, 129, 1),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.topCenter,
                                            child: tittletext(
                                              '${searchresult[index]['title']}',
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(5),
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.amber.withOpacity(0.2),
                                                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                          size: 20,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        ratingtext('${searchresult[index]['vote_average']}'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(5),
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: Colors.amber.withOpacity(0.2),
                                                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                                                  ),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Icon(
                                                          Icons.people_outline_sharp,
                                                          color: Colors.amber,
                                                          size: 20,
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        ratingtext('${searchresult[index]['popularity']}'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.4,
                                            height: 85,
                                            child: Text(
                                              ' ${searchresult[index]['overview']}',
                                              style: TextStyle(fontSize: 12, color: Colors.white),
                                            ),
                                          ),
                                        ],
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
                  color: Colors.amber,
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
