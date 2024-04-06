// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WatchListModelAdapter extends TypeAdapter<WatchListModel> {
  @override
  final int typeId = 1;

  @override
  WatchListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WatchListModel(
      movieDate: fields[2] as String,
      movieDesc: fields[1] as String,
      movieTitle: fields[0] as String,
      rating: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WatchListModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.movieTitle)
      ..writeByte(1)
      ..write(obj.movieDesc)
      ..writeByte(2)
      ..write(obj.movieDate)
      ..writeByte(3)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
