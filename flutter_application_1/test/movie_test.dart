import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/movie_detailed_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/Models/list_movies.dart';


void main() {
  testWidgets('MovieDetailsScreen - Display movie title', (WidgetTester tester) async {
    // Mock movie data
    final movie = ListMovies(
      id: 1,
      title: 'Test Movie',
      overview: 'Test Overview',
      release_date: '2024-03-15',
      popularity: 8.5,
      vote_average: 9.0,
      backdrop_path: 'test_backdrop_path.jpg', original_title: '', poster_path: '', movieId: 0,
    );

    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: MovieDetailsScreen(movie: movie, id: 1),
      ),
    );

    // Verify that the movie title is displayed
    expect(find.text('Test Movie'), findsOneWidget);
  });
}
