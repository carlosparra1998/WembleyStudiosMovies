import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/movies_view_model.dart';

/*
   Widget de la barra de búsqueda.
*/
class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    MoviesVM usersViewModel = context.watch<MoviesVM>();
  
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  usersViewModel.setCriterion(value);
                  (value.isEmpty)
                      ? usersViewModel.enablePopularMovieStream(1)
                      : usersViewModel.enableSearchMovieStream(value, 1);
                },
                decoration: const InputDecoration(
                    hintText: "Buscar",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)))),
              ),
            );
  }
}