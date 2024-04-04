import 'dart:developer';

import 'package:get/get.dart';
import 'package:movie/utils/get_from_api.dart';

class MovieController extends GetxController {
  var currentIndex = 0.obs;
  var search = false.obs;
  var searchedMovies = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchMovies();
  }

  onItemTapped(int index) {
    currentIndex.value = index;
    log(currentIndex.value.toString());
  }

  String formatReleaseDate(String? releaseDate) {
    if (releaseDate == null || releaseDate.isEmpty) {
      return '';
    }

    List<String> parts = releaseDate.split('-');

    if (parts.length != 3) {
      return releaseDate;
    }

    try {
      int year = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int day = int.parse(parts[2]);

      if (month < 1 || month > 12 || day < 1 || day > 31) {
        return releaseDate;
      }

      return "$day.$month.$year";
    } catch (e) {
      return releaseDate;
    }
  }
}
