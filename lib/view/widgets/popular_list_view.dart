import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../model/movie.dart';
import '../../view_model/movies_view_model.dart';

class PopularListView extends StatelessWidget {
  const PopularListView({super.key});

  @override
  Widget build(BuildContext context) {
    MoviesVM usersViewModel = context.watch<MoviesVM>();

    return Expanded(
      child: StreamBuilder(
        stream: usersViewModel.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<Movie> listMovies = [];
            listMovies = snapshot.data ?? [];

            return ListView.builder(
              itemBuilder: (context, index) {
                return (index != listMovies.length)
                    ? ListTile(
                        title: Text(
                          listMovies[index].title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        tileColor:
                            (index % 2 == 0) ? Colors.white : Colors.grey[80],
                        subtitle: Text(
                          listMovies[index].voteAverage.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            (usersViewModel.movieInFavorites(listMovies[index]))
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 20.0,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            (usersViewModel.movieInFavorites(listMovies[index]))
                                ? usersViewModel
                                    .quitFavoriteMovie(listMovies[index])
                                : usersViewModel
                                    .putFavoriteMovie(listMovies[index]);
                          },
                        ),
                      )
                    : IconButton(
                        alignment: Alignment.center,
                        icon: Icon(Icons.add),
                        onPressed: () {
                          usersViewModel.setCurrentPage(
                              usersViewModel.getCurrentPage() + 1);

                          if (usersViewModel.getModeListView() == 0) {
                            usersViewModel.enablePopularMovieStream(
                                usersViewModel.getCurrentPage());
                          } else {
                            usersViewModel.enableSearchMovieStream(
                                usersViewModel.getCriterion(),
                                usersViewModel.getCurrentPage());
                          }
                        });
              },
              itemCount: listMovies.length + 1,
            );
          }
        },
      ),
    );
  }
}
