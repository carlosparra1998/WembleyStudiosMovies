import 'dart:async';

import '../../model/api_response.dart';
import 'api_calls.dart';


class APIRepository {
  Future<APIResponse> getPopularMovie(int page) => APICalls().getPopularMoviesAPI(page);
  Future<APIResponse> getSearchMovies(String criterion, int page) =>
      APICalls().getSearchMoviesAPI(criterion, page);
}


