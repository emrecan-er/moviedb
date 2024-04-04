import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/constants.dart';
import 'package:movie/controllers/movie_controller.dart';
import 'package:movie/modules/favorites/favorites.dart';
import 'package:movie/modules/search/components/movie_card.dart';
import 'package:movie/modules/search/search_screen.dart';
import 'package:movie/modules/watchlist/watchlist.dart';

class MainScreen extends StatelessWidget {
  MovieController controller = Get.put(MovieController());
  static final List<Widget> _screenList = <Widget>[
    SearchScreen(),
    WatchlistScreen(),
    Favorites(),
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => _screenList[controller.currentIndex.value],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          unselectedItemColor: Colors.white38,
          backgroundColor: kBackgroundColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Watchlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
          currentIndex: controller.currentIndex.value,
          selectedItemColor: Colors.white,
          onTap: (index) => controller.onItemTapped(index),
        ),
      ),
    );
  }
}
