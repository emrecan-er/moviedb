import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie/models/movie.dart';

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
