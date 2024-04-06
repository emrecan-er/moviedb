import 'package:hive/hive.dart';
import 'package:movie/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences prefs;

late Box favoriteBox;
late Box watchlistBox;

checkLogin() {
  if (prefs.getString('currentUserId') == null) {
    currentUserId = '';
  } else {
    currentUserId = prefs.getString('currentUserId').toString();
  }
}
