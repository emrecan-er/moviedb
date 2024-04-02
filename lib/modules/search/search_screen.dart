import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/constants.dart';
import 'package:movie/controllers/film_controller.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/modules/search/components/custom_text_field.dart';
import 'package:movie/modules/search/components/film_card.dart';
import 'package:movie/utils/get_from_api.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  FilmController controller = Get.put(FilmController());
  @override
  Widget build(BuildContext context) {
    fetchMovies();
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomFormField(
              hint: 'Search',
              obscureText: false,
              onChanged: (input) {},
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Popular',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Movie>>(
                future: fetchMovies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text("No data available"));
                  } else {
                    List<Movie> movies = snapshot.data!;
                    return ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        Movie movie = movies[index];
                        return FilmCard(
                          releaseDate:
                              controller.formatReleaseDate(movie.releaseDate),
                          filmName: movie.title,
                          photoUrl: movie.posterPath,
                          rating: movie.voteAverage.toStringAsFixed(1),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
