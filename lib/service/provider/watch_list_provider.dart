import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../key/api_key.dart';

Box box = Hive.box(kAppName);
List totalWatchlist = box.get('watchlist');

class FavoriteNotifier extends StateNotifier<List> {
  FavoriteNotifier() : super(totalWatchlist);

  void addFavorite(Map movie) {
    state = [...state, movie];
    box.put('watchlist', state);
  }

  void removeFavorite(Map movie) {
    state = state.where((element) => element['id'] != movie['id']).toList();
    box.put('watchlist', state);
  }

  void clearFavorite() {
    state = [];
    box.put('watchlist', state);
  }

  bool isFavorite(Map movie) {
    return state.any((element) => element['id'] == movie['id']);
  }

  int get totalFavorite => state.length;

  List get favorite => state;

  void updateFavorite(List movie) {
    state = movie;
    box.put('watchlist', state);
  }

  void updateFavoriteById(Map movie) {
    state = state.map((e) {
      if (e['id'] == movie['id']) {
        return movie;
      } else {
        return e;
      }
    }).toList();
    box.put('watchlist', state);
  }

  void toggleFavorite(Map movie) {
    if (isFavorite(movie)) {
      removeFavorite(movie);
    } else {
      addFavorite(movie);
    }
  }

  // total favorite

  // void updateFavoriteByIdAndKey(Map movie, String key) {
  //   state = state.map((e) {
  //     if (e['id'] == movie['id']) {
  //       e[key] = movie[key];
  //       return e;
  //     } else {
  //       return e;
  //     }
  //   }).toList();
  //   box.put('watchlist', state);
  // }

  // void updateFavoriteByIdAndKeyAndValue(Map movie, String key, dynamic value) {
  //   state = state.map((e) {
  //     if (e['id'] == movie['id']) {
  //       e[key] = value;
  //       return e;
  //     } else {
  //       return e;
  //     }
  //   }).toList();
  //   box.put('watchlist', state);
  // }

}

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, List>((ref) {
  return FavoriteNotifier();
});
