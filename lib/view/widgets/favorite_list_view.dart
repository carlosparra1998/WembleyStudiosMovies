import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../utils/strings.dart' as s;
import '../../view_model/movies_view_model.dart';
import 'start_bar.dart';

class FavoriteListView extends StatelessWidget {
  const FavoriteListView({super.key});

  @override
  Widget build(BuildContext context) {
    MoviesVM usersViewModel = context.watch<MoviesVM>();

    return SafeArea(
      child: Center(
          child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
                      title: Text(
                        usersViewModel.getFavoritesMovies()[index].title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.7),
                      ),
                      tileColor:
                          (index % 2 == 0) ? Colors.white : Colors.grey[80],
                      subtitle: StarBar(usersViewModel.getFavoritesMovies()[index].voteAverage, usersViewModel.getFavoritesMovies()[index].voteCount),
                      leading: AspectRatio(
                        aspectRatio: 2.35,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          child: (usersViewModel.getFavoritesMovies()[index].posterPath.isNotEmpty)
                              ? 
                                CachedNetworkImage(
                                        fit: BoxFit.cover,
                                          imageUrl: s.tempGetImageAPI +
                                              "w500/" +
                                              usersViewModel.getFavoritesMovies()[index].posterPath,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              new Icon(Icons.error),
                                        )
                              : SizedBox(
                                  child: const DecoratedBox(
                                    decoration: const BoxDecoration(
                                        color: Colors.grey),
                                  ),
                                ),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          (usersViewModel.movieInFavorites(usersViewModel.getFavoritesMovies()[index]))
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 20.0,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          (usersViewModel.movieInFavorites(usersViewModel.getFavoritesMovies()[index]))
                              ? usersViewModel
                                  .quitFavoriteMovie(usersViewModel.getFavoritesMovies()[index])
                              : usersViewModel
                                  .putFavoriteMovie(usersViewModel.getFavoritesMovies()[index]);
                        },
                      ),
                    );
        },
        itemCount: usersViewModel.getFavoritesMovies().length,
      )),
    );
  }
}
