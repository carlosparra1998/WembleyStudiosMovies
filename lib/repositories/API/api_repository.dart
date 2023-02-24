import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/movie.dart';
import '../../utils/strings.dart' as s;


class APIRepository{
  Future<List<Movie>> getPopularMovie(int page) => getPopularMoviesAPI(page);
  Future<List<Movie>> getSearchMovies(String criterion, int page) => getSearchMoviesAPI(criterion, page);
}

Future<List<Movie>> getPopularMoviesAPI(int page) async{
  List<Movie> lm = [];

  print('obteniendo pelis');

  final response = await http.get(Uri.parse(s.tempPopularAPI.split("page=")[0] + "page=" + page.toString() + s.tempPopularAPI.split("page=")[1]));

  List<dynamic> t = json.decode(response.body)["results"];

  t.forEach((value) {
    lm.add(Movie.fromJSON(value));
  });

  return lm;

}

Future<List<Movie>> getSearchMoviesAPI(String criterion, int page) async{
  List<Movie> lm = [];

  String url = s.tempSearchAPI;

  url = (url.split("query=")[0] + "query=" + criterion.replaceAll(" ", "%20") + url.split("query=")[1]);
  url = (url.split("page=")[0] + "page=" + page.toString() + url.split("page=")[1]);

  final response = await http.get(Uri.parse(url));
  List<dynamic> t = json.decode(response.body)["results"];



  print('pre');

  t.forEach((value) {
    lm.add(Movie.fromJSON(value));
  });
  print('post');
  return lm;

}
