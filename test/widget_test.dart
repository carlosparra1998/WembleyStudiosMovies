import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:wembley_studios_movies/app.dart';
import 'package:wembley_studios_movies/view/home/widgets/popular_list_view.dart';
import 'package:wembley_studios_movies/view/home/widgets/search_bar.dart';
import 'package:wembley_studios_movies/view_model/movies_view_model.dart';

void main() {
  testWidgets('Aparece la interfaz de usuario al iniciar la app',
      (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesVM()),
      ],
      child: const WembleyStudiosMoviesApp(),
    ));

    final searchBarFinder = find.byType(SearchBar);
    final listViewFinder = find.byType(PopularListView);

    expect(searchBarFinder, findsOneWidget);
    expect(listViewFinder, findsOneWidget);
  });

}
