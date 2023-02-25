import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/strings.dart' as s;
import '../../../view_model/movies_view_model.dart';
import 'star_row.dart';

/*
   En este ListView se muestran las películas favoritas por el usuario, todo ello obteniendo la caché gracias al ViewModel.
*/

class FavoriteListView extends StatelessWidget {
  const FavoriteListView({super.key});

  @override
  Widget build(BuildContext context) {
    MoviesVM moviesViewModel = context.watch<MoviesVM>();

    return SafeArea(
      child: Center(
          child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
                      title: Text(
                        moviesViewModel.getFavoritesMovies()[index].title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.7),
                      ),
                      tileColor:
                          (index % 2 == 0) ? Colors.white : Colors.grey[80],
                      subtitle: StarBar(moviesViewModel.getFavoritesMovies()[index].voteAverage, moviesViewModel.getFavoritesMovies()[index].voteCount),
                      leading: AspectRatio(
                        aspectRatio: 2.35,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          child: (moviesViewModel.getFavoritesMovies()[index].posterPath.isNotEmpty)
                              ? 
                                CachedNetworkImage(
                                        fit: BoxFit.cover,
                                          imageUrl: "${s.urlPopularMoviesAPI}w500/${moviesViewModel.getFavoritesMovies()[index].posterPath}",
                                          placeholder: (context, url) => const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        )
                              : const SizedBox(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: Colors.grey),
                                  ),
                                ),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          (moviesViewModel.movieInFavorites(moviesViewModel.getFavoritesMovies()[index]))
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 20.0,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          (moviesViewModel.movieInFavorites(moviesViewModel.getFavoritesMovies()[index]))
                              ? moviesViewModel
                                  .quitFavoriteMovie(moviesViewModel.getFavoritesMovies()[index])
                              : moviesViewModel
                                  .putFavoriteMovie(moviesViewModel.getFavoritesMovies()[index]);
                        },
                      ),
                    );
        },
        itemCount: moviesViewModel.getFavoritesMovies().length,
      )),
    );
  }
}
