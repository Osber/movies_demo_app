import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_demo_app/api/models/movie.dart';
import 'package:movies_demo_app/api/models/genre.dart';

String apiKey = 'Insert here your api key';

mixin Service {
  Future<List<Movie>> fetchMovies();

  Future<List<Genre>> fetchGenres();
}

class RemoteService implements Service {
  String _baseUrl = "api.themoviedb.org";
  var _queryParameters = {'api_key': apiKey, 'total_results': 10.toString()};

  @override
  Future<List<Movie>> fetchMovies() async {
    var movies = [];
    try {
      final response = await _httpGet("/3/movie/popular", _queryParameters);
      movies = json.decode(response.body)["results"];
    } catch (e) {
      print(e);
    }

    return Movie.fromJsonToList(movies);
  }

  @override
  Future<List<Genre>> fetchGenres() async {
    final response = await _httpGet("/3/genre/movie/list", _queryParameters);
    final genres = json.decode(response.body)["genres"];

    return Genre.fromJsonToList(genres);
  }

  _httpGet(String path, Map<String, String> queryParams) async =>
      await http.get(Uri.https(_baseUrl, path, queryParams));
}
