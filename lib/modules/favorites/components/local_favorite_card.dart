import 'package:flutter/material.dart';
import 'package:movie/constants.dart';
import 'package:movie/controllers/movie_controller.dart';
import 'package:movie/modules/favorites/db/favorite_model.dart';

class LocalFavoriteModel extends StatelessWidget {
  const LocalFavoriteModel({
    super.key,
    required this.favoriteModel,
    required this.movieController,
  });

  final FavoriteModel favoriteModel;
  final MovieController movieController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tileColor: kCardColor,
        title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    favoriteModel.movieTitle,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                Text(
                  movieController.formatReleaseDate(
                    favoriteModel.movieDate,
                  ),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            )),
        subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            favoriteModel.movieDesc,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
