import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/movie.dart';
import '../../utils/strings.dart' as s;


class APIRepository{
  Future<List<Movie>> get getPopularMovie => getPopularMoviesAPI();

}

Future<List<Movie>> getPopularMoviesAPI() async{
  List<Movie> lm = [];
  print('here madafaka');
  final response = await http.get(Uri.parse(s.tempPopularAPI));

  print(json.decode(response.body));
    print(json.decode(response.body)["results"].runtimeType);

  List<dynamic> t = json.decode(response.body)["results"];
    print(t);

  t.forEach((value) {
    print(value);
    lm.add(Movie.fromJSON(value));
  });
  print('here madafaka');

  return lm;

}