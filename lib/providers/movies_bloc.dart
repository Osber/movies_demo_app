import 'package:flutter/foundation.dart';
import 'package:movies_demo_app/api/service.dart';
import 'package:movies_demo_app/api/models/models.dart';

class MoviesBloc extends ChangeNotifier {
  final Service _service = RemoteService();

  List<MovieModel> _allMovies;
  List<MovieModel> get allMovies => _allMovies;

  List<Genre> _genres;
  List<Genre> get allGenres => _genres;

  MovieModel _movieModel;

  get movie => _movieModel.movie;

  get genres => _movieModel.genres;

  set movieModel(MovieModel newMovie) {
    print(newMovie.movie.title);
    _movieModel = newMovie;
    notifyListeners();
  }

  int _index = 0;

  double _page = 0.0;

  get index => _index;

  get page => _page;

  set page(double newPage) {
    _page = newPage;
    notifyListeners();
  }

  set index(int newIdex) {
    _index = newIdex;
    notifyListeners();
  }

  Future<List<MovieModel>> getList() async {
    List<Movie> movies = await _service.fetchMovies();
    List<Genre> _genres = await _service.fetchGenres();

    _allMovies = movies
        .map((movie) => _getMovieAndSpecificGenres(movie, _genres))
        .toList();

    notifyListeners();
    return _allMovies;
  }

  MovieModel _getMovieAndSpecificGenres(Movie movie, List<Genre> genres) {
    final movieGenres = movie.genreIds
        .map((id) => genres.firstWhere((genre) => genre.id == id))
        .toList();
    return MovieModel(movie: movie, genres: movieGenres);
  }
}
