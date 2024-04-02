import 'package:get/get.dart';

class FilmController extends GetxController {
  String formatReleaseDate(String releaseDate) {
    List<String> parts = releaseDate.split('-');
    return "${parts[2]}.${parts[1]}.${parts[0]}";
  }
}
