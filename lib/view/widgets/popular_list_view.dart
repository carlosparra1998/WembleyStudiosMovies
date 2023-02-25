import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wembley_studios_movies/model/stream_response.dart';
import 'package:wembley_studios_movies/view/widgets/start_bar.dart';

import '../../model/movie.dart';
import '../../utils/strings.dart' as s;
import '../../view_model/movies_view_model.dart';

class PopularListView extends StatelessWidget {
  const PopularListView({super.key});

  @override
  Widget build(BuildContext context) {
    MoviesVM usersViewModel = context.watch<MoviesVM>();

    return Expanded(
      child: StreamBuilder(
        stream: usersViewModel.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            StreamResponse streamMovies;
            streamMovies = snapshot.data ?? StreamResponse("KO", []);

            return ListView.builder(
              itemBuilder: (context, index) {
                return (index != streamMovies.response.length)
                    ? ListTile(
                        title: Text(
                          streamMovies.response[index].title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.7),
                        ),
                        tileColor:
                            (index % 2 == 0) ? Colors.white : Colors.grey[80],
                        subtitle: StarBar(
                            streamMovies.response[index].voteAverage,
                            streamMovies.response[index].voteCount),
                        leading: AspectRatio(
                          aspectRatio: 2.35,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                            child: (streamMovies
                                    .response[index].posterPath.isNotEmpty)
                                ? CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: s.tempGetImageAPI +
                                        "w500/" +
                                        streamMovies.response[index].posterPath,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()),
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
                            (usersViewModel.movieInFavorites(
                                    streamMovies.response[index]))
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 20.0,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            (usersViewModel.movieInFavorites(
                                    streamMovies.response[index]))
                                ? usersViewModel.quitFavoriteMovie(
                                    streamMovies.response[index])
                                : usersViewModel.putFavoriteMovie(
                                    streamMovies.response[index]);
                          },
                        ),
                      )
                    : ((streamMovies.status == "OK")
                        ? IconButton(
                            alignment: Alignment.center,
                            icon: Icon(Icons.add),
                            onPressed: () {
                              usersViewModel.setCurrentPage(
                                  usersViewModel.getCurrentPage() + 1);

                              if (usersViewModel.getModeListView() == 0) {
                                usersViewModel.enablePopularMovieStream(
                                    usersViewModel.getCurrentPage());
                              } else {
                                usersViewModel.enableSearchMovieStream(
                                    usersViewModel.getCriterion(),
                                    usersViewModel.getCurrentPage());
                              }
                            })
                        : IconButton(
                            alignment: Alignment.center,
                            icon: Icon(Icons.refresh),
                            onPressed: () {
                              usersViewModel.setCurrentPage(1);

                              if (usersViewModel.getModeListView() == 0) {
                                usersViewModel.enablePopularMovieStream(
                                    1);
                              } else {
                                usersViewModel.enableSearchMovieStream(
                                    usersViewModel.getCriterion(),
                                    1);
                              }
                            }));
              },
              itemCount: streamMovies.response.length + 1,
            );
          }
        },
      ),
    );
  }
}
