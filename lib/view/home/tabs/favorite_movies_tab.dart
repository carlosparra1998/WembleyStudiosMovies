import 'package:flutter/material.dart';

import '../widgets/favorite_list_view.dart';

/*
   Este tab mostrará la lista de películas favoritas del usuario, y para ello llamará al ListView correspondiente.
*/

class FavoriteMoviesTab extends StatefulWidget {
  const FavoriteMoviesTab({super.key, required this.title});

  final String title;

  @override
  State<FavoriteMoviesTab> createState() => _FavoriteMoviesTab();
}

class _FavoriteMoviesTab extends State<FavoriteMoviesTab> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FavoriteListView(),
    );
  }
}
