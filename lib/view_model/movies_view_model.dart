import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wembley_studios_movies/model/movie.dart';
import 'package:wembley_studios_movies/repositories/API/api_repository.dart';
import 'package:wembley_studios_movies/repositories/DB/database_repository.dart';
import 'package:wembley_studios_movies/repositories/cache/cache_repository.dart';

class MoviesVM with ChangeNotifier {
  StreamController<List<Movie>> _streamController =
      StreamController<List<Movie>>();

  Stream<List<Movie>> get stream{
    print('CALL22222');
    if(!_streamController.hasListener){
       enablePopularMovieStream();
    }
    
    return _streamController.stream;
  }

  Future enablePopularMovieStream() async {
     _streamController.add(await APIRepository().getPopularMovie);
     notifyListeners();
  }

  Future enableSearchMovieStream(String criterion) async {
     _streamController.add(await APIRepository().getSearchMovies(criterion));
     notifyListeners();
  }
  //Stream<List<Movie>> _getMoviesStream = Stream.fromFuture(APIRepository().getPopularMovie);

  //Stream<List<Movie>> _getSearchMoviesStream = Stream.fromFuture(APIRepository().getSearchMovies);

  List<Movie> getFavoritesMovies() => CacheRepository().getFavoriteMovies;

  void putFavoriteMovie(Movie movie) async {
    CacheRepository().setFavoriteMovie = movie;
    //await DatabaseRepository().initDB();
    //await DatabaseRepository().insertMovie(movie);
    notifyListeners();
  }

  void quitFavoriteMovie(Movie movie) async {
    CacheRepository().deleteFavoriteMovie(movie);
    notifyListeners();
  }

  Future<void> volcadoDatabase2Cache() async {
    await DatabaseRepository().initDB();
    CacheRepository().setFavoriteMovies =
        await DatabaseRepository().getListMovies();
    notifyListeners();
  }

  bool movieInFavorites(Movie movie) {
    return CacheRepository().movieInFavorites(movie);
  }
}
