// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieAdapter extends TypeAdapter<Movie> {
  @override
  final int typeId = 0;

  @override
  Movie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Movie(
      id: fields[0] as int,
      url: fields[3] as String,
      title: fields[1] as String,
      year: fields[10] as int,
      rating: fields[2] as String,
      runtime: fields[4] as int,
      genres: (fields[5] as List).cast<String>(),
      descriptionIntro: fields[12] as String,
      descriptionFull: fields[13] as String,
      ytTrailerCode: fields[6] as String,
      smallCoverImage: fields[7] as String,
      mediumCoverImage: fields[8] as String,
      largeCoverImage: fields[9] as String,
      cast: (fields[11] as List).cast<Cast>(),
    );
  }

  @override
  void write(BinaryWriter writer, Movie obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.rating)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.runtime)
      ..writeByte(5)
      ..write(obj.genres)
      ..writeByte(6)
      ..write(obj.ytTrailerCode)
      ..writeByte(7)
      ..write(obj.smallCoverImage)
      ..writeByte(8)
      ..write(obj.mediumCoverImage)
      ..writeByte(9)
      ..write(obj.largeCoverImage)
      ..writeByte(10)
      ..write(obj.year)
      ..writeByte(11)
      ..write(obj.cast)
      ..writeByte(12)
      ..write(obj.descriptionIntro)
      ..writeByte(13)
      ..write(obj.descriptionFull);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
