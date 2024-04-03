import 'dart:developer';

import 'package:get/get.dart';
import 'package:movie/utils/get_from_api.dart';

class MovieController extends GetxController {
  var currentIndex = 0.obs;

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

  String formatReleaseDate(String releaseDate) {
    List<String> parts = releaseDate.split('-');
    return "${parts[2]}.${parts[1]}.${parts[0]}";
  }
}
