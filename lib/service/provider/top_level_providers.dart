import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import '../../key/api_key.dart';
import '../../model/movie.dart';

final watchListBoxProvider = Provider.autoDispose<Box<Movie>>((_) {
  return Hive.box<Movie>(kWatchList);
});

final currentMovieProvider =
    Provider.autoDispose<Movie>((_) => throw UnimplementedError());
