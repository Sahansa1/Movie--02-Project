import 'package:flutter/material.dart';
import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Models/list_movies.dart';
import 'package:flutter_application_1/Models/list_series.dart';
import 'package:flutter_application_1/widgets/movies.dart';
import 'package:flutter_application_1/widgets/navigation_drawer.dart';
import 'package:flutter_application_1/widgets/searchbar3.dart';
import 'package:flutter_application_1/widgets/series.dart';
import 'package:flutter_application_1/widgets/trending_movies.dart';
import 'package:flutter_application_1/widgets/trending_series.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ListMovies>> trendingMovies;
  late Future<List<ListMovies>> topratedMovies;
  late Future<List<ListMovies>> upcomingMovies;
  late Future<List<ListSeries>> trendingSeries;
  late Future<List<ListSeries>> topRatedSeries;
  late Future<List<ListSeries>> upComingSeries;

  @override
  void initState() {
    super.initState();
    trendingMovies = API().getTrendingMovies();
    topratedMovies = API().getTopRatedMovies();
    upcomingMovies = API().getUpComingMovies();
    trendingSeries = API().getTrendingSeries();
    topRatedSeries = API().getTopRatedSeries();
    upComingSeries = API().getUpComingSeries();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child:Scaffold(
          drawer: const MenuDrawer(),
            body: Column(
            children: [
              AppBar(
                backgroundColor: Colors.blue,
                title: const Text("BingeWatch"),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings),
                  )
                ],
              ),
              const TabBar(
                labelColor: Colors.blue, 
                unselectedLabelColor: Colors.black,
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
                            const Text('Trending Movies',),
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
                            searchbarfun(),
                            const SizedBox(height: 16),
                            const Text(
                              "Top rated movies",
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
                                },
                              ),
                            ),  
                            const Text(
                              "Upcoming movies",
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
                            const Text('Trendingies',),
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
                            const Text(
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
                            const Text(
                              "UpComing series",
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              child: FutureBuilder(
                                future: upComingSeries,
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text('snapshot.error.toString()'),
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
        ),
      ),
    );
  }
}
