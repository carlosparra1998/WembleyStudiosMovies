import '../../model/movie.dart';

class CacheRepository{
  List<Movie> _popularMovies = [];

  List<Movie> _favoriteMovies = [];

  get getPopularMovies{
    return _popularMovies;
  }
  
  get getFavoriteFilms{
    return _favoriteMovies;
  }
}