import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../model/api_response.dart';
import '../model/movie.dart';
import '../model/stream_response.dart';
import '../repositories/API/api_repository.dart';
import '../repositories/DB/database_repository.dart';
import '../repositories/cache/cache_repository.dart';
import '../utils/show_toast.dart';
import '../utils/strings.dart' as s;

class MoviesVM with ChangeNotifier {
  final StreamController<StreamResponse> _streamController =
      BehaviorSubject<StreamResponse>(); 

  bool movieInFavorites(Movie movie) => CacheRepository().movieInFavorites(movie);
  
  List<Movie> getFavoritesMovies() => CacheRepository().getFavoriteMovies;

  Stream<StreamResponse> get stream {
    if (!_streamController.hasListener) {
      enablePopularMovieStream(1);
    }

    return _streamController.stream;
  }

  int getCurrentPage() => CacheRepository().getCurrentPage;
  int getModeListView() => CacheRepository().getModeListView;
  int getVolcadoOK() => CacheRepository().getVolcadoOK;
  String getCriterion() => CacheRepository().getCriterion;

  void setCurrentPage(int page) => CacheRepository().setCurrentPage = page;
  void setModeListView(int mode) => CacheRepository().setModeListView = mode;
  void setCriterion(String criterion) => CacheRepository().setCriterion = criterion;
  void setVolcadoOK(int volcado) => CacheRepository().setVolcadoOK = volcado;



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
      notifyListeners();
    }
  }

  Future enablePopularMovieStream(int page) async {

    setModeListView(0);

    APIResponse popularMovies = await APIRepository().getPopularMovie(page);

    if (popularMovies.status != s.OK) {
      String statusStream = s.OK;

      if (popularMovies.message == s.errorCode) {
        showToast("No hay conexión a internet");
        statusStream = s.KO;
      } else {
        showToast("Error en el servidor");
        statusStream = s.KO;
      }

      _streamController.add(
          StreamResponse(statusStream, CacheRepository().getPopularMovies));

    } else {
      if (page == 1) {
        setCurrentPage(1);
        CacheRepository().setPopularMovies = popularMovies.response;
        _streamController.add(StreamResponse(s.OK, popularMovies.response));

      } else {
        CacheRepository().addPopularMovies = popularMovies.response;
        _streamController
            .add(StreamResponse(s.OK, CacheRepository().getPopularMovies));
      }
    }

    notifyListeners();
  }

  Future enableSearchMovieStream(String criterion, int page) async {

    setModeListView(1);

    APIResponse searchMovies =
        await APIRepository().getSearchMovies(criterion, page);

    if (searchMovies.status != s.OK) {
      String statusStream = s.OK;

      if (searchMovies.message == s.errorCode) {
        showToast("No hay conexión a internet");
        statusStream = s.KO;
      } else {
        showToast("Error en el servidor");
        statusStream = s.KO;
      }

      _streamController.add(
          StreamResponse(statusStream, CacheRepository().getPopularMovies));

    } else {
      if (page == 1) {
        setCurrentPage(1);
        CacheRepository().setPopularMovies = searchMovies.response;
        _streamController.add(StreamResponse(s.OK, searchMovies.response));

      } else {
        CacheRepository().addPopularMovies = searchMovies.response;
        _streamController
            .add(StreamResponse(s.OK, CacheRepository().getPopularMovies));
      }
    }

    notifyListeners();
  }

}
