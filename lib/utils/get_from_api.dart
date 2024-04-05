import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie/controllers/movie_controller.dart';
import 'package:movie/models/movie.dart';

MovieController controller = Get.put(MovieController());
Future<void> searchMovies(String query) async {
  final url = Uri.parse(
      'https://api.themoviedb.org/3/search/movie?query=$query&include_adult=false&language=en-US&page=1');

  final response = await http.get(
    url,
    headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOGU4MGNkODMyNjUyYWQ0Yjg2NGM1MWM4ZTU4OGFlYyIsInN1YiI6IjY2MGM3OGQ0ZTAzOWYxMDE0OWU0NzExZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.FwXC9wXvJJrOc8_j56Bl-h1fqtk8DjQIbDFxfjy_WwQ',
      'accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    controller.searchedMovies.clear();

    log(controller.search.value.toString());
    final jsonData = jsonDecode(response.body);
    final List<Movie> movies = (jsonData['results'] as List)
        .map((movieJson) => Movie.fromJson(movieJson))
        .toList();
    controller.searchedMovies.assignAll(movies);
    controller.update();
    inspect(movies);
  } else {
    print('Failed to load movies, status code: ${response.statusCode}');
  }
}

Future<List<Movie>> fetchWatchlistMovies() async {
  String apiUrl =
      'https://api.themoviedb.org/3/account/21180495/watchlist/movies?language=en-US&page=1&sort_by=created_at.asc';
  String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOGU4MGNkODMyNjUyYWQ0Yjg2NGM1MWM4ZTU4OGFlYyIsInN1YiI6IjY2MGM3OGQ0ZTAzOWYxMDE0OWU0NzExZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.FwXC9wXvJJrOc8_j56Bl-h1fqtk8DjQIbDFxfjy_WwQ';

  try {
    var response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<Movie> movies = [];
      List<dynamic> jsonData = jsonDecode(response.body)['results'];
      jsonData.forEach((movie) {
        movies.add(Movie.fromJson(movie));
      });
      return movies;
    } else {
      throw Exception('Failed to load watchlist movies');
    }
  } catch (e) {
    throw Exception('Error fetching watchlist movies: $e');
  }
}

void addToWatchlist(String mediaId) async {
  String apiUrl = 'https://api.themoviedb.org/3/account/21180495/watchlist';
  String accessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOGU4MGNkODMyNjUyYWQ0Yjg2NGM1MWM4ZTU4OGFlYyIsInN1YiI6IjY2MGM3OGQ0ZTAzOWYxMDE0OWU0NzExZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.FwXC9wXvJJrOc8_j56Bl-h1fqtk8DjQIbDFxfjy_WwQ';

  try {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'accept': 'application/json',
        'content-type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "media_type": "movie",
        "media_id": mediaId,
        "watchlist": 'true',
      }),
    );
    Get.snackbar('Watchlist', 'The movie succesfully added to watchlist',
        colorText: Colors.white);

    if (response.statusCode == 200) {
      log('geldi');
    } else {}
  } catch (e) {
    print('$e');
  }
}

Future<List<Movie>> fetchMovies() async {
  final String url =
      'https://api.themoviedb.org/3/discover/movie?include_adult=true&include_video=false&language=en-US&page=1&sort_by=popularity.desc';
  final String token =
      dotenv.env['SESSION_KEY']!; //API KEY'I DAHA GUVENLI HALE GETIRDIM

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
      'accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    Iterable list = jsonResponse['results'];
    return list.map((movie) => Movie.fromJson(movie)).toList();
  } else {
    throw Exception('Failed to load movies');
  }
}
