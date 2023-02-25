import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wembley_studios_movies/view_model/movies_view_model.dart';

import 'view/screen/home_screen.dart';

class WembleyStudiosMoviesApp extends StatelessWidget {
  const WembleyStudiosMoviesApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
