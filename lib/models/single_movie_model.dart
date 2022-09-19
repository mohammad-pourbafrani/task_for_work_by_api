class SingleMovieModel {
  int? id;
  String? title;
  String? poster;
  String? year;
  String? rated;
  String? released;
  String? runtime;
  String? director;
  String? writer;
  List<dynamic>? actors;
  String? plot;
  String? country;
  List<dynamic>? awards;
  String? imdbRating;
  String? imdbVotes;
  String? imdbId;
  List<dynamic>? genres;

  SingleMovieModel({
    this.id,
    this.title,
    this.poster,
    this.year,
    this.rated,
    this.released,
    this.runtime,
    this.director,
    this.writer,
    this.actors,
    this.plot,
    this.country,
    this.awards,
    this.imdbRating,
    this.imdbVotes,
    this.imdbId,
    this.genres,
  });

  SingleMovieModel.fromJson(Map<String, dynamic> element) {
    id = element["id"];
    title = element["title"];
    poster = element["poster"];
    year = element["year"];
    rated = element["rated"];
    released = element["released"];
    runtime = element["runtime"];
    director = element["director"];
    writer = element["writer"];
    actors = element["actors"].toString().split(',');
    plot = element["plot"];
    country = element["country"];
    awards = element["awards"].toString().split('. ');
    imdbRating = element["imdb_rating"];
    imdbVotes = element["imdb_votes"];
    imdbId = element["imdb_id"];
    genres = element["genres"];
  }
}
