import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'movie.g.dart';

@HiveType(typeId: 0)
class Movie {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String rating;

  @HiveField(3)
  final String url;

  @HiveField(4)
  final int runtime;

  @HiveField(5)
  final List<String> genres;

  @HiveField(6)
  final String ytTrailerCode;

  @HiveField(7)
  final String smallCoverImage;

  @HiveField(8)
  final String mediumCoverImage;

  @HiveField(9)
  final String largeCoverImage;

  @HiveField(10)
  final int year;

  @HiveField(11)
  final List<Cast> cast;

  @HiveField(12)
  final String descriptionIntro;

  @HiveField(13)
  final String descriptionFull;
  // final String imdbCode;
  // final String titleEnglish;
  // final String titleLong;
  // final String slug;
  // final int downloadCount;
  // final int likeCount;
  // final String language;
  // final String mpaRating;
  // final String backgroundImage;
  // final String backgroundImageOriginal;
  // final String mediumScreenshotImage1;
  // final String mediumScreenshotImage2;
  // final String mediumScreenshotImage3;
  // final String largeScreenshotImage1;
  // final String largeScreenshotImage2;
  // final String largeScreenshotImage3;
  // final List<Torrents> torrents;
  // final String dateUploaded;
  // final int dateUploadedUnix;

  Movie({
    required this.id,
    required this.url,
    required this.title,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.descriptionIntro,
    required this.descriptionFull,
    required this.ytTrailerCode,
    required this.smallCoverImage,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.cast,
    // required this.imdbCode,
    // required this.titleEnglish,
    // required this.titleLong,
    // required this.slug,
    // required this.downloadCount,
    // required this.likeCount,
    // required this.language,
    // required this.mpaRating,
    // required this.backgroundImage,
    // required this.backgroundImageOriginal,
    // required this.mediumScreenshotImage1,
    // required this.mediumScreenshotImage2,
    // required this.mediumScreenshotImage3,
    // required this.largeScreenshotImage1,
    // required this.largeScreenshotImage2,
    // required this.largeScreenshotImage3,
    // required this.torrents,
    // required this.dateUploaded,
    // required this.dateUploadedUnix,
  });

