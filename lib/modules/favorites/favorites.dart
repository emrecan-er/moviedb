import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movie/constants.dart';
import 'package:movie/controllers/auth_controller.dart';
import 'package:movie/controllers/movie_controller.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/modules/movie_details/movie_details.dart';
import 'package:movie/modules/search/components/movie_card.dart';
import 'package:movie/modules/watchlist/components/watchlist_card.dart';
import 'package:movie/utils/get_from_api.dart';

class FavoritesScreen extends StatelessWidget {
  AuthController authController = Get.put(AuthController());
  MovieController movieController = Get.put(MovieController());

  FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: kCardColor,
      ),
      backgroundColor: kBackgroundColor,
      body: FutureBuilder<List<Movie>>(
        future: fetchFavoriteMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Lottie.asset('assets/popcorn.json', width: 100));
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else if (snapshot.data!.isEmpty) {
            return const Center(
                child: Text(
              "Henüz favori film eklemediniz.",
              style: TextStyle(color: Colors.white),
            ));
          } else {
            List<Movie> movies = snapshot.data!;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                Movie movie = movies[index];

                return WatchlistCard(
                  dismisibleKey: Key(movie.id.toString()),
                  onDismissed: (direction) {
                    favorites(movie.id.toString(), false, currentUserId);
                  },
                  movieId: movie.id.toString(),
                  releaseDate:
                      movieController.formatReleaseDate(movie.releaseDate),
                  filmName: movie.title,
                  photoUrl: movie.posterPath,
                  rating: movie.voteAverage.toStringAsFixed(1),
                  onTap: () {
                    Get.off(
                      MovieDetails(
                        isFavorite: false,
                        movie: movie,
                        controller: movieController,
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
