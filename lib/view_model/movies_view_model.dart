import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wembley_studios_movies/model/api_response.dart';
import 'package:wembley_studios_movies/model/movie.dart';
import 'package:wembley_studios_movies/repositories/API/api_repository.dart';
import 'package:wembley_studios_movies/repositories/DB/database_repository.dart';
import 'package:wembley_studios_movies/repositories/cache/cache_repository.dart';
import 'package:wembley_studios_movies/utils/show_toast.dart';

import '../model/stream_response.dart';

class MoviesVM with ChangeNotifier {
  StreamController<StreamResponse> _streamController =
      BehaviorSubject<StreamResponse>(); //StreamController<List<Movie>>();

  Stream<StreamResponse> get stream {
    if (!_streamController.hasListener) {
      enablePopularMovieStream(1);
    }

    return _streamController.stream;
  }

  void disposeStream() {
    _streamController.close();
    notifyListeners();
  }

  Future enablePopularMovieStream(int page) async {
    setModeListView(0);

    APIResponse popularMovies = await APIRepository().getPopularMovie(page);

    if (popularMovies.status != "OK") {
      String statusStream = "OK";

      if (popularMovies.message == "ERROR") {
        showToast("No hay conexión a internet");
        statusStream = "KO";
      } else {
        showToast("Error en el servidor");
        statusStream = "KO";
      }

      _streamController.add(
          StreamResponse(statusStream, CacheRepository().getPopularMovies));
    } else {
      if (page == 1) {
        setCurrentPage(1);
        CacheRepository().setPopularMovies = popularMovies.response;
        _streamController.add(StreamResponse("OK", popularMovies.response));
      } else {
        CacheRepository().addPopularMovies = popularMovies.response;
        _streamController
            .add(StreamResponse("OK", CacheRepository().getPopularMovies));
      }
    }

    notifyListeners();
  }

  Future enableSearchMovieStream(String criterion, int page) async {
    setModeListView(1);

    APIResponse searchMovies =
        await APIRepository().getSearchMovies(criterion, page);

    if (searchMovies.status != "OK") {
      String statusStream = "OK";

      if (searchMovies.message == "ERROR") {
        showToast("No hay conexión a internet");
        statusStream = "KO";
      } else {
        showToast("Error en el servidor");
        statusStream = "KO";
      }

      _streamController.add(
          StreamResponse(statusStream, CacheRepository().getPopularMovies));
    } else {
      if (page == 1) {
        setCurrentPage(1);
        CacheRepository().setPopularMovies = searchMovies.response;
        _streamController.add(StreamResponse("OK", searchMovies.response));
      } else {
        CacheRepository().addPopularMovies = searchMovies.response;
        _streamController
            .add(StreamResponse("OK", CacheRepository().getPopularMovies));
      }
    }

    notifyListeners();
  }

  //Stream<List<Movie>> _getMoviesStream = Stream.fromFuture(APIRepository().getPopularMovie);

  //Stream<List<Movie>> _getSearchMoviesStream = Stream.fromFuture(APIRepository().getSearchMovies);

  List<Movie> getFavoritesMovies() => CacheRepository().getFavoriteMovies;

  void putFavoriteMovie(Movie movie) async {
    CacheRepository().setFavoriteMovie = movie;
    await DatabaseRepository().initDB();
    await DatabaseRepository().insertMovie(movie);
    showToast("Añadido a tu lista de películas favoritas");
    notifyListeners();
  }

  void quitFavoriteMovie(Movie movie) async {
    CacheRepository().deleteFavoriteMovie(movie);
    await DatabaseRepository().initDB();
    await DatabaseRepository().deleteMovie(movie.id);
    showToast("Retirado de tu lista de películas favoritas");
    notifyListeners();
  }

  Future<void> volcadoDatabase2Cache() async {
    if (getVolcadoOK() == 0) {
      await DatabaseRepository().initDB();
      CacheRepository().setFavoriteMovies =
          await DatabaseRepository().getListMovies();
      setVolcadoOK(1);
      print('database init');
      notifyListeners();
    }
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

  int getVolcadoOK() => CacheRepository().getVolcadoOK;

  void setVolcadoOK(int volcado) => CacheRepository().setVolcadoOK = volcado;
}
