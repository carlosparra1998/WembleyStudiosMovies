import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/api_response.dart';
import '../../model/movie.dart';
import '../../utils/strings.dart' as s;

class APICalls{
  Future<APIResponse> getPopularMoviesAPI(int page) async {
  try {
    List<Movie> lm = [];

    final response = await http.get(Uri.parse("${s.urlPopularMoviesAPI}$page"))
        .timeout(const Duration(seconds: 4));

    if (response.statusCode != 200) {
      return APIResponse(s.KO, s.no200Code, []);
    }

    json.decode(response.body)["results"].forEach((value) {
      lm.add(Movie.fromJSON(value));
    });

    return APIResponse(s.OK, "", lm);
  } on TimeoutException {
    return APIResponse(s.KO, s.timeoutCode, []);
  } on Exception {
    return APIResponse(s.KO, s.errorCode, []);
  }
}

Future<APIResponse> getSearchMoviesAPI(String criterion, int page) async {
  try {
    List<Movie> lm = [];

    String url = s.urlSearchMoviesAPI;

    url = ("${url.split("query=")[0]}query=${criterion.replaceAll(" ", "%20")}${url.split("query=")[1]}");
    url = ("$url$page");

    final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 4));
  
    if (response.statusCode != 200) {
      return APIResponse(s.KO, s.no200Code, []);
    }

    json.decode(response.body)["results"].forEach((value) {
      lm.add(Movie.fromJSON(value));
    });

    return APIResponse(s.OK, "", lm);
  } on TimeoutException {
    return APIResponse(s.KO, s.timeoutCode, []);
  } on Exception {
    return APIResponse(s.KO, s.errorCode, []);
  }
}
}