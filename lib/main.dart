import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'view_model/movies_view_model.dart';

/*
   Iniciamos app con el provider del ViewModel MoviesMV.
*/
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesVM()),
      ],
      child: const WembleyStudiosMoviesApp(),
    ),
  );
}
