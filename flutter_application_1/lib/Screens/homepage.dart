import 'package:flutter/material.dart';
import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Models/list_movies.dart';
import 'package:flutter_application_1/Models/list_series.dart';
import 'package:flutter_application_1/Screens/all_movies.dart';
import 'package:flutter_application_1/Screens/show_all_movies.dart';
import 'package:flutter_application_1/repttext.dart';
import 'package:flutter_application_1/widgets/movies.dart';
import 'package:flutter_application_1/widgets/navigation_drawer.dart';
import 'package:flutter_application_1/widgets/search_by_actor.dart';
import 'package:flutter_application_1/widgets/searchbar.dart';
import 'package:flutter_application_1/widgets/series.dart';
import 'package:flutter_application_1/widgets/trending_movies.dart';
import 'package:flutter_application_1/widgets/trending_series.dart';
import 'package:flutter_application_1/colour.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ListMovies>> trendingMovies;
  late Future<List<ListMovies>> topratedMovies;
  late Future<List<ListMovies>> upcomingMovies;
  late Future<List<ListMovies>> childrenFriendlyMovies;
  late Future<List<ListMovies>> highestGrossingMovies;
  late Future<List<ListMovies>> bestMovies;
  late Future<List<ListSeries>> trendingSeries;
  late Future<List<ListSeries>> topRatedSeries;
  late Future<List<ListSeries>> upComingSeries;
  late Future<List<ListSeries>> childrenFriendlySeries;
  late Future<List<ListSeries>> highestGrossingSeries;
  bool showSearchBar1 = true;

  @override
  void initState() {
    super.initState();
    trendingMovies = API().getTrendingMovies();
    topratedMovies = API().getTopRatedMovies();
    upcomingMovies = API().getUpComingMovies();
    childrenFriendlyMovies = API().getChildrenFriendlyMovies();
    highestGrossingMovies = API().getHighestGrossingMovies();
    trendingSeries = API().getTrendingSeries();
    topRatedSeries = API().getTopRatedSeries();
    upComingSeries = API().getUpComingSeries();
    childrenFriendlySeries = API().getChildrenFriendlySeries();
    highestGrossingSeries= API().getHighestGrossingSeries();
    bestMovies= API().getBestMovies();
  }

  void _navigateToShowAllMoviesScreen(String movieType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoviesGridScreen(movieType: movieType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child:Scaffold(
          backgroundColor: Colours.colBackground,
          drawer: const MenuDrawer(),
            body: Stack(
            children: [
              Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0, 
                    title: Center(
                      child: Image.asset('assets/bingewatch_wording.png', width: 200), // Center the logo and make it bigger
                    ),
                  ),
                  
                  
                   TabBar(
                    labelColor: Colors.white, 
                    unselectedLabelColor: Colours.tabTitles,
                    tabs: [
                      Tab(text: 'Movies'),
                      Tab(text: 'Series'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                tittletext("Trending Movies"),
                                const SizedBox(height: 16),
                                FutureBuilder(
                                  future: trendingMovies,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text(snapshot.error.toString()),
                                      );
                                    } else if (snapshot.hasData) {
                                      return TrendingMovies(snapshot: snapshot);
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                                Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          showSearchBar1 = true;
                                        });
                                      },
                                      child: Text('Title'),
                                    ),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          showSearchBar1 = false;
                                        });
                                      },
                                      child: Text('Actor'),
                                    ),
                                  ],
                                ),
                                if (showSearchBar1)
                                    searchbarfun(),
                                if (!showSearchBar1)
                                    searchbarfun2(),
                                const SizedBox(height: 2),
                                tittletext("Top rated movies"),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      _navigateToShowAllMoviesScreen("Top Rated");
                                    },
                                    child: Text('See more'),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  child: FutureBuilder(
                                    future: topratedMovies,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(snapshot.error.toString()),
                                        );
                                      } else if (snapshot.hasData) {
                                        return Movies(snapshot: snapshot);
                                      } else {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                    }
                                  ),
                                ),  

                                tittletext("Best movies"),
                                const SizedBox(height: 5),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      _navigateToShowAllMoviesScreen("Best");
                                    },
                                    child: Text('See more'),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  child: FutureBuilder(
                                    future: bestMovies,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(snapshot.error.toString()),
                                        );
                                      } else if (snapshot.hasData) {
                                        return Movies(snapshot: snapshot);
                                      } else {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                    }
                                  ),
                                ),

                                tittletext("Upcoming movies"),
                                const SizedBox(height: 5),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      _navigateToShowAllMoviesScreen("UpComing");
                                    },
                                    child: Text('See more'),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  child: FutureBuilder(
                                    future: upcomingMovies,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(snapshot.error.toString()),
                                        );
                                      } else if (snapshot.hasData) {
                                        return Movies(snapshot: snapshot);
                                      } else {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                    }
                                  ),
                                ),
                                tittletext("Children Friendly movies"),
                        
                                const SizedBox(height: 5),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: ElevatedButton(
                                    onPressed: () async{
                                      _navigateToShowAllMoviesScreen("Children");
                                    },
                                    child: Text('See more'),
                                  ),
                                ),
                                SizedBox(
                                  child: FutureBuilder(
                                    future: childrenFriendlyMovies,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(snapshot.error.toString()),
                                        );
                                      } else if (snapshot.hasData) {
                                        return Movies(snapshot: snapshot);
                                      } else {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                    }
                                  ),
                                ),
                               
                                tittletext("Highest grossing movies"),
                                const SizedBox(height: 5),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      _navigateToShowAllMoviesScreen('Grossing');
                                    },
                                    child: Text('See more'),
                                  ),
                                ),
                                SizedBox(
                                  child: FutureBuilder(
                                    future: highestGrossingMovies,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(snapshot.error.toString()),
                                        );
                                      } else if (snapshot.hasData) {
                                        return Movies(snapshot: snapshot);
                                      } else {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                    }
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                tittletext('Trending Series',),
                                const SizedBox(height: 16),
                                FutureBuilder(
                                  future: trendingSeries,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        //child: Text('serrrror'),
                                        child: Text(snapshot.error.toString()),
                                      );
                                    } else if (snapshot.hasData) {
                                      return TrendingSeries(snapshot: snapshot);
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }, 
                                ),
                                const SizedBox(height: 16),
                                tittletext(
                                  "Top rated series",
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  child: FutureBuilder(
                                    future: topRatedSeries,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(snapshot.error.toString()),
                                        );
                                      } else if (snapshot.hasData) {
                                        return Series(snapshot: snapshot);
                                      } else {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                    }
                                  ),
                                ),
                                const SizedBox(height: 16),
                                tittletext(
                                  "UpComing series",
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  child: FutureBuilder(
                                    future: upComingSeries,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(snapshot.error.toString()),
                                        );
                                      } else if (snapshot.hasData) {
                                        return Series(snapshot: snapshot);
                                      } else {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                    }
                                  ),
                                ),
                                const SizedBox(height: 16),
                                tittletext(
                                  "Children Friendly Series",
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  child: FutureBuilder(
                                    future: childrenFriendlySeries,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(snapshot.error.toString()),
                                        );
                                      } else if (snapshot.hasData) {
                                        return Series(snapshot: snapshot);
                                      } else {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                    }
                                  ),
                                ),
                                tittletext(
                                  "Highest Grossing Series",
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  child: FutureBuilder(
                                    future: highestGrossingSeries,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return Center(
                                          child: Text(snapshot.error.toString()),
                                        );
                                      } else if (snapshot.hasData) {
                                        return Series(snapshot: snapshot);
                                      } else {
                                        return const Center(child: CircularProgressIndicator());
                                      }
                                    }
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}