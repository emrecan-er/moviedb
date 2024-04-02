import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import 'package:movie/constants.dart';
import 'package:movie/modules/search/components/custom_text_field.dart';
import 'package:movie/modules/search/components/film_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomFormField(
              hint: 'Search',
              obscureText: false,
              onChanged: (input) {},
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return FilmCard(
                    categories: 'Action Comedy Super Hero',
                    filmName: 'Spidermans',
                    photoUrl:
                        'https://m.media-amazon.com/images/M/MV5BZDEyN2NhMjgtMjdhNi00MmNlLWE5YTgtZGE4MzNjMTRlMGEwXkEyXkFqcGdeQXVyNDUyOTg3Njg@._V1_.jpg',
                    rating: '8.7',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
