import 'package:flutter/material.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  const FavoriteMoviesScreen({super.key, required this.title});

  final String title;

  @override
  State<FavoriteMoviesScreen> createState() => _FavoriteMoviesScreen();
}

class _FavoriteMoviesScreen extends State<FavoriteMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'FAVORITE FILMS',
            ),
          ],
        ),
      ),
    );
  }
}