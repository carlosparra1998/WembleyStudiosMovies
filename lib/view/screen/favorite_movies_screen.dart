import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wembley_studios_movies/view_model/movies_view_model.dart';

import '../../model/movie.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  const FavoriteMoviesScreen({super.key, required this.title});

  final String title;

  @override
  State<FavoriteMoviesScreen> createState() => _FavoriteMoviesScreen();
}

class _FavoriteMoviesScreen extends State<FavoriteMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    MoviesVM usersViewModel = context.watch<MoviesVM>();

    return Scaffold(
      body: SafeArea(
        child: Center(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                usersViewModel.getFavoritesMovies()[index].title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              tileColor: (index % 2 == 0) ? Colors.white : Colors.grey[80],
              subtitle: Text(
                usersViewModel.getFavoritesMovies()[index].voteAverage.toString(),
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.favorite,
                  size: 20.0,
                  color: Colors.black,
                ),
                onPressed: () {
                  // usersViewModel.putFavoriteMovie(listMovies[index]);
                },
              ),
            );
          },
          itemCount: usersViewModel.getFavoritesMovies().length,
        )),
      ),
    );
  }
}
