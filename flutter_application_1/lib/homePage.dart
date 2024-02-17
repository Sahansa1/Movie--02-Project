import 'package:flutter/material.dart';
import 'package:flutter_application_1/API/API.dart';
import 'package:flutter_application_1/Models/ListMovies.dart';
import 'package:flutter_application_1/widgets/Movies.dart';
import 'package:flutter_application_1/widgets/TrendingMovies.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ListMovies>> trendingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = API().getTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("BingeWatch"),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Trending Movies',
                ),
                SizedBox(height: 16),
                TrendingMovies(),
                SizedBox(height: 16),
                Text(
                  "Top rated movies",
                ),
                SizedBox(height: 5),
                Movies(),
                Text(
                  "Upcoming movies",
                ),
                SizedBox(height: 5),
                Movies(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


