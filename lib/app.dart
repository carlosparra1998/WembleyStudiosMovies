import 'package:flutter/material.dart';

import 'view/screen/home_screen.dart';

class WembleyStudiosMoviesApp extends StatelessWidget {
  const WembleyStudiosMoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(title: 'WembleyStudiosMovies'),
    );
  }
}