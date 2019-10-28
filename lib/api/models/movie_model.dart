import 'genre.dart';
import 'movie.dart';

class MovieModel {
  final Movie movie;
  final List<Genre> genres;

  const MovieModel({this.movie, this.genres});
}