  Movie copyWith({
    int? id,
    String? title,
    String? largeCoverImage,
    List<String>? genres,
    String? rating,
    int? runtime,
    String? ytTrailerCode,
    String? url,
    String? smallCoverImage,
    String? mediumCoverImage,
    int? year,
    List<Cast>? cast,
    String? descriptionIntro,
    String? descriptionFull,
    // String? imdbCode,
    // String? titleEnglish,
    // String? titleLong,
    // String? slug,
    // int? downloadCount,
    // int? likeCount,
    // String? language,
    // String? mpaRating,
    // String? backgroundImage,
    // String? backgroundImageOriginal,
    // String? mediumScreenshotImage1,
    // String? mediumScreenshotImage2,
    // String? mediumScreenshotImage3,
    // String? largeScreenshotImage1,
    // String? largeScreenshotImage2,
    // String? largeScreenshotImage3,
    // List<Torrents>? torrents,
    // String? dateUploaded,
    // int? dateUploadedUnix,
  }) {
    return Movie(
      id: id ?? this.id,
      url: url ?? this.url,
      title: title ?? this.title,
      year: year ?? this.year,
      rating: rating ?? this.rating,
      runtime: runtime ?? this.runtime,
      genres: genres ?? this.genres,
      descriptionIntro: descriptionIntro ?? this.descriptionIntro,
      descriptionFull: descriptionFull ?? this.descriptionFull,
      ytTrailerCode: ytTrailerCode ?? this.ytTrailerCode,
      smallCoverImage: smallCoverImage ?? this.smallCoverImage,
      mediumCoverImage: mediumCoverImage ?? this.mediumCoverImage,
      largeCoverImage: largeCoverImage ?? this.largeCoverImage,
      cast: cast ?? this.cast,
      // imdbCode: imdbCode ?? this.imdbCode,
      // titleEnglish: titleEnglish ?? this.titleEnglish,
      // titleLong: titleLong ?? this.titleLong,
      // slug: slug ?? this.slug,
      // downloadCount: downloadCount ?? this.downloadCount,
      // likeCount: likeCount ?? this.likeCount,
      // language: language ?? this.language,
      // mpaRating: mpaRating ?? this.mpaRating,
      // backgroundImage: backgroundImage ?? this.backgroundImage,
      // backgroundImageOriginal: backgroundImageOriginal ?? this.backgroundImageOriginal,
      // mediumScreenshotImage1: mediumScreenshotImage1 ?? this.mediumScreenshotImage1,
      // mediumScreenshotImage2: mediumScreenshotImage2 ?? this.mediumScreenshotImage2,
      // mediumScreenshotImage3: mediumScreenshotImage3 ?? this.mediumScreenshotImage3,
      // largeScreenshotImage1: largeScreenshotImage1 ?? this.largeScreenshotImage1,
      // largeScreenshotImage2: largeScreenshotImage2 ?? this.largeScreenshotImage2,
      // largeScreenshotImage3: largeScreenshotImage3 ?? this.largeScreenshotImage3,
      // torrents: torrents ?? this.torrents,
      // dateUploaded: dateUploaded ?? this.dateUploaded,
      // dateUploadedUnix: dateUploadedUnix ?? this.dateUploadedUnix,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'title': title,
      'year': year,
      'rating': rating,
      'runtime': runtime,
      'genres': genres,
      'description_intro': descriptionIntro,
      'description_full': descriptionFull,
      'yt_trailer_code': ytTrailerCode,
      'small_cover_image': smallCoverImage,
      'medium_cover_image': mediumCoverImage,
      'large_cover_image': largeCoverImage,
      'cast': cast.map((x) => x.toMap()).toList(),
      // 'download_count': downloadCount,
      // 'imdb_code': imdbCode,
      // 'title_english': titleEnglish,
      // 'title_long': titleLong,
      // 'slug': slug,
      // 'like_count': likeCount,
      // 'language': language,
      // 'backgroundImage': backgroundImage,
      // 'mpa_rating': mpaRating,
      // 'backgroundImageOriginal': backgroundImageOriginal,
      // 'mediumScreenshotImage1': mediumScreenshotImage1,
      // 'mediumScreenshotImage2': mediumScreenshotImage2,
      // 'mediumScreenshotImage3': mediumScreenshotImage3,
      // 'largeScreenshotImage1': largeScreenshotImage1,
      // 'largeScreenshotImage2': largeScreenshotImage2,
      // 'largeScreenshotImage3': largeScreenshotImage3,
      // 'torrents': torrents.map((x) => x.toMap()).toList(),
      // 'dateUploaded': dateUploaded,
      // 'dateUploadedUnix': dateUploadedUnix,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      url: map['url'] ?? '',
      title: map['title'] ?? '',
      year: map['year'] as int,
      rating: map['rating'] == null ? '0.0' : map['rating'].toString(),
      runtime: map['runtime'] as int,
      cast: map['cast'] == null
          ? []
          : List<Cast>.from((map['cast'] as List<dynamic>)
              .map((e) => Cast.fromMap(e as Map<String, dynamic>))
              .toList()),
      descriptionIntro: map['description_intro'] ?? '',
      descriptionFull: map['description_full'] ?? '',
      ytTrailerCode: map['yt_trailer_code'] ?? '',
      smallCoverImage: map['small_cover_image'] ?? '',
      mediumCoverImage: map['medium_cover_image'] ?? '',
      largeCoverImage: map['large_cover_image'] ?? '',
      genres: map['genres'] == null
          ? []
          : List<String>.from(
              (map['genres'] as List<dynamic>).map((e) => '$e').toList()),
      // imdbCode: map['imdbCode'] as String,
      // titleEnglish: map['titleEnglish'] as String,
      // titleLong: map['titleLong'] as String,
      // slug: map['slug'] as String,
      // downloadCount: map['downloadCount'] as int,
      // likeCount: map['likeCount'] as int,
      // language: map['language'] as String,
      // mpaRating: map['mpaRating'] as String,
      // backgroundImage: map['backgroundImage'] as String,
      // backgroundImageOriginal: map['backgroundImageOriginal'] as String,
      // mediumScreenshotImage1: map['mediumScreenshotImage1'] as String,
      // mediumScreenshotImage2: map['mediumScreenshotImage2'] as String,
      // mediumScreenshotImage3: map['mediumScreenshotImage3'] as String,
      // largeScreenshotImage1: map['largeScreenshotImage1'] as String,
      // largeScreenshotImage2: map['largeScreenshotImage2'] as String,
      // largeScreenshotImage3: map['largeScreenshotImage3'] as String,
      // torrents: List<Torrents>.from((map['torrents'] as List<int>).map<Torrents>((x) => Torrents.fromMap(x as Map<String,dynamic>),),),
      // dateUploaded: map['dateUploaded'] as String,
      // dateUploadedUnix: map['dateUploadedUnix'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) =>
      Movie.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Movie(id: $id, title: $title, rating: $rating, url: $url, runtime: $runtime, genres: $genres, ytTrailerCode: $ytTrailerCode, smallCoverImage: $smallCoverImage, mediumCoverImage: $mediumCoverImage, largeCoverImage: $largeCoverImage, year: $year, cast: $cast, descriptionIntro: $descriptionIntro, descriptionFull: $descriptionFull)';
  }

  @override
  bool operator ==(covariant Movie other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.rating == rating &&
        other.url == url &&
        other.runtime == runtime &&
        listEquals(other.genres, genres) &&
        other.ytTrailerCode == ytTrailerCode &&
        other.smallCoverImage == smallCoverImage &&
        other.mediumCoverImage == mediumCoverImage &&
        other.largeCoverImage == largeCoverImage &&
        other.year == year &&
        listEquals(other.cast, cast) &&
        other.descriptionIntro == descriptionIntro &&
        other.descriptionFull == descriptionFull;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        rating.hashCode ^
        url.hashCode ^
        runtime.hashCode ^
        genres.hashCode ^
        ytTrailerCode.hashCode ^
        smallCoverImage.hashCode ^
        mediumCoverImage.hashCode ^
        largeCoverImage.hashCode ^
        year.hashCode ^
        cast.hashCode ^
        descriptionIntro.hashCode ^
        descriptionFull.hashCode;
  }
}

class Cast {
  final String name;
  final String characterName;
  final String urlSmallImage;
  final String imdbCode;

