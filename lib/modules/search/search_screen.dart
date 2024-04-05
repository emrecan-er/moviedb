import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movie/constants.dart';
import 'package:movie/controllers/movie_controller.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/modules/movie_details/movie_details.dart';
import 'package:movie/modules/search/components/custom_text_field.dart';
import 'package:movie/modules/search/components/movie_card.dart';
import 'package:movie/utils/get_from_api.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  MovieController controller = Get.put(MovieController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFormField(
              prefixIcon: Icons.search_rounded,
              hint: 'Search',
              obscureText: false,
              onChanged: (input) {
                searchMovies(input);
              },
            ),
            Obx(
              () => controller.searchedMovies.isNotEmpty
                  ? Expanded(
                      child: Obx(() {
                        return ListView.builder(
                          itemCount: controller.searchedMovies.length,
                          itemBuilder: (context, index) {
                            Movie movie = controller.searchedMovies[index];
                            return MovieCard(
                              movieId: movie.id.toString(),
                              releaseDate: controller
                                  .formatReleaseDate(movie.releaseDate),
                              filmName: movie.title,
                              photoUrl: movie.posterPath,
                              rating: movie.voteAverage.toStringAsFixed(1),
                              onTap: () {
                                Get.off(MovieDetails(
                                  movie: movie,
                                  controller: controller,
                                ));
                              },
                            );
                          },
                        );
                      }),
                    )
                  : Expanded(
                      child: FutureBuilder<List<Movie>>(
                        future: fetchMovies(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: Lottie.asset('assets/popcorn.json',
                                    width: 100));
                          } else if (snapshot.hasError) {
                            return Center(child: Text("${snapshot.error}"));
                          } else if (!snapshot.hasData) {
                            return const Center(
                                child: Text("No data available"));
                          } else {
                            List<Movie> movies = snapshot.data!;
                            return ListView.builder(
                              itemCount: movies.length,
                              itemBuilder: (context, index) {
                                Movie movie = movies[index];

                                return MovieCard(
                                  movieId: movie.id.toString(),
                                  releaseDate: controller
                                      .formatReleaseDate(movie.releaseDate),
                                  filmName: movie.title,
                                  photoUrl: movie.posterPath,
                                  rating: movie.voteAverage.toStringAsFixed(1),
                                  onTap: () {
                                    Get.off(MovieDetails(
                                      movie: movie,
                                      controller: controller,
                                    ));
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
