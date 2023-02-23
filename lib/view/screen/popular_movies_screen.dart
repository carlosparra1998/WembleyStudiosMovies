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

    List<Movie> listMovies = [];
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: StreamBuilder(
            stream: usersViewModel.getMoviesStream,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                 return CircularProgressIndicator();
              }
             else {  
                listMovies = snapshot.data ?? [];
                return ListView.builder(
                  itemBuilder: (context, index){
                    title: Text(listMovies[index].title);
                  },
                  itemCount: listMovies.length,
                );
              }
            },
          )
        ),
      ),
    );
  }
}
