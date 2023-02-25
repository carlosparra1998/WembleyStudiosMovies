import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../view_model/movies_view_model.dart';
import '../widgets/favorite_movies_tab.dart';
import '../widgets/popular_movies_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MoviesVM usersViewModel = context.watch<MoviesVM>();

    usersViewModel.volcadoDatabase2Cache();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 10,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list)),
              Tab(icon: Icon(Icons.favorite)),
            ],
          ),
          //title: Text('Wembley Studios Movies', style: TextStyle(fontSize: 15.0),),
        ),
        body: TabBarView(
          children: [PopularMoviesTab(title: ''), FavoriteMoviesTab(title: '')],
        ),
      ),
    );
  }
}
