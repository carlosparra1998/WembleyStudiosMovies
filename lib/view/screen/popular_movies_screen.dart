import 'package:flutter/material.dart';

class PopularMoviesScreen extends StatefulWidget {
  const PopularMoviesScreen({super.key, required this.title});

  final String title;

  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreen();
}

class _PopularMoviesScreen extends State<PopularMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'POPULAR FILMS',
            ),
          ],
        ),
      ),
    );
  }
}