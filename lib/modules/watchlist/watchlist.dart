import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movie/constants.dart';
import 'package:movie/controllers/movie_controller.dart';
import 'package:movie/db_helper.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/modules/favorites/db/favorite_model.dart';
import 'package:movie/modules/movie_details/movie_details.dart';
import 'package:movie/modules/watchlist/components/local_watchlist_card.dart';
import 'package:movie/modules/watchlist/components/watchlist_card.dart';
import 'package:movie/modules/watchlist/db/watchlist_model.dart';
import 'package:movie/utils/get_from_api.dart';

class WatchlistScreen extends StatelessWidget {
  MovieController controller = Get.put(MovieController());

  WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        backgroundColor: kCardColor,
      ),
      backgroundColor: kBackgroundColor,
      body: FutureBuilder<List<Movie>>(
        future: fetchWatchlistMovies(currentUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Lottie.asset('assets/popcorn.json', width: 100));
          } else if (snapshot.hasError) {
            //Internet yoksa localden veri çekecek.
            return ListView.builder(
                itemCount: watchlistBox.length,
                itemBuilder: (context, index) {
                  WatchListModel watchListModel = watchlistBox.getAt(index);
                  return LocalWatchlistCard(
                      watchListModel: watchListModel, controller: controller);
                });
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No data available"));
          } else {
            List<Movie> movies = snapshot.data!;

            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                Movie movie = movies[index];
                watchlistBox.put(
                    index,
                    WatchListModel(
                      movieDate: movie.releaseDate,
                      movieDesc: movie.overview,
                      movieTitle: movie.title,
                      rating: movie.voteAverage.toString(),
                    ));

                return WatchlistCard(
                  movieId: movie.id.toString(),
                  releaseDate: controller.formatReleaseDate(movie.releaseDate),
                  filmName: movie.title,
                  photoUrl: movie.posterPath,
                  rating: movie.voteAverage.toStringAsFixed(1),
                  onTap: () {
                    Get.off(MovieDetails(
                      movie: movie,
                      controller: controller,
                    ));
                  },
                  dismisibleKey: Key(movie.id.toString()),
                  onDismissed: (DismissDirection direction) {
                    watchlist(movie.id.toString(), false, currentUserId);
                    watchlistBox.deleteAt(index);
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
