import 'package:flutter/material.dart';

import '../widgets/popular_list_view.dart';
import '../widgets/search_bar.dart';

/*
   Este tab mostrará la lista de películas populares o buscadas por el usuario, y para ello llamará al ListView correspondiente.
*/

class PopularMoviesTab extends StatefulWidget {
  const PopularMoviesTab({super.key, required this.title});

  final String title;

  @override
  State<PopularMoviesTab> createState() => _PopularMoviesTab();
}

class _PopularMoviesTab extends State<PopularMoviesTab> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          children: [const SearchBar(), PopularListView()],
        )),
      ),
    );
  }
}
