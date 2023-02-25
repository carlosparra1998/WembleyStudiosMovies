import 'package:flutter/material.dart';

import 'view/home/home_screen.dart';

/*
   Iniciamos app con pantalla principal.
*/

class WembleyStudiosMoviesApp extends StatelessWidget {
  const WembleyStudiosMoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const HomeScreen(),
    );
  }
}
