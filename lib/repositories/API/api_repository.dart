import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/movie.dart';
import '../../utils/strings.dart' as s;


class APIRepository{
  Future<List<Movie>> get getPopularMovie => getPopularMoviesAPI();
  Future<List<Movie>> getSearchMovies(String criterion) => getSearchMoviesAPI(criterion);
}

Future<List<Movie>> getPopularMoviesAPI() async{
  List<Movie> lm = [];

  print('obteniendo pelis');

  final response = await http.get(Uri.parse(s.tempPopularAPI));

  List<dynamic> t = json.decode(response.body)["results"];

  t.forEach((value) {
    lm.add(Movie.fromJSON(value));
  });

  return lm;

}

Future<List<Movie>> getSearchMoviesAPI(String criterion) async{
  List<Movie> lm = [];

  print(criterion);

  final response = await http.get(Uri.parse(s.tempSearchAPI.split("#")[0] + criterion.replaceAll(" ", "%20") + s.tempSearchAPI.split("#")[1]));
  print(s.tempSearchAPI.split("#")[0] + criterion.replaceAll(" ", "%20") + s.tempSearchAPI.split("#")[1]);
  List<dynamic> t = json.decode(response.body)["results"];



  print('pre');

  t.forEach((value) {
    lm.add(Movie.fromJSON(value));
  });
  print('post');
  return lm;

}
