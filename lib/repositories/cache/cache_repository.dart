import '../../model/movie.dart';

class CacheRepository{
  List<Movie> _popularMovies = [];

  get getPopularMovies{
    return _popularMovies;
  }
  

  set setPopularMovies(dynamic popularMovies){
    this._popularMovies = popularMovies;
  }
}