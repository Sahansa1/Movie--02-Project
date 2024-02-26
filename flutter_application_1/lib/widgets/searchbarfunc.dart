/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/checker.dart';
import 'package:flutter_application_1/repttext.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/API/api.dart';
import 'package:fluttertoast/fluttertoast.dart';

class searchbarfun extends StatefulWidget {
  const searchbarfun({super.key});

  @override
  State<searchbarfun> createState() => _searchbarfunState();
}

class _searchbarfunState extends State<searchbarfun> {
  List<Map<String, dynamic>> searchresult = [];

  Future<List> searchlistfunction(val) async {


  var searchurl =
        'https://api.themoviedb.org/3/search/multi?api_key=$API&query=$val';
    var searchresponse = await http.get(Uri.parse(searchurl));
    
    if (searchresponse.statusCode == 200) {
      var tempdata = jsonDecode(searchresponse.body);
      var searchjson = tempdata['results'];
      for (var i = 0; i < searchjson.length; i++) {
        if (searchjson[i]['id'] != null &&
            searchjson[i]['poster_path'] != null &&
            searchjson[i]['vote_average'] != null &&
            searchjson[i]['media_type'] != null) {
          searchresult.add({
            'id': searchjson[i]['id'],
            'poster_path': searchjson[i]['poster_path'],
            'vote_average': searchjson[i]['vote_average'],
            'media_type': searchjson[i]['media_type'],
            'popularity': searchjson[i]['popularity'],
            'overview': searchjson[i]['overview'],
          });
          
          if (searchresult.length > 20) {
          searchresult.removeRange(20, searchresult.length);
        }
      } else {
        print('null value found');
      }
    }
    return searchresult;
  } else {
    return [];
  }
}

final TextEditingController searchtext = TextEditingController();
  bool showlist = false;
  var val1;

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
              onSubmitted: (value) {
                searchresult.clear();
                setState(() {
                  val1 = value;
                  FocusManager.instance.primaryFocus?.unfocus();
                });
              },
              onChanged: (value) {
                searchresult.clear();
                setState(() {
                  val1 = value;
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
                    color: Colors.amber.withOpacity(0.6),
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.amber,
                ),
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.amber),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),

          searchtext.text.length > 0
              ? FutureBuilder(
                  future: searchlistfunction(val1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        color: Color.fromARGB(255, 107, 128, 105),
                        height: 400,
                        child: ListView.builder(
                          itemCount: searchresult.length,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => descriptioncheckui(
                                      searchresult[index]['id'],
                                      searchresult[index]['media_type'],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 4, bottom: 4),
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(96, 60, 60, 1),
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
                                                '${searchresult[index]['media_type']}',
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

                                                  //
                                                ],
                                              ),
                                            ),

                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.4,
                                              height: 85,
                                              child: const Text(
                                                textAlign: TextAlign.left,
                                                //' ${searchresult[index]['overview']}',
                                                'aaaa',
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
*/


/*

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';
import 'package:flutter_application_1/Models/list_movies.dart';
import 'package:flutter_application_1/Screens/checker.dart';
import 'package:flutter_application_1/repttext.dart';
import 'package:flutter_application_1/widgets/movies.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/API/api.dart';
import 'package:fluttertoast/fluttertoast.dart';

class searchbarfun extends StatefulWidget {
  const searchbarfun({super.key});

  @override
  State<searchbarfun> createState() => _searchbarfunState();
}

class _searchbarfunState extends State<searchbarfun> {
  //List<Map<String, dynamic>> searchresult = [];

  Future<List> searchlistfunction(val) async {
    List<Map<String, dynamic>> searchresult = [];

    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/search/movie?query=$val&api_key=${Constants.apiKey}'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> ListMovies = data['results'] ?? [];
      searchresult.addAll(ListMovies.map((json) => ListMovies.fromJson(json)).toList());
    } else {
      throw Exception('Failed to search movies');
    }

    return searchresult;
  }

  final TextEditingController searchtext = TextEditingController();
  bool showlist = false;
  var val1;

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
                color: Color.fromARGB(255, 38, 30, 30).withOpacity(0.2),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TextField(
                autofocus: false,
                controller: searchtext,
                onSubmitted: (value) {
                  searchresult.clear();
                  setState(() {
                    val1 = value;
                    FocusManager.instance.primaryFocus?.unfocus();
                  });
                },
                onChanged: (value) {
                  searchresult.clear();
                  setState(() {
                    val1 = value;
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
                        backgroundColor: Color.fromRGBO(18, 18, 18, 1),
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
                      color: Colors.amber.withOpacity(0.6),
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.amber,
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.amber),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),

            searchtext.text.length > 0
                ? FutureBuilder(
                    future: searchlistfunction(val1),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Container(
                          color: Color.fromARGB(255, 198, 173, 101),
                          height: 400,
                          child: ListView.builder(
                            itemCount: searchresult.length,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => descriptioncheckui(
                                        searchresult[index]['id'],
                                        searchresult[index]['media_type'],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 4, bottom: 4),
                                  height: 180,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(96, 60, 60, 1),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.4,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              'https://image.tmdb.org/t/p/w500${searchresult[index]['poster_path']}',
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
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
                                                  '${searchresult[index]['media_type']}',
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(5),
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        color: Colors.amber.withOpacity(0.2),
                                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                                      ),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Icon(
                                                              Icons.star,
                                                              color: Colors.amber,
                                                              size: 20,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            ratingtext('${searchresult[index]['vote_average']}'),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.all(5),
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        color: Colors.amber.withOpacity(0.2),
                                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                                      ),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Icon(
                                                              Icons.people_outline_sharp,
                                                              color: Colors.amber,
                                                              size: 20,
                                                            ),
                                                            SizedBox(
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
                                                  textAlign: TextAlign.left,
                                                  //' ${searchresult[index]['overview']}',
                                                  'aaaa',
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
                        );
                      } else {
                        return Center(
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
*/