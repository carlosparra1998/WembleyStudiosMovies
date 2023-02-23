import 'package:flutter/material.dart';
import 'package:wembley_studios_movies/view/screen/favorite_movies_screen.dart';
import 'package:wembley_studios_movies/view/screen/popular_movies_screen.dart';

class WembleyStudiosMoviesApp extends StatelessWidget {
  const WembleyStudiosMoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              //add
              IconButton(icon: Icon(Icons.search), iconSize: 30.0, onPressed: () {})
            ],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.favorite)),
              ],
            ),
            title: Text('Wembley Studios Movies'),
          ),
          body: TabBarView(
            children: [
              PopularMoviesScreen(title: ''),
              FavoriteMoviesScreen(title: '')
            ],
          ),
        ),
      ),
    );
  }
}
