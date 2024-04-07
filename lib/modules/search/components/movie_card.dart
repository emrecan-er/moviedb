import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/constants.dart';
import 'package:movie/controllers/auth_controller.dart';
import 'package:movie/utils/get_from_api.dart';

class MovieCard extends StatelessWidget {
  AuthController authController = Get.put(AuthController());
  String releaseDate;
  String filmName;
  String photoUrl;
  String movieId;
  String rating;
  Function() onTap;
  MovieCard({
    required this.releaseDate,
    required this.filmName,
    required this.movieId,
    required this.onTap,
    required this.photoUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: Get.width,
          height: 180,
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
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                    child: photoUrl == ''
                        ? Image.network(
                            'https://motivatevalmorgan.com/wp-content/uploads/2016/06/default-movie-768x1129.jpg',
                            fit: BoxFit.contain,
                            height: 180,
                          )
                        : Image.network(
                            'http://image.tmdb.org/t/p/w500/' + photoUrl,
                            fit: BoxFit.contain,
                            height: 180,
                          ),
                  )
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        filmName.length > 50
                            ? filmName.substring(0, 20) + '...'
                            : filmName,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white54),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.white,
                            size: 19,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            releaseDate,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          rating,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kButtonColor,
                            ),
                            onPressed: () {
                              watchlist(
                                movieId,
                                true,
                                currentUserId,
                              );
                            },
                            child: const Text(
                              'Add To Watchlist',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
