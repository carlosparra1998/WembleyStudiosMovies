import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wembley_studios_movies/model/movie.dart';
import 'package:wembley_studios_movies/repositories/API/api_repository.dart';
import 'package:wembley_studios_movies/repositories/DB/database_repository.dart';
import 'package:wembley_studios_movies/repositories/cache/cache_repository.dart';

class MoviesVM with ChangeNotifier {
  StreamController<List<Movie>> _streamController =
      StreamController<List<Movie>>();

  Stream<List<Movie>> get stream {
    if (!_streamController.hasListener) {
      enablePopularMovieStream(1);
    }

    return _streamController.stream;
  }

  Future enablePopularMovieStream(int page) async {
    setModeListView(0);

    List<Movie> popularMovies = await APIRepository().getPopularMovie(page);

    if (page == 1) {
      setCurrentPage(1);
      CacheRepository().setPopularMovies = popularMovies;
      _streamController.add(popularMovies);
    } else {
      CacheRepository().addPopularMovies = popularMovies;
      _streamController.add(CacheRepository().getPopularMovies);
    }
    notifyListeners();
  }

  Future enableSearchMovieStream(String criterion, int page) async {
    setModeListView(1);

    List<Movie> searchMovies =
        await APIRepository().getSearchMovies(criterion, page);
    if (page == 1) {
      setCurrentPage(1);
      CacheRepository().setPopularMovies = searchMovies;
      _streamController.add(searchMovies);
    } else {
      CacheRepository().addPopularMovies = searchMovies;
      _streamController.add(CacheRepository().getPopularMovies);
    }
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

  int getCurrentPage() => CacheRepository().getCurrentPage;

  void setCurrentPage(int page) => CacheRepository().setCurrentPage = page;

  int getModeListView() => CacheRepository().getModeListView;
  void setModeListView(int mode) => CacheRepository().setModeListView = mode;

  String getCriterion() => CacheRepository().getCriterion;

  void setCriterion(String criterion) =>
      CacheRepository().setCriterion = criterion;
}
