import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/stream_response.dart';
import '../../../utils/strings.dart' as s;
import '../../../view_model/movies_view_model.dart';
import 'star_row.dart';

/*
   En este ListView se muestran las películas más populares, o las buscadas por el propio usuario, todo ello obteniendo 
   el stream de comunicación, el cual se conecta a las APIs necesarias. El stream se obtiene por el ViewModel.
*/

/*
   Si el usuario desea acceder a páginas posteriores de películas, debe de deslizarse al final de la lista, y par ello deberá pulsar el botón correspondiente.
*/

/*
   Si el usuario desea buscar películas a partir de un criterio de búsqueda, podrá usar el widget correspondiente, con la misma lógica que las películas populares.
*/

class PopularListView extends StatelessWidget {
  PopularListView({super.key});

  @override
  Widget build(BuildContext context) {
    MoviesVM moviesViewModel = context.watch<MoviesVM>();

    return Expanded(
      child: StreamBuilder(
        stream: moviesViewModel.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            StreamResponse streamMovies;
            streamMovies = snapshot.data ?? StreamResponse(s.KO, []);

            return ListView.builder(
              controller: moviesViewModel.listController,
              itemBuilder: (context, index) {
                return (index != streamMovies.response.length)
                    ? ListTile(
                        title: Text(
                          streamMovies.response[index].title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        tileColor:
                            (index % 2 == 0) ? Colors.white : Colors.grey[80],
                        subtitle: StarBar(
                            streamMovies.response[index].voteAverage,
                            streamMovies.response[index].voteCount),
                        leading: AspectRatio(
                          aspectRatio: 1.7,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                            child: (streamMovies
                                    .response[index].posterPath.isNotEmpty)
                                ? CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "${s.urlGetImageAPI}/${streamMovies.response[index].posterPath}",
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )
                                : const SizedBox(
                                    child: DecoratedBox(
                                      decoration:
                                          BoxDecoration(color: Colors.grey),
                                    ),
                                  ),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            (moviesViewModel.movieInFavorites(
                                    streamMovies.response[index]))
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 20.0,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            (moviesViewModel.movieInFavorites(
                                    streamMovies.response[index]))
                                ? moviesViewModel.quitFavoriteMovie(
                                    streamMovies.response[index])
                                : moviesViewModel.putFavoriteMovie(
                                    streamMovies.response[index]);
                          },
                        ),
                      )
                    : ((streamMovies.status == s.OK)
                        ? Center(
                            child: ClipOval(
                              child: Material(
                                color: Colors.black, 
                                child: InkWell(
                                  splashColor: Colors.grey, 
                                  onTap: () {
                                    moviesViewModel.setCurrentPage(
                                        moviesViewModel.getCurrentPage() + 1);

                                    if (moviesViewModel.getModeListView() ==
                                        0) {
                                      moviesViewModel.enablePopularMovieStream(
                                          moviesViewModel.getCurrentPage());
                                    } else {
                                      moviesViewModel.enableSearchMovieStream(
                                          moviesViewModel.getCriterion(),
                                          moviesViewModel.getCurrentPage());
                                    }
                                  },
                                  child: SizedBox(
                                      width: 35,
                                      height: 35,
                                      child:
                                          Icon(Icons.add, color: Colors.white)),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: ClipOval(
                              child: Material(
                                color: Colors.black, // Button color
                                child: InkWell(
                                  splashColor: Colors.grey, // Splash color
                                  onTap: () {
                                    if (moviesViewModel.getModeListView() ==
                                        0) {
                                      moviesViewModel.enablePopularMovieStream(
                                          moviesViewModel.getCurrentPage());
                                    } else {
                                      moviesViewModel.enableSearchMovieStream(
                                          moviesViewModel.getCriterion(),
                                          moviesViewModel.getCurrentPage());
                                    }
                                  },
                                  child: SizedBox(
                                      width: 35,
                                      height: 35,
                                      child:
                                          Icon(Icons.refresh, color: Colors.white)),
                                ),
                              ),
                            ),
                          )); 
              },
              itemCount: streamMovies.response.length + 1,
            );
          }
        },
      ),
    );
  }
}