  Cast({
    required this.name,
    required this.characterName,
    required this.urlSmallImage,
    required this.imdbCode,
  });

  Cast copyWith({
    String? name,
    String? characterName,
    String? urlSmallImage,
    String? imdbCode,
  }) {
    return Cast(
      name: name ?? this.name,
      characterName: characterName ?? this.characterName,
      urlSmallImage: urlSmallImage ?? this.urlSmallImage,
      imdbCode: imdbCode ?? this.imdbCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'character_name': characterName,
      'url_small_image': urlSmallImage,
      'imdbCode': imdbCode,
    };
  }

  factory Cast.fromMap(Map<String, dynamic> map) {
    return Cast(
      name: map['name'] ?? '',
      characterName: map['character_name'] ?? '',
      urlSmallImage: map['url_small_image'] ?? '',
      imdbCode: map['imdbCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Cast.fromJson(String source) =>
      Cast.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cast(name: $name, characterName: $characterName, urlSmallImage: $urlSmallImage, imdbCode: $imdbCode)';
  }

  @override
  bool operator ==(covariant Cast other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.characterName == characterName &&
        other.urlSmallImage == urlSmallImage &&
        other.imdbCode == imdbCode;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        characterName.hashCode ^
        urlSmallImage.hashCode ^
        imdbCode.hashCode;
  }
}

class Data {
  Movie? movie;

  Data({this.movie});

  Data.fromJson(Map<String, dynamic> json) {
    movie = (json['movie'] != null ? Movie.fromJson(json['movie']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['movie'] = movie?.toJson();
    return data;
  }
}


// class Torrents {
//   final String url;
//   final String hash;
//   final String quality;
//   final String type;
//   final int seeds;
//   final int peers;
//   final String size;
//   final int sizeBytes;
//   final String dateUploaded;
//   final int dateUploadedUnix;

//   Torrents({
//     required this.url,
//     required this.hash,
//     required this.quality,
//     required this.type,
//     required this.seeds,
//     required this.peers,
//     required this.size,
//     required this.sizeBytes,
//     required this.dateUploaded,
//     required this.dateUploadedUnix,
//   });

//   Torrents copyWith({
//     String? url,
//     String? hash,
//     String? quality,
//     String? type,
//     int? seeds,
//     int? peers,
//     String? size,
//     int? sizeBytes,
//     String? dateUploaded,
//     int? dateUploadedUnix,
//   }) {
//     return Torrents(
//       url: url ?? this.url,
//       hash: hash ?? this.hash,
//       quality: quality ?? this.quality,
//       type: type ?? this.type,
//       seeds: seeds ?? this.seeds,
//       peers: peers ?? this.peers,
//       size: size ?? this.size,
//       sizeBytes: sizeBytes ?? this.sizeBytes,
//       dateUploaded: dateUploaded ?? this.dateUploaded,
//       dateUploadedUnix: dateUploadedUnix ?? this.dateUploadedUnix,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'url': url,
//       'hash': hash,
//       'quality': quality,
//       'type': type,
//       'seeds': seeds,
//       'peers': peers,
//       'size': size,
//       'size_bytes': sizeBytes,
//       'date_uploaded': dateUploaded,
//       'date_uploaded_unix': dateUploadedUnix,
//     };
//   }

//   factory Torrents.fromMap(Map<String, dynamic> map) {
//     return Torrents(
//       url: map['url'] as String,
//       hash: map['hash'] as String,
//       quality: map['quality'] as String,
//       type: map['type'] as String,
//       seeds: map['seeds'] as int,
//       peers: map['peers'] as int,
//       size: map['size'] as String,
//       sizeBytes: map['size_bytes'] as int,
//       dateUploaded: map['date_uploaded'] as String,
//       dateUploadedUnix: map['date_uploaded_unix'] as int,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Torrents.fromJson(String source) =>
//       Torrents.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'Torrents(url: $url, hash: $hash, quality: $quality, type: $type, seeds: $seeds, peers: $peers, size: $size, sizeBytes: $sizeBytes, dateUploaded: $dateUploaded, dateUploadedUnix: $dateUploadedUnix)';
//   }

//   @override
//   bool operator ==(covariant Torrents other) {
//     if (identical(this, other)) return true;

//     return other.url == url &&
//         other.hash == hash &&
//         other.quality == quality &&
//         other.type == type &&
//         other.seeds == seeds &&
//         other.peers == peers &&
//         other.size == size &&
//         other.sizeBytes == sizeBytes &&
//         other.dateUploaded == dateUploaded &&
//         other.dateUploadedUnix == dateUploadedUnix;
//   }

//   @override
//   int get hashCode {
//     return url.hashCode ^
//         hash.hashCode ^
//         quality.hashCode ^
//         type.hashCode ^
//         seeds.hashCode ^
//         peers.hashCode ^
//         size.hashCode ^
//         sizeBytes.hashCode ^
//         dateUploaded.hashCode ^
//         dateUploadedUnix.hashCode;
//   }
// }



// class DecodeMovieDetails {
//   final String status;
//   final String statusMessage;
//   final Data data;

//   DecodeMovieDetails({
//     required this.status,
//     required this.statusMessage,
//     required this.data,
//   });

//   DecodeMovieDetails.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     statusMessage = json['status_message'];
//     data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['status_message'] = statusMessage;
//     data['data'] = this.data.toJson();
//     return data;
//   }
// }