import 'package:flutter/material.dart';
/*import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Models/list_movies.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  List<ListMovies> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search term',
              ),
            ),
          ),
         ElevatedButton(
          onPressed: () async {
            
            String searchTerm = _searchController.text;
            if (searchTerm.isNotEmpty) {
              final api = API(); // Create an instance of the API class
              try {
                List<ListMovies> searchedMovies = await api.getSearchedMovies(searchTerm); // Call the method on the instance
                print('Search results: $searchedMovies'); // Print the search results to the console
                setState(() {
                  _searchResults = searchedMovies;
                });
              } catch (e) {
                print('Error in API: $e');
              }
            }
          },
          child: Text('Search'),
        ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                ListMovies movie = _searchResults[index];
                // Display the movie details in a ListTile or other widget.
                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
*/


class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('Back button pressed on SearchPage');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: Center(
          child: Text('Search Page'),
        ),
      ),
    );
  }
}