import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/constants.dart';

class FilmCard extends StatelessWidget {
  String categories;
  String filmName;
  String photoUrl;
  String rating;
  FilmCard({
    required this.categories,
    required this.filmName,
    required this.photoUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: Get.width,
        height: 200,
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
                  child: Image.network(
                    photoUrl,
                    fit: BoxFit.contain,
                    height: 200,
                  ),
                )
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      categories,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      filmName,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Row(
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
                            fontSize: 16),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kButtonColor,
                          ),
                          onPressed: () {},
                          child: Text(
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
    );
  }
}
