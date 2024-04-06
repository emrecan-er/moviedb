import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movie/constants.dart';
import 'package:movie/controllers/auth_controller.dart';
import 'package:movie/controllers/movie_controller.dart';
import 'package:movie/db_helper.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/modules/auth/login_screen.dart';
import 'package:movie/modules/favorites/components/local_favorite_card.dart';
import 'package:movie/modules/favorites/db/favorite_model.dart';
import 'package:movie/modules/movie_details/movie_details.dart';
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
        title: Text('Favorites'),
        actions: [
          IconButton(
              splashRadius: 2,
              onPressed: () {
                prefs.remove('currentUserId');
                Get.snackbar(
                  'Successful',
                  'Logged Out',
                  colorText: Colors.white,
                );
                Get.offAll(LoginScreen());
              },
              icon: Icon(Icons.logout))
        ],
        backgroundColor: kCardColor,
      ),
      backgroundColor: kBackgroundColor,
      body: FutureBuilder<List<Movie>>(
        future: fetchFavoriteMovies(currentUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Lottie.asset('assets/popcorn.json', width: 100));
          } else if (snapshot.hasError) {
            //Internet yoksa localden veri çekecek.
            return ListView.builder(
                itemCount: favoriteBox.length,
                itemBuilder: (context, index) {
                  FavoriteModel favoriteModel = favoriteBox.getAt(index);
                  return LocalFavoriteModel(
                      favoriteModel: favoriteModel,
                      movieController: movieController);
                });
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

                favoriteBox.put(
                    index,
                    FavoriteModel(
                      movieDate: movie.releaseDate,
                      movieDesc: movie.overview,
                      movieTitle: movie.title,
                      rating: movie.voteAverage.toString(),
                    ));

                return WatchlistCard(
                  dismisibleKey: Key(movie.id.toString()),
                  onDismissed: (direction) {
                    favorites(movie.id.toString(), false, currentUserId);
                    favoriteBox.deleteAt(index);
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
                        movie: movie,
                        controller: movieController,
                      ),
                    );
                    movieController.favoriteMovie.value = true;
                    //Favoriler ekranında olduğumuz için bu değeri true yapıyorum.Details ekranında icon değişsin diye.
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
