import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wembley_studios_movies/view_model/movies_view_model.dart';

import '../../model/movie.dart';
import 'favorite_list_view.dart';

class FavoriteMoviesTab extends StatefulWidget {
  const FavoriteMoviesTab({super.key, required this.title});

  final String title;

  @override
  State<FavoriteMoviesTab> createState() => _FavoriteMoviesTab();
}

class _FavoriteMoviesTab extends State<FavoriteMoviesTab> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FavoriteListView(),
    );
  }
}
