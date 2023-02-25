import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wembley_studios_movies/view/widgets/search_bar.dart';
import 'package:wembley_studios_movies/view_model/movies_view_model.dart';

import '../../model/movie.dart';
import 'popular_list_view.dart';

class PopularMoviesTab extends StatefulWidget {
  const PopularMoviesTab({super.key, required this.title});

  final String title;

  @override
  State<PopularMoviesTab> createState() => _PopularMoviesTab();
}

class _PopularMoviesTab extends State<PopularMoviesTab> {
  @override
  void dispose() {
    MoviesVM usersViewModel = context.watch<MoviesVM>();

    //usersViewModel.disposeStream();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MoviesVM usersViewModel = context.watch<MoviesVM>();

    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          children: [SearchBar(), PopularListView()],
        )),
      ),
    );
  }
}
