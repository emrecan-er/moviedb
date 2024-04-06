import 'package:flutter/material.dart';
import 'package:movie/constants.dart';
import 'package:movie/controllers/movie_controller.dart';
import 'package:movie/modules/watchlist/db/watchlist_model.dart';

class LocalWatchlistCard extends StatelessWidget {
  const LocalWatchlistCard({
    super.key,
    required this.watchListModel,
    required this.controller,
  });

  final WatchListModel watchListModel;
  final MovieController controller;

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
                Text(
                  watchListModel.movieTitle,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  controller.formatReleaseDate(
                    watchListModel.movieDate,
                  ),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            )),
        subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            watchListModel.movieDesc,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
