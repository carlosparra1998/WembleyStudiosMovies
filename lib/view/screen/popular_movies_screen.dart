import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wembley_studios_movies/view_model/movies_view_model.dart';

import '../../model/movie.dart';

class PopularMoviesScreen extends StatefulWidget {
  const PopularMoviesScreen({super.key, required this.title});

  final String title;

  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreen();
}

class _PopularMoviesScreen extends State<PopularMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    MoviesVM usersViewModel = context.watch<MoviesVM>();

    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  
                  (value.isEmpty)
                      ? usersViewModel.enablePopularMovieStream()
                      : usersViewModel.enableSearchMovieStream(value);
                },
                decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
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
                        return ListTile(
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
                              (usersViewModel
                                      .movieInFavorites(listMovies[index]))
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 20.0,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              (usersViewModel
                                      .movieInFavorites(listMovies[index]))
                                  ? usersViewModel
                                      .quitFavoriteMovie(listMovies[index])
                                  : usersViewModel
                                      .putFavoriteMovie(listMovies[index]);
                            },
                          ),
                        );
                      },
                      itemCount: listMovies.length,
                    );
                  }
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
