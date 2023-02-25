import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/movies_view_model.dart';
import 'tabs/favorite_movies_tab.dart';
import 'tabs/popular_movies_tab.dart';

/*
   Pantalla principal (hacemos uso de 2 tabs : lista de películas populares y favoritas).
*/

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MoviesVM moviesViewModel = context.watch<MoviesVM>();


    //PERSISTENCIA: Volcamos la lista de películas favoritas a la memoria caché.

    moviesViewModel.volcadoDatabase2Cache();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          toolbarHeight: 10,
          bottom: TabBar(
            indicatorColor: Colors.grey[200],
            labelColor: Colors.white,
            tabs: const [
              Tab(text: 
                'Populares'),
              Tab(text: 
                'Mi lista'),
            ],
          ),
          
        ),
        body: const TabBarView(
          children: [PopularMoviesTab(title: ''), FavoriteMoviesTab(title: '')],
        ),
      ),
    );
  }
}
