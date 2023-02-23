
import 'package:flutter/material.dart';
import 'package:wembley_studios_movies/model/movie.dart';
import 'package:wembley_studios_movies/repositories/API/api_repository.dart';
import 'package:wembley_studios_movies/repositories/DB/database_repository.dart';
import 'package:wembley_studios_movies/repositories/cache/cache_repository.dart';

class MoviesVM with ChangeNotifier {

     Stream<List<Movie>> getMoviesStream = Stream.fromFuture(APIRepository().getPopularMovie);
  
}
