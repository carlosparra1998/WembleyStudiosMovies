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
            toolbarHeight: 10,
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.favorite)),
              ],
            ),
            //title: Text('Wembley Studios Movies', style: TextStyle(fontSize: 15.0),),
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
