
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/list_actors.dart';
import 'package:flutter_application_1/repttext.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/Constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class searchbarfun2 extends StatefulWidget {
  const searchbarfun2({Key? key}) : super(key: key);

  @override
  State<searchbarfun2> createState() => _searchbarfun2State();
}

class _searchbarfun2State extends State<searchbarfun2> {
  List<ListActors> searchresult = [];

  Future<List<ListActors>> searchlistfunction2(String query) async {
    List<ListActors> searchResults = [];

    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/search/person?api_key=${Constants.APIKey}&query=$query'),
    );

    if (response.statusCode == 200) {
      var tempdata = jsonDecode(response.body);
      var searchjson = tempdata['results'];
      for (var i = 0; i < searchjson.length; i++) {
        if (searchjson[i]['id'] != null &&
            searchjson[i]['name'] != null &&
            searchjson[i]['original_name'] != null &&
            searchjson[i]['known_for_department'] != null &&
            searchjson[i]['profile_path'] != null &&
            searchjson[i]['popularity'] != null &&
            searchjson[i]['gender'] != null &&
            searchjson[i]['known_for'] != null) {
          ListActors actor = ListActors(
            id: searchjson[i]['id'],
            name: searchjson[i]['name'],
            original_name: searchjson[i]['original_name'],
            known_for_department: searchjson[i]['known_for_department'],
            profile_path: searchjson[i]['profile_path'],
            popularity: searchjson[i]['popularity'].toDouble(),
            gender: searchjson[i]['gender'],
            known_for: List<Map<String, dynamic>>.from(searchjson[i]['known_for']),
          );

          searchResults.add(actor);

          if (searchResults.length > 20) {
            searchResults.removeRange(20, searchResults.length);
          }
        } else {
          print('null value ssdsds');
        }
      }

      return searchResults;
      
    } else {
      return [];
    }
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
                  hintText: 'Search Actors',
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
              future: searchlistfunction2(query1),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // Update searchresult with snapshot data
                  searchresult = snapshot.data as List<ListActors>; // Add this line
                  return Container(
                    color: Color.fromARGB(255, 34, 34, 34),
                    height: 400,
                    child: Column(
                      children: [
                        Text(query1),
                        Text(searchresult.length.toString()), // Text added here
                        Expanded(
                          child: ListView.builder(
                            itemCount: searchresult.length,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // Handle actor tap
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
                                              'https://image.tmdb.org/t/p/w500${searchresult[index].profile_path}',
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
                                                child: Text(
                                                  '${searchresult[index].name}',
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.4,
                                                height: 85,
                                                child: Text(
                                                  'Known for: ${searchresult[index].known_for.map((e) => e['title']).join(", ")}',
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