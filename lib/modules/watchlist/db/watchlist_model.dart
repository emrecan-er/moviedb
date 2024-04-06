import 'package:hive/hive.dart';
part 'watchlist_model.g.dart';

@HiveType(typeId: 1)
class WatchListModel {
  WatchListModel(
      {required this.movieDate,
      required this.movieDesc,
      required this.movieTitle,
      required this.rating});
  @HiveField(0)
  String movieTitle;
  @HiveField(1)
  String movieDesc;
  @HiveField(2)
  String movieDate;
  @HiveField(3)
  String rating;
}
