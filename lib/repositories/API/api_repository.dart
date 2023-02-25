import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:wembley_studios_movies/utils/show_toast.dart';

import '../../model/api_response.dart';
import '../../model/movie.dart';
import '../../utils/strings.dart' as s;

class APIRepository {
  Future<APIResponse> getPopularMovie(int page) => getPopularMoviesAPI(page);
  Future<APIResponse> getSearchMovies(String criterion, int page) =>
      getSearchMoviesAPI(criterion, page);
}

Future<APIResponse> getPopularMoviesAPI(int page) async {
  try {
    List<Movie> lm = [];

    final response = await http
        .get(Uri.parse(s.tempPopularAPI.split("page=")[0] +
            "page=" +
            page.toString() +
            s.tempPopularAPI.split("page=")[1]))
        .timeout(Duration(seconds: 4));

    if (response.statusCode != 200) {
      return APIResponse("KO", "NO_200", []);
    }

    json.decode(response.body)["results"].forEach((value) {
      lm.add(Movie.fromJSON(value));
    });

    return APIResponse("OK", "", lm);
  } on TimeoutException {
    return APIResponse("KO", "TIMEOUT", []);
  } on Exception {
    return APIResponse("KO", "ERROR", []);
  }
}

Future<APIResponse> getSearchMoviesAPI(String criterion, int page) async {
  try {
    List<Movie> lm = [];

    String url = s.tempSearchAPI;

    url = ("${url.split("query=")[0]}query=${criterion.replaceAll(" ", "%20")}${url.split("query=")[1]}");
    url = ("${url.split("page=")[0]}page=$page${url.split("page=")[1]}");

    final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 4));
  
    if (response.statusCode != 200) {
      return APIResponse("KO", "NO_200", []);
    }

    json.decode(response.body)["results"].forEach((value) {
      lm.add(Movie.fromJSON(value));
    });

    return APIResponse("OK", "", lm);
  } on TimeoutException {
    return APIResponse("KO", "TIMEOUT", []);
  } on Exception {
    return APIResponse("KO", "ERROR", []);
  }
}
