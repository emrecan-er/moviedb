import 'package:hive/hive.dart';
part 'favorite_model.g.dart';

@HiveType(typeId: 0)
class FavoriteModel {
  FavoriteModel(
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
