class Movie {
  late int id;
  late String title;
  late String originalTitle;
  late String overview;
  late String originalLanguage;
  late String posterPath;
  late String backdropPath;
  late String releaseDate;
  late double popularity;
  late double voteAverage;
  late int voteCount;
  late bool adult;
  late bool video;
  late List<int> genreIds = [];

  Movie(
      this.id,
      this.title,
      this.originalTitle,
      this.overview,
      this.originalLanguage,
      this.posterPath,
      this.backdropPath,
      this.releaseDate,
      this.popularity,
      this.voteAverage,
      this.voteCount,
      this.adult,
      this.video,
      this.genreIds);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "original_title": originalTitle,
      "original_language": originalLanguage,
      "poster_path": posterPath,
      "overview" : overview,
      "backdrop_path": backdropPath,
      "release_date": releaseDate,
      "popularity": popularity,
      "vote_average": voteAverage,
      "vote_count": voteCount,
      "adult": (adult) ? 1 : 0,
      "video": (video) ? 1 : 0,
      "genre_ids": getGenreIdsSerialized()
    };
  }

  Movie.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    originalTitle = map['original_title'];
    originalLanguage = map['original_language'];
    posterPath = map['poster_path'];
    backdropPath = map['backdrop_path'];
    overview = map['overview'];
    releaseDate = map['release_date'];
    popularity =double.parse( map['popularity']);
    voteAverage = map['vote_average'];
    voteCount = map['vote_count'];
    adult = (map['adult'] == 0) ? false : true;
    video = (map['video'] == 0) ? false : true;
    genreIds = deserializeGenreIds(map['genre_ids']);
  }

  String getGenreIdsSerialized() {
    String genreIdsSerialized = "";

    this.genreIds.asMap().forEach((index, element) {
      genreIdsSerialized = (genreIdsSerialized.isEmpty)
          ? "$element"
          : "$genreIdsSerialized;$element";
    });

    return genreIdsSerialized;
  }

  List<int> deserializeGenreIds(String genreIdsString) {
    List<int> genreIds = [];

    genreIdsString.split(";").forEach((genreId) {
      genreIds.add(int.parse(genreId));
    });

    return genreIds;
  }

  Movie.fromJSON(Map<String, dynamic> map) {
    List<int> receiveGenres = [];

    print(map);

    map['genre_ids'].forEach((v) {
      receiveGenres.add(v);
    });

    id = map['id'];
    title = map['title'];
    originalTitle = map['original_title'];
    originalLanguage = map['original_language'];
    overview = map['overview'] ?? "";
    posterPath = map['poster_path'] ?? "";
    backdropPath = map['backdrop_path'] ?? "";
    releaseDate = map['release_date'] ?? "";
    popularity = map['popularity'] ?? 0.0;
    voteAverage = double.parse(map['vote_average'].toString());
    voteCount = map['vote_count'] ?? 0;
    adult = map['adult'];
    video = map['video'];
    genreIds = receiveGenres;
  }
}
