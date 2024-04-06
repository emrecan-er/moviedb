import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie/constants.dart';
import 'package:movie/db_helper.dart';
import 'package:movie/modules/auth/login_screen.dart';
import 'package:movie/modules/favorites/db/favorite_model.dart';
import 'package:movie/modules/main/main_screen.dart';
import 'package:movie/modules/watchlist/db/watchlist_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteModelAdapter());
  Hive.registerAdapter(WatchListModelAdapter());

  favoriteBox = await Hive.openBox<FavoriteModel>('favoriteListBox');
  watchlistBox = await Hive.openBox<WatchListModel>('watchlistBox');
  prefs = await SharedPreferences.getInstance();
  currentUserId = prefs.getString('currentUserId').toString();
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //State Managementtan dolayı GetMaterialApp
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'VarelaRound',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: prefs.getString('currentUserId') == null
          ? LoginScreen()
          : MainScreen(),
    );
  }
}
