import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/constants.dart';
import 'package:movie/modules/movie_details/movie_details.dart';
import 'package:movie/utils/get_from_api.dart';

class WatchlistCard extends StatelessWidget {
  String releaseDate;
  String filmName;
  dynamic dismisibleKey;
  Function(DismissDirection direction) onDismissed;
  String photoUrl;
  String movieId;
  String rating;
  Function() onTap;
  WatchlistCard({
    required this.dismisibleKey,
    required this.onDismissed,
    required this.releaseDate,
    required this.filmName,
    required this.movieId,
    required this.onTap,
    required this.photoUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: Get.width,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Remove',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
      key: dismisibleKey,
      onDismissed: onDismissed,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            width: Get.width,
            height: 100,
            decoration: BoxDecoration(
              color: kCardColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                      child: photoUrl == ''
                          ? Image.network(
                              'https://motivatevalmorgan.com/wp-content/uploads/2016/06/default-movie-768x1129.jpg',
                              fit: BoxFit.contain,
                              height: 100,
                            )
                          : Image.network(
                              'http://image.tmdb.org/t/p/w500/' + photoUrl,
                              fit: BoxFit.contain,
                              height: 100,
                            ),
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          filmName.length > 50
                              ? filmName.substring(0, 20) + '...'
                              : filmName,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            rating,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.white,
                            size: 14,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            releaseDate,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        children: [],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
