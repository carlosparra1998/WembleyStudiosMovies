import '../../model/movie.dart';

class CacheRepository{
  static List<Movie> _popularMovies = [];
  static List<Movie> _favoritesMovies = [];

  get getPopularMovies{
    return _popularMovies;
  }

  get getFavoriteMovies{
    return _favoritesMovies;
  }

  void deleteFavoriteMovie(Movie movie){

    _favoritesMovies.removeWhere((m) => m.id == movie.id);

  }

  bool movieInFavorites(Movie movie){
     return _favoritesMovies.any((m) => movie.id == m.id);
  }
  
  set setFavoriteMovie(Movie movie){
    _favoritesMovies.add(movie);
  }
  set setFavoriteMovies(List<Movie> movies){
    _favoritesMovies = movies;
  }
  set setPopularMovies(dynamic popularMovies){
    _popularMovies = popularMovies;
  }
}