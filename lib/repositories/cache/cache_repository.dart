import '../../model/movie.dart';

class CacheRepository {
  static List<Movie> _popularMovies = [];
  static List<Movie> _favoritesMovies = [];

  static int _currentPage = 1;
  static int _modeListView = 0; // 0 -> populars, 1 -> search
  static int _volcadoOK = 0;
  static String _criterion = "";

  get getPopularMovies {
    return _popularMovies;
  }

  get getFavoriteMovies {
    return _favoritesMovies;
  }

  get getCurrentPage {
    return _currentPage;
  }

  get getModeListView {
    return _modeListView;
  }

  get getCriterion {
    return _criterion;
  }

  get getVolcadoOK {
    return _volcadoOK;
  }

  set setCurrentPage(int page) {
    _currentPage = page;
  }

  set setModeListView(int mode) {
    _modeListView = mode;
  }

  set setCriterion(String criterion) {
    _criterion = criterion;
  }

  set setVolcadoOK(int volcado) {
    _volcadoOK = volcado;
  }

  void deleteFavoriteMovie(Movie movie) {
    _favoritesMovies.removeWhere((m) => m.id == movie.id);
  }

  bool movieInFavorites(Movie movie) {
    return _favoritesMovies.any((m) => movie.id == m.id);
  }

  set setFavoriteMovie(Movie movie) {
    _favoritesMovies.add(movie);
  }

  set setFavoriteMovies(List<Movie> movies) {
    _favoritesMovies = movies;
  }

  set setPopularMovies(List<Movie> popularMovies) {
    _popularMovies = popularMovies;
  }

  set addPopularMovies(List<Movie> popularMovies) {
    for (var movie in popularMovies) {
      _popularMovies.add(movie);
    }
  }
}
