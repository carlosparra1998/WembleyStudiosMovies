import 'package:sqflite/sqflite.dart';

import '../../model/movie.dart';

class DatabaseRepository {
  late Database _db;

  initDB() async {
    _db = await openDatabase(
      'databaseLocal.db',
      version: 1,
      onCreate: (Database db, int version) {
        db.execute(
            "CREATE TABLE movie (id NUMERIC PRIMARY KEY, title TEXT NOT NULL, original_title TEXT NOT NULL, overview TEXT NOT NULL, original_language TEXT NOT NULL, poster_path TEXT NOT NULL, backdrop_path TEXT NOT NULL, release_date TEXT NOT NULL, popularity TEXT NOT NULL, vote_average NUMERIC NOT NULL, vote_count NUMERIC NOT NULL, adult NUMERIC NOT NULL, video NUMERIC NOT NULL, genreIds TEXT NOT NULL);");
      },
    );
  }

  //CREATE

  insertMovies(List<Movie> listMovies) {
    listMovies.forEach((movie) {
      insertMovie(movie);
    });
  }

  insertMovie(Movie c) async {
    _db.insert("movie", c.toMap());
  }

  //READ

  Future<List<Movie>> getListMovies() async {
    List<Map<String, dynamic>> results = await _db.query("movie");
    return results.map((map) => Movie.fromMap(map)).toList();
  }

  //UPDATE

  //DELETE

  deleteMovie(int id) async {
    _db.delete(
      'movie',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  deleteListMovies() async {
    await _db.delete('movie');
  }
}
