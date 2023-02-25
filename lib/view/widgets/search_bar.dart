import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../view_model/movies_view_model.dart';

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
                decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            );
  }
}