import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../view_model/movies_view_model.dart';

class FavoriteListView extends StatelessWidget {
  const FavoriteListView({super.key});

  @override
  Widget build(BuildContext context) {
    MoviesVM usersViewModel = context.watch<MoviesVM>();

    return SafeArea(
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
                (usersViewModel.movieInFavorites(
                        usersViewModel.getFavoritesMovies()[index]))
                    ? usersViewModel.quitFavoriteMovie(
                        usersViewModel.getFavoritesMovies()[index])
                    : usersViewModel.putFavoriteMovie(
                        usersViewModel.getFavoritesMovies()[index]);
              },
            ),
          );
        },
        itemCount: usersViewModel.getFavoritesMovies().length,
      )),
    );
  }
}
